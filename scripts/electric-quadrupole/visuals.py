import math
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = PROJECT_ROOT / "build" / "visual-output" / "electric-quadrupole"

P_ANGLE = math.radians(68)
P_DIRECTION = (math.cos(P_ANGLE), math.sin(P_ANGLE))
C_HALF_VECTOR = (0.50, 0.0)
P_HALF_VECTOR = (
    0.42 * P_DIRECTION[0],
    0.42 * P_DIRECTION[1],
)
SEED_RADIUS = 0.035
CAPTURE_RADIUS = 0.045
INTEGRATION_STEP = 0.006
MAX_STEPS = 30_000
OUTPUT_SAMPLES = 220
FOUR_CHARGE_SEED_ANGLES = tuple(range(-165, 180, 30))
PANEL_X_LIMIT = 2.32
PANEL_Z_LIMIT = 1.58


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def scale(vector, factor):
    return (vector[0] * factor, vector[1] * factor)


def distance(a, b):
    return math.hypot(a[0] - b[0], a[1] - b[1])


def four_charge_positions():
    c_x, c_z = C_HALF_VECTOR
    p_x, p_z = P_HALF_VECTOR
    return (
        (c_x + p_x, c_z + p_z, 1),
        (-c_x + p_x, -c_z + p_z, -1),
        (c_x - p_x, c_z - p_z, -1),
        (-c_x - p_x, -c_z - p_z, 1),
    )


def four_charge_normalized_field(point):
    """Exact field direction of four checkerboard charges."""
    x, z = point
    ex = 0.0
    ez = 0.0
    for charge_x, charge_z, charge in four_charge_positions():
        dx = x - charge_x
        dz = z - charge_z
        radius = math.hypot(dx, dz)
        ex += charge * dx / radius**3
        ez += charge * dz / radius**3
    magnitude = math.hypot(ex, ez)
    return (ex / magnitude, ez / magnitude)


def rk4_step(point, step, field):
    k1 = field(point)
    k2 = field(add(point, scale(k1, step / 2)))
    k3 = field(add(point, scale(k2, step / 2)))
    k4 = field(add(point, scale(k3, step)))
    average = (
        (k1[0] + 2 * k2[0] + 2 * k3[0] + k4[0]) / 6,
        (k1[1] + 2 * k2[1] + 2 * k3[1] + k4[1]) / 6,
    )
    return add(point, scale(average, step))


def integrate_four_charge_line(seed_angle_degrees):
    angle = math.radians(seed_angle_degrees)
    positive_x, positive_z, _ = four_charge_positions()[0]
    point = (
        positive_x + SEED_RADIUS * math.cos(angle),
        positive_z + SEED_RADIUS * math.sin(angle),
    )
    curve = [point]
    negative_charges = tuple(
        (charge_x, charge_z)
        for charge_x, charge_z, charge in four_charge_positions()
        if charge < 0
    )

    for _ in range(MAX_STEPS):
        point = rk4_step(point, INTEGRATION_STEP, four_charge_normalized_field)
        curve.append(point)
        if any(distance(point, charge) <= CAPTURE_RADIUS for charge in negative_charges):
            break
        if abs(point[0]) > 80 or abs(point[1]) > 80:
            raise RuntimeError(
                f"field line seeded at {seed_angle_degrees} degrees escaped the diagram"
            )
    else:
        raise RuntimeError(
            f"field line seeded at {seed_angle_degrees} degrees did not terminate"
        )

    return curve


def cumulative_lengths(curve):
    lengths = [0.0]
    for first, second in zip(curve, curve[1:]):
        lengths.append(lengths[-1] + distance(first, second))
    return lengths


def point_at_length(curve, lengths, target):
    if target <= 0:
        return curve[0]
    if target >= lengths[-1]:
        return curve[-1]

    low, high = 0, len(lengths) - 1
    while high - low > 1:
        middle = (low + high) // 2
        if lengths[middle] < target:
            low = middle
        else:
            high = middle

    segment_length = lengths[high] - lengths[low]
    fraction = (target - lengths[low]) / segment_length
    return add(
        curve[low],
        scale(
            (curve[high][0] - curve[low][0], curve[high][1] - curve[low][1]),
            fraction,
        ),
    )


def resample(curve, sample_count=OUTPUT_SAMPLES):
    lengths = cumulative_lengths(curve)
    total = lengths[-1]
    return [
        point_at_length(curve, lengths, total * i / (sample_count - 1))
        for i in range(sample_count)
    ]


def clip_segment_to_panel(first, second):
    """Liang-Barsky clipping for one segment against the panel rectangle."""
    dx = second[0] - first[0]
    dz = second[1] - first[1]
    start = 0.0
    end = 1.0
    boundaries = (
        (-dx, first[0] + PANEL_X_LIMIT),
        (dx, PANEL_X_LIMIT - first[0]),
        (-dz, first[1] + PANEL_Z_LIMIT),
        (dz, PANEL_Z_LIMIT - first[1]),
    )
    for direction, offset in boundaries:
        if abs(direction) < 1e-12:
            if offset < 0:
                return None
            continue
        ratio = offset / direction
        if direction < 0:
            start = max(start, ratio)
        else:
            end = min(end, ratio)
        if start > end:
            return None
    return (
        (first[0] + start * dx, first[1] + start * dz),
        (first[0] + end * dx, first[1] + end * dz),
    )


