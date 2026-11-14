import math
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = PROJECT_ROOT / "build" / "visual-output" / "electrostatic-induction"

# The body starts as a circle and receives a fixed angular perturbation. The
# same deformation is extended into the exterior with inverse-square radial
# decay, so the analytic circular-conductor streamlines meet the perturbed
# boundary without performing geometry construction during Typst compilation.
BODY_RADIUS = 0.9
BLOB_SAMPLE_COUNT = 120
FIELD_SAMPLE_COUNT = 60
U_LIMIT = 2.45
FIELD_LEVEL_STEP = 5 / 16
FIELD_LEVELS = tuple((index - 6) * FIELD_LEVEL_STEP for index in range(13))
INTERSECTING_LEVELS = tuple(index * FIELD_LEVEL_STEP for index in range(6))
PASSING_LEVELS = (6 * FIELD_LEVEL_STEP,)
NEGATIVE_CHARGE_ANGLES = (130, 155, 180, 205, 230)
POSITIVE_CHARGE_ANGLES = (-50, -25, 0, 25, 50)


def blob_scale(angle):
    broad_lobe = -0.16 * math.cos(angle - math.radians(25))
    upper_dent = -0.12 * math.sin(2 * angle + math.radians(10))
    lower_lobe = 0.11 * math.cos(3 * angle + math.radians(40))
    edge_ripple = 0.08 * math.sin(5 * angle - math.radians(15))
    return 1 + broad_lobe + upper_dent + lower_lobe + edge_ripple


def blob_point(x, y):
    radius = math.hypot(x, y)
    if radius == 0:
        raise ValueError("the radial blob deformation is undefined at the origin")

    angle = math.atan2(y, x)
    boundary_offset = BODY_RADIUS * (blob_scale(angle) - 1)
    decay = (BODY_RADIUS / radius) ** 2
    mapped_radius = radius + boundary_offset * decay
    scale = mapped_radius / radius
    return (scale * x, scale * y)


def blob_boundary():
    return [
        blob_point(
            BODY_RADIUS * math.cos(2 * math.pi * index / BLOB_SAMPLE_COUNT),
            BODY_RADIUS * math.sin(2 * math.pi * index / BLOB_SAMPLE_COUNT),
        )
        for index in range(BLOB_SAMPLE_COUNT + 1)
    ]


def charge_point(angle_degrees):
    angle = math.radians(angle_degrees)
    return blob_point(
        BODY_RADIUS * math.cos(angle),
        BODY_RADIUS * math.sin(angle),
    )


def mapped_point(u, impact_parameter, branch, side):
    radius_squared = BODY_RADIUS**2
    root_real = u * u - impact_parameter * impact_parameter + 4 * radius_squared
    root_imaginary = 2 * u * impact_parameter
    root_magnitude = math.hypot(root_real, root_imaginary)
    square_root_real = math.sqrt(max(0, (root_magnitude + root_real) / 2))
    square_root_imaginary = math.sqrt(max(0, (root_magnitude - root_real) / 2))
    x = (u + branch * square_root_real) / 2
    y = (impact_parameter + square_root_imaginary) / 2
    return blob_point(x, side * y)


def field_branch(impact_parameter, branch, side):
    points = []
    for index in range(FIELD_SAMPLE_COUNT + 1):
        if branch < 0:
            u = -U_LIMIT + U_LIMIT * index / FIELD_SAMPLE_COUNT
        else:
            u = U_LIMIT * index / FIELD_SAMPLE_COUNT
        points.append(mapped_point(u, impact_parameter, branch, side))
    return points


def passing_field_line(impact_parameter, side):
    left = field_branch(impact_parameter, -1, side)
    right = field_branch(impact_parameter, 1, side)
    return left + right[1:]


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


def numbers_to_typst(numbers):
    return array_to_typst([f"{number:.6f}" for number in numbers])


def typst_let(name, value):
    return f"#let {name} = {value}\n"


boundary = blob_boundary()
negative_charge_points = [charge_point(angle) for angle in NEGATIVE_CHARGE_ANGLES]
positive_charge_points = [charge_point(angle) for angle in POSITIVE_CHARGE_ANGLES]

total_field_curves = []
for level in PASSING_LEVELS:
    for side in (-1, 1):
        total_field_curves.append(passing_field_line(level, side))
for level in INTERSECTING_LEVELS:
    sides = (1,) if level == 0 else (-1, 1)
    for side in sides:
        total_field_curves.append(field_branch(level, -1, side))
        total_field_curves.append(field_branch(level, 1, side))

values = {
    "induction-body-boundary": curve_to_typst(boundary),
    "induction-negative-charge-points": curve_to_typst(negative_charge_points),
    "induction-positive-charge-points": curve_to_typst(positive_charge_points),
    "induction-field-levels": numbers_to_typst(FIELD_LEVELS),
    "induction-total-field-curves": curves_to_typst(total_field_curves),
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
