import math
import statistics
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = PROJECT_ROOT / "build" / "visual-output" / "electric-quadrupole"

# Figure controls: finite seed count sets both corresponding line families;
# c/p half-lengths set the finite quadrupole size; p angle is counterclockwise
# from c, fixed along +x. Physical moment magnitude rescales |E| but not these
# normalized trajectories, while arrow length controls its displayed size.
P_ANGLE_DEGREES = 68.0
QUADRUPOLE_MOMENT_ARROW_LENGTH = 0.78
P_ANGLE = math.radians(P_ANGLE_DEGREES)
P_DIRECTION = (math.cos(P_ANGLE), math.sin(P_ANGLE))
BISECTOR_DIRECTION = (math.cos(P_ANGLE / 2), math.sin(P_ANGLE / 2))
C_HALF_LENGTH = 0.20
P_HALF_LENGTH = 0.17
C_HALF_VECTOR = (C_HALF_LENGTH, 0.0)
P_HALF_VECTOR = (
    P_HALF_LENGTH * P_DIRECTION[0],
    P_HALF_LENGTH * P_DIRECTION[1],
)
SEED_RADIUS = 0.035
CAPTURE_RADIUS = 0.045
INTEGRATION_STEP = 0.006
MAX_STEPS = 30_000
OUTPUT_SAMPLES = 220
FOUR_CHARGE_LINES_PER_BASIN = 12
FOUR_CHARGE_SEED_ANGLES = tuple(
    (
        math.degrees(P_ANGLE / 2)
        + 180 * basin
        + 180 * (index + 0.5) / FOUR_CHARGE_LINES_PER_BASIN
        + 180
    ) % 360 - 180
    for basin in range(2)
    for index in range(FOUR_CHARGE_LINES_PER_BASIN)
)
POINT_QUADRUPOLE_VIEW_ZOOM = 1.30
POINT_QUADRUPOLE_MARKER_RADIUS = 0.084
POINT_QUADRUPOLE_EXTERIOR_MATCH_RADIUS = 0.45
POINT_QUADRUPOLE_INNER_MIN_SCALE = 0.14
POINT_QUADRUPOLE_INNER_TARGET_GAP = 0.11
ARROW_FRACTIONS = (0.30, 0.62, 0.42, 0.74, 0.52)
PANEL_X_LIMIT = 2.32
PANEL_Z_LIMIT = 1.58


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def scale(vector, factor):
    return (vector[0] * factor, vector[1] * factor)


def distance(a, b):
    return math.hypot(a[0] - b[0], a[1] - b[1])


def clipped_axis(direction, inset=0.985):
    """Return a centered axis clipped just inside the common panel bounds."""
    x, z = direction
    half_length = inset * min(
        PANEL_X_LIMIT / abs(x) if x else math.inf,
        PANEL_Z_LIMIT / abs(z) if z else math.inf,
    )
    return ((-half_length * x, -half_length * z),
            (half_length * x, half_length * z))


def quadrupole_separatrix_guides():
    x, z = BISECTOR_DIRECTION
    return (
        clipped_axis((x, z)),
        clipped_axis((-z, x)),
    )


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


def point_quadrupole_radial_shape(offset):
    exponent = math.cos(P_ANGLE) / 4
    if abs(math.sin(2 * offset)) < 1e-12:
        return 0.0
    return (
        abs(math.tan(offset)) ** exponent
        * abs(math.sin(2 * offset)) ** 0.75
    )


def point_quadrupole_shape_normalizer():
    return point_quadrupole_radial_shape(point_quadrupole_maximum_offset())


def point_quadrupole_maximum_offset():
    return math.acos(-math.cos(P_ANGLE) / 3) / 2


def point_quadrupole_radii_from_finite(curves):
    """Fit one point line to every finite line outside the charge cluster."""
    normalizer = point_quadrupole_shape_normalizer()
    outgoing_angle = P_ANGLE / 2
    radii_by_side = {-1: [], 1: []}
    for curve in curves:
        farthest = max(curve, key=lambda point: math.hypot(*point))
        if math.hypot(*farthest) <= POINT_QUADRUPOLE_EXTERIOR_MATCH_RADIUS:
            continue
        farthest_offset = (
            math.atan2(farthest[1], farthest[0])
            - outgoing_angle
            + math.pi / 2
        ) % math.pi - math.pi / 2
        side = -1 if farthest_offset < 0 else 1
        equivalent_radii = []
        for point in curve:
            radius = math.hypot(*point)
            if radius <= POINT_QUADRUPOLE_EXTERIOR_MATCH_RADIUS:
                continue
            offset = (
                math.atan2(point[1], point[0])
                - outgoing_angle
                + math.pi / 2
            ) % math.pi - math.pi / 2
            radial_shape = point_quadrupole_radial_shape(offset)
            if radial_shape > 1e-8:
                equivalent_radii.append(radius * normalizer / radial_shape)
        if equivalent_radii:
            radii_by_side[side].append(statistics.median(equivalent_radii))

    # Keep every fitted exterior trajectory. The exact straight separatrix is
    # intentionally omitted from this sampled diagram so each finite curve has
    # one distinct curved point-line counterpart.
    return {
        side: tuple(sorted(radii))
        for side, radii in radii_by_side.items()
    }