def clip_curve_to_panel(curve):
    segments = []
    current = []
    for first, second in zip(curve, curve[1:]):
        clipped = clip_segment_to_panel(first, second)
        if clipped is None:
            if len(current) >= 2:
                segments.append(current)
            current = []
            continue
        clipped_first, clipped_second = clipped
        if not current or distance(current[-1], clipped_first) > 1e-8:
            if len(current) >= 2:
                segments.append(current)
            current = [clipped_first]
        current.append(clipped_second)
    if len(current) >= 2:
        segments.append(current)
    return segments


def arrow_segment(curve, center_fraction=0.52, half_length_fraction=0.018):
    lengths = cumulative_lengths(curve)
    total = lengths[-1]
    return [
        point_at_length(curve, lengths, total * (center_fraction - half_length_fraction)),
        point_at_length(curve, lengths, total * (center_fraction + half_length_fraction)),
    ]


def rotate_half_turn(curve):
    return [(-x, -z) for x, z in curve]


def point_quadrupole_loop(radius, side, half_turn=False, samples=181):
    """Analytic field line for Q = c tensor p + p tensor c."""
    exponent = math.cos(P_ANGLE) / 4
    polar_points = []
    for index in range(samples):
        fraction = index / (samples - 1)
        offset = side * math.pi / 2 * fraction
        if index in (0, samples - 1):
            radial_shape = 0.0
        else:
            radial_shape = (
                abs(math.tan(offset)) ** exponent
                * abs(math.sin(2 * offset)) ** 0.75
            )
        angle = P_ANGLE / 2 + offset
        if half_turn:
            angle += math.pi
        polar_points.append((angle, radial_shape))

    normalizer = max(radial_shape for _, radial_shape in polar_points)
    return [
        (
            radius * radial_shape / normalizer * math.cos(angle),
            radius * radial_shape / normalizer * math.sin(angle),
        )
        for angle, radial_shape in polar_points
    ]


def point_quadrupole_ray(angle, inward):
    inner_radius = 0.055
    outer_radius = PANEL_Z_LIMIT / abs(math.sin(angle))
    ray = [
        (inner_radius * math.cos(angle), inner_radius * math.sin(angle)),
        (outer_radius * math.cos(angle), outer_radius * math.sin(angle)),
    ]
    return list(reversed(ray)) if inward else ray


def point_to_typst(point):
    return f"({point[0]:.6f}, {point[1]:.6f})"


def array_to_typst(items):
    if not items:
        return "()"
    body = ", ".join(items)
    if len(items) == 1:
        body += ","
    return f"({body})"


def curve_to_typst(curve):
    return array_to_typst([point_to_typst(point) for point in curve])


def curves_to_typst(curves):
    return array_to_typst([curve_to_typst(curve) for curve in curves])


def typst_let(name, value):
    return f"#let {name} = {value}\n"


outgoing_angle = P_ANGLE / 2
point_source_curves = [
    point_quadrupole_loop(radius, side, half_turn)
    for radius in (0.48, 0.78, 1.1, 1.46, 1.86, 2.34)
    for side in (-1, 1)
    for half_turn in (False, True)
]
for angle, inward in (
    (outgoing_angle, False),
    (outgoing_angle + math.pi, False),
    (outgoing_angle + math.pi / 2, True),
    (outgoing_angle + 3 * math.pi / 2, True),
):
    point_source_curves.append(point_quadrupole_ray(angle, inward))
point_curves = []
for curve in point_source_curves:
    point_curves.extend(
        resample(segment, sample_count=120)
        for segment in clip_curve_to_panel(curve)
        if cumulative_lengths(segment)[-1] > 0.14
    )
point_arrows = [arrow_segment(curve) for curve in point_curves]

upper_positive_curves = [
    integrate_four_charge_line(angle) for angle in FOUR_CHARGE_SEED_ANGLES
]
full_four_charge_curves = []
for curve in upper_positive_curves:
    full_four_charge_curves.extend((curve, rotate_half_turn(curve)))

four_charge_curves = []
for curve in full_four_charge_curves:
    four_charge_curves.extend(
        resample(segment, sample_count=120)
        for segment in clip_curve_to_panel(curve)
        if cumulative_lengths(segment)[-1] > 0.14
    )
four_charge_arrows = [arrow_segment(curve) for curve in four_charge_curves]

values = {
    "point-quadrupole-curves": curves_to_typst(point_curves),
    "point-quadrupole-arrows": curves_to_typst(point_arrows),
    "four-charge-quadrupole-curves": curves_to_typst(four_charge_curves),
    "four-charge-quadrupole-arrows": curves_to_typst(four_charge_arrows),
}

OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)
geometry_path = OUTPUT_ROOT / "geometry.typ"
geometry_content = "".join(typst_let(name, value) for name, value in values.items())
if not geometry_path.exists() or geometry_path.read_text(encoding="utf-8") != geometry_content:
    geometry_path.write_text(geometry_content, encoding="utf-8", newline="\n")
    print(f"written {geometry_path}")
else:
    print(f"no changes to {geometry_path}")

lib_path = OUTPUT_ROOT / "lib.typ"
lib_content = '#import "geometry.typ": *\n'
if not lib_path.exists() or lib_path.read_text(encoding="utf-8") != lib_content:
    lib_path.write_text(lib_content, encoding="utf-8", newline="\n")
    print(f"written {lib_path}")
else:
    print(f"no changes to {lib_path}")

for angle, curve in zip(FOUR_CHARGE_SEED_ANGLES, upper_positive_curves):
    maximum_radius = max(math.hypot(*point) for point in curve)
    terminal = curve[-1]
    print(
        f"seed {angle:>4} degrees: max r={maximum_radius:.3f}, "
        f"terminal=({terminal[0]:.3f}, {terminal[1]:.3f})"
    )
