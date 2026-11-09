import math
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = PROJECT_ROOT / "build" / "visual-output" / "electric-dipole"

CHARGE_HALF_GAP = 0.315
SEED_RADIUS = 0.035
CAPTURE_RADIUS = 0.042
INTEGRATION_STEP = 0.006
MAX_STEPS = 20_000
OUTPUT_SAMPLES = 220
TWO_CHARGE_SEED_ANGLES = (-90, -55, -25, 5, 25, 37)
POINT_DIPOLE_OUTER_RADII = (3.1, 4.4)
TWO_CHARGE_OUTER_ANGLES = (53,)
PANEL_X_LIMIT = 2.32
PANEL_Z_LIMIT = 1.58
DIPOLE_TILT = math.radians(-22)


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def scale(vector, factor):
    return (vector[0] * factor, vector[1] * factor)


def distance(a, b):
    return math.hypot(a[0] - b[0], a[1] - b[1])


def normalized_field(point):
    """Exact field direction of equal charges +1 at +a and -1 at -a."""
    x, z = point
    plus_dx, plus_dz = x, z - CHARGE_HALF_GAP
    minus_dx, minus_dz = x, z + CHARGE_HALF_GAP
    plus_r = math.hypot(plus_dx, plus_dz)
    minus_r = math.hypot(minus_dx, minus_dz)

    ex = plus_dx / plus_r**3 - minus_dx / minus_r**3
    ez = plus_dz / plus_r**3 - minus_dz / minus_r**3
    magnitude = math.hypot(ex, ez)
    return (ex / magnitude, ez / magnitude)


def rk4_step(point, step):
    k1 = normalized_field(point)
    k2 = normalized_field(add(point, scale(k1, step / 2)))
    k3 = normalized_field(add(point, scale(k2, step / 2)))
    k4 = normalized_field(add(point, scale(k3, step)))
    average = (
        (k1[0] + 2 * k2[0] + 2 * k3[0] + k4[0]) / 6,
        (k1[1] + 2 * k2[1] + 2 * k3[1] + k4[1]) / 6,
    )
    return add(point, scale(average, step))


def integrate_two_charge_line(seed_angle_degrees):
    angle = math.radians(seed_angle_degrees)
    point = (
        SEED_RADIUS * math.cos(angle),
        CHARGE_HALF_GAP + SEED_RADIUS * math.sin(angle),
    )
    curve = [point]
    negative_charge = (0.0, -CHARGE_HALF_GAP)

    for _ in range(MAX_STEPS):
        point = rk4_step(point, INTEGRATION_STEP)
        curve.append(point)
        if distance(point, negative_charge) <= CAPTURE_RADIUS:
            break
        if abs(point[0]) > 12 or abs(point[1]) > 12:
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
    return add(curve[low], scale(
        (curve[high][0] - curve[low][0], curve[high][1] - curve[low][1]),
        fraction,
    ))


def resample(curve, sample_count=OUTPUT_SAMPLES):
    lengths = cumulative_lengths(curve)
    total = lengths[-1]
    return [
        point_at_length(curve, lengths, total * i / (sample_count - 1))
        for i in range(sample_count)
    ]


def clip_segment_to_panel(first, second):
    """Liang-Barsky clipping for one segment against the final panel rectangle."""
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


def arrow_segment(curve, center_fraction=0.5, half_length_fraction=0.018):
    lengths = cumulative_lengths(curve)
    total = lengths[-1]
    return [
        point_at_length(curve, lengths, total * (center_fraction - half_length_fraction)),
        point_at_length(curve, lengths, total * (center_fraction + half_length_fraction)),
    ]


def mirror(curve):
    return [(-x, z) for x, z in curve]


def rotate_to_oblique(curve):
    cosine = math.cos(DIPOLE_TILT)
    sine = math.sin(DIPOLE_TILT)
    return [
        (cosine * x - sine * z, sine * x + cosine * z)
        for x, z in curve
    ]


def point_dipole_line(radius, side, samples=241):
    curve = []
    for index in range(samples):
        theta = math.pi * index / (samples - 1)
        sine = math.sin(theta)
        radial = radius * sine * sine
        curve.append((side * radial * sine, radial * math.cos(theta)))
    return curve


def orientation(a, b, c):
    return (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0])