def add_uniform_inner_radii(exterior_radii_by_side):
    """Fill the point-only core without disturbing exterior correspondence."""
    first_exterior_scale = min(
        radii[0] for radii in exterior_radii_by_side.values()
    )
    interval_count = max(
        1,
        math.ceil(
            (first_exterior_scale - POINT_QUADRUPOLE_INNER_MIN_SCALE)
            / POINT_QUADRUPOLE_INNER_TARGET_GAP
        ),
    )
    output = {}
    for side, exterior_radii in exterior_radii_by_side.items():
        first_exterior = exterior_radii[0]
        inner_radii = tuple(
            POINT_QUADRUPOLE_INNER_MIN_SCALE
            + (first_exterior - POINT_QUADRUPOLE_INNER_MIN_SCALE)
            * index
            / interval_count
            for index in range(interval_count)
        )
        output[side] = inner_radii + exterior_radii
    return output


def distributed_arrows(curves, curves_per_level, minimum_length):
    arrows = []
    for index, curve in enumerate(curves):
        if cumulative_lengths(curve)[-1] <= minimum_length:
            continue
        level = index // curves_per_level
        arrows.append(arrow_segment(curve, center_fraction=ARROW_FRACTIONS[level % len(ARROW_FRACTIONS)]))
    return arrows


def point_quadrupole_loop(radius, side, half_turn=False, samples=181):
    """Analytic field line for Q = c tensor p + p tensor c."""
    normalizer = point_quadrupole_shape_normalizer()
    polar_points = []
    for index in range(samples):
        fraction = index / (samples - 1)
        offset = side * math.pi / 2 * fraction
        radial_shape = point_quadrupole_radial_shape(offset)
        angle = P_ANGLE / 2 + offset
        if half_turn:
            angle += math.pi
        polar_points.append((angle, radial_shape))

    return [
        (
            radius * radial_shape / normalizer * math.cos(angle),
            radius * radial_shape / normalizer * math.sin(angle),
        )
        for angle, radial_shape in polar_points
    ]


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


upper_positive_curves = [
    integrate_four_charge_line(angle) for angle in FOUR_CHARGE_SEED_ANGLES
]
matched_point_radii = point_quadrupole_radii_from_finite(upper_positive_curves)
point_radii = add_uniform_inner_radii(matched_point_radii)

point_source_curves = [
    point_quadrupole_loop(radius, side, half_turn)
    for side in (-1, 1)
    for radius in point_radii[side]
    for half_turn in (False, True)
]
point_curves = []
for curve in point_source_curves:
    point_curves.extend(
        resample(segment, sample_count=120)
        for segment in clip_curve_to_panel([
            scale(point, POINT_QUADRUPOLE_VIEW_ZOOM)
            for point in curve
        ])
        if cumulative_lengths(segment)[-1] > 0.14
        and min(distance(point, (0.0, 0.0)) for point in segment)
        <= POINT_QUADRUPOLE_VIEW_ZOOM * POINT_QUADRUPOLE_MARKER_RADIUS
    )
point_arrows = distributed_arrows(point_curves, curves_per_level=2, minimum_length=0.9)

full_four_charge_curves = []
for curve in upper_positive_curves:
    full_four_charge_curves.extend((curve, rotate_half_turn(curve)))

four_charge_centers = [
    scale((charge_x, charge_z), POINT_QUADRUPOLE_VIEW_ZOOM)
    for charge_x, charge_z, _ in four_charge_positions()
]
four_charge_curves = []
for curve in full_four_charge_curves:
    four_charge_curves.extend(
        resample(segment, sample_count=120)
        for segment in clip_curve_to_panel([
            scale(point, POINT_QUADRUPOLE_VIEW_ZOOM)
            for point in curve
        ])
        if cumulative_lengths(segment)[-1] > 0.14
        and min(
            distance(point, charge)
            for point in segment
            for charge in four_charge_centers
        ) <= POINT_QUADRUPOLE_VIEW_ZOOM * CAPTURE_RADIUS
    )
four_charge_arrows = distributed_arrows(
    four_charge_curves,
    curves_per_level=2,
    minimum_length=0.9,
)

values = {
    "quadrupole-c-half-vector": point_to_typst(
        scale(C_HALF_VECTOR, POINT_QUADRUPOLE_VIEW_ZOOM)
    ),
    "quadrupole-moment-arrow-length": f"{QUADRUPOLE_MOMENT_ARROW_LENGTH:.6f}",
    "point-quadrupole-view-zoom": f"{POINT_QUADRUPOLE_VIEW_ZOOM:.6f}",
    "quadrupole-p-direction": point_to_typst(P_DIRECTION),
    "quadrupole-separatrix-guides": curves_to_typst(
        quadrupole_separatrix_guides()
    ),
    "quadrupole-p-half-vector": point_to_typst(
        scale(P_HALF_VECTOR, POINT_QUADRUPOLE_VIEW_ZOOM)
    ),
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