def proper_intersection(a, b, c, d, tolerance=1e-10):
    if (
        max(a[0], b[0]) + tolerance < min(c[0], d[0])
        or max(c[0], d[0]) + tolerance < min(a[0], b[0])
        or max(a[1], b[1]) + tolerance < min(c[1], d[1])
        or max(c[1], d[1]) + tolerance < min(a[1], b[1])
    ):
        return False
    first = orientation(a, b, c)
    second = orientation(a, b, d)
    third = orientation(c, d, a)
    fourth = orientation(c, d, b)
    return (
        first * second < -tolerance
        and third * fourth < -tolerance
    )


def validate_no_intersections(curves, name):
    for curve_index, curve in enumerate(curves):
        for first_index in range(len(curve) - 1):
            for second_index in range(first_index + 2, len(curve) - 1):
                if proper_intersection(
                    curve[first_index],
                    curve[first_index + 1],
                    curve[second_index],
                    curve[second_index + 1],
                ):
                    raise RuntimeError(
                        f"{name} curve {curve_index} self-intersects"
                    )

    for first_curve_index, first_curve in enumerate(curves):
        for second_curve_index in range(first_curve_index + 1, len(curves)):
            second_curve = curves[second_curve_index]
            for first_index in range(len(first_curve) - 1):
                for second_index in range(len(second_curve) - 1):
                    if proper_intersection(
                        first_curve[first_index],
                        first_curve[first_index + 1],
                        second_curve[second_index],
                        second_curve[second_index + 1],
                    ):
                        raise RuntimeError(
                            f"{name} curves {first_curve_index} and "
                            f"{second_curve_index} intersect"
                        )


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


point_source_curves = [
    point_dipole_line(
        radius,
        side,
        samples=481 if radius in POINT_DIPOLE_OUTER_RADII else 241,
    )
    for radius in (0.72, 1.12, 1.62, 2.18, *POINT_DIPOLE_OUTER_RADII)
    for side in (-1, 1)
]
point_curves = []
for curve in point_source_curves:
    point_curves.extend(
        resample(segment, sample_count=120)
        for segment in clip_curve_to_panel(rotate_to_oblique(curve))
        if cumulative_lengths(segment)[-1] > 0.14
    )
point_arrows = [arrow_segment(curve) for curve in point_curves]

# The -90-degree seed is the exact axial line. The remaining seeds cover the
# right half-plane; reflection supplies the left half without integration drift.
right_two_charge_curves = [
    resample(integrate_two_charge_line(angle))
    for angle in TWO_CHARGE_SEED_ANGLES
]
two_charge_source_curves = [right_two_charge_curves[0]]
for curve in right_two_charge_curves[1:]:
    two_charge_source_curves.extend((mirror(curve), curve))
for angle in TWO_CHARGE_OUTER_ANGLES:
    outer_curve = integrate_two_charge_line(angle)
    two_charge_source_curves.extend((mirror(outer_curve), outer_curve))
two_charge_curves = []
for curve in two_charge_source_curves:
    two_charge_curves.extend(
        resample(segment, sample_count=120)
        for segment in clip_curve_to_panel(rotate_to_oblique(curve))
        if cumulative_lengths(segment)[-1] > 0.14
    )
two_charge_arrows = [arrow_segment(curve) for curve in two_charge_curves]

# Integral curves of a smooth vector field cannot cross away from a charge.
# Keep an explicit polyline check so future seed or solver changes preserve it.
validate_no_intersections(point_curves, "point-dipole")
validate_no_intersections(two_charge_curves, "two-charge")

values = {
    "point-dipole-curves": curves_to_typst(point_curves),
    "point-dipole-arrows": curves_to_typst(point_arrows),
    "two-charge-dipole-curves": curves_to_typst(two_charge_curves),
    "two-charge-dipole-arrows": curves_to_typst(two_charge_arrows),
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

for angle, curve in zip(
    TWO_CHARGE_SEED_ANGLES,
    right_two_charge_curves,
):
    maximum_x = max(abs(point[0]) for point in curve)
    minimum_z = min(point[1] for point in curve)
    maximum_z = max(point[1] for point in curve)
    print(
        f"seed {angle:>3} degrees: max |x|={maximum_x:.3f}, "
        f"z-range=({minimum_z:.3f}, {maximum_z:.3f})"
    )
