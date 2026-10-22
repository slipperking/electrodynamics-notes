import math
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = (
    PROJECT_ROOT
    / "build"
    / "visual-output"
    / "time-varying-flux-integral"
)

U_MIN, U_MAX = -2.6, 2.6
V_MIN, V_MAX = -1.2, 1.2
CELL_U_MIN, CELL_U_MAX = -1.30, -0.65
CELL_V_MIN, CELL_V_MAX = -0.60, 0.0
CENTER_U = (CELL_U_MIN + CELL_U_MAX) / 2.0
CENTER_V = (CELL_V_MIN + CELL_V_MAX) / 2.0
NORMAL_HEIGHT = 1.8
VELOCITY_TANGENT_U = -0.90
VELOCITY_TANGENT_V = 0.10
DIAGRAM_SCALE = 1.3
RIBBON_U = 1.95
RIBBON_HALF_U = 0.22
RIBBON_NORMAL_LENGTH = 1.10


def add(a, b):
    return tuple(x + y for x, y in zip(a, b))


def scale(a, factor):
    return tuple(factor * x for x in a)


def dot(a, b):
    return sum(x * y for x, y in zip(a, b))


def cross(a, b):
    return (
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0],
    )


def normalize(a):
    length = math.sqrt(dot(a, a))
    return scale(a, 1.0 / length)


def linspace(start, stop, count):
    if count == 1:
        return [start]
    return [start + (stop - start) * i / (count - 1) for i in range(count)]


def height(u, v):
    return (
        0.16 * math.sin(1.18 * u)
        + 0.10 * math.cos(1.35 * v)
        + 0.055 * math.sin(0.72 * u + 1.15 * v)
    )


def height_u(u, v):
    return (
        0.16 * 1.18 * math.cos(1.18 * u)
        + 0.055 * 0.72 * math.cos(0.72 * u + 1.15 * v)
    )


def height_v(u, v):
    return (
        -0.10 * 1.35 * math.sin(1.35 * v)
        + 0.055 * 1.15 * math.cos(0.72 * u + 1.15 * v)
    )


def surface(u, v):
    return (u, v, height(u, v))


def project(point):
    x, y, z = point
    return (
        DIAGRAM_SCALE * (x + 0.56 * y + 3.55),
        DIAGRAM_SCALE * (0.37 * y + 0.91 * z + 0.92),
    )


center = surface(CENTER_U, CENTER_V)
tangent_u = normalize((1.0, 0.0, height_u(CENTER_U, CENTER_V)))
tangent_v_raw = (0.0, 1.0, height_v(CENTER_U, CENTER_V))
normal = normalize(cross(tangent_u, tangent_v_raw))
tangent_v = normalize(cross(normal, tangent_u))
normal_displacement = scale(normal, NORMAL_HEIGHT)
displacement = add(
    normal_displacement,
    add(
        scale(tangent_u, VELOCITY_TANGENT_U),
        scale(tangent_v, VELOCITY_TANGENT_V),
    ),
)


def displaced(point):
    return add(point, displacement)


def u_curve(v, upper=False, samples=57):
    points = [surface(u, v) for u in linspace(U_MIN, U_MAX, samples)]
    if upper:
        points = [displaced(point) for point in points]
    return [project(point) for point in points]


def v_curve(u, upper=False, samples=31):
    points = [surface(u, v) for v in linspace(V_MIN, V_MAX, samples)]
    if upper:
        points = [displaced(point) for point in points]
    return [project(point) for point in points]


u_grid_values = linspace(U_MIN, U_MAX, 9)
v_grid_values = linspace(V_MIN, V_MAX, 5)
lower_mesh = [u_curve(v) for v in v_grid_values[1:-1]] + [
    v_curve(u) for u in u_grid_values[1:-1]
]
upper_mesh = [u_curve(v, upper=True) for v in v_grid_values[1:-1]] + [
    v_curve(u, upper=True) for u in u_grid_values[1:-1]
]

lower_near = u_curve(V_MIN)
lower_far = u_curve(V_MAX)
lower_left = v_curve(U_MIN)
lower_right = v_curve(U_MAX)
upper_near = u_curve(V_MIN, upper=True)
upper_far = u_curve(V_MAX, upper=True)
upper_left = v_curve(U_MIN, upper=True)
upper_right = v_curve(U_MAX, upper=True)

front_sweep_connectors = []
back_sweep_connectors = []
for u in (U_MIN, U_MAX):
    front_point = surface(u, V_MIN)
    back_point = surface(u, V_MAX)
    front_sweep_connectors.append([project(front_point), project(displaced(front_point))])
    back_sweep_connectors.append([project(back_point), project(displaced(back_point))])

# A differential ribbon element on the near boundary. Its normal is
# d ell x v, computed in 3D before applying the camera projection.
ribbon_lower_left_3d = surface(RIBBON_U - RIBBON_HALF_U, V_MIN)
ribbon_lower_right_3d = surface(RIBBON_U + RIBBON_HALF_U, V_MIN)
ribbon_upper_left_3d = displaced(ribbon_lower_left_3d)
ribbon_upper_right_3d = displaced(ribbon_lower_right_3d)

ribbon_vector_origin_3d = ribbon_lower_left_3d
ribbon_vector_origin = project(ribbon_vector_origin_3d)
ribbon_dell_start = ribbon_vector_origin
ribbon_dell_end = project(ribbon_lower_right_3d)
ribbon_top_edge = [project(ribbon_upper_left_3d), project(ribbon_upper_right_3d)]
ribbon_opposite_side = [project(ribbon_lower_right_3d), project(ribbon_upper_right_3d)]
ribbon_velocity_start = ribbon_vector_origin
ribbon_velocity_end = project(ribbon_upper_left_3d)

ribbon_tangent = normalize((1.0, 0.0, height_u(RIBBON_U, V_MIN)))
ribbon_normal = normalize(cross(ribbon_tangent, displacement))
ribbon_normal_start_3d = ribbon_vector_origin_3d
ribbon_normal_end_3d = add(
    ribbon_normal_start_3d,
    scale(ribbon_normal, RIBBON_NORMAL_LENGTH),
)
ribbon_normal_start = project(ribbon_normal_start_3d)
ribbon_normal_end = project(ribbon_normal_end_3d)

# Select one exact cell of the parameter grid as the local area element.
element_corners = [
    surface(CELL_U_MIN, CELL_V_MIN),
    surface(CELL_U_MAX, CELL_V_MIN),
    surface(CELL_U_MAX, CELL_V_MAX),
    surface(CELL_U_MIN, CELL_V_MAX),
]

element_bottom_boundary = [project(point) for point in element_corners]
element_top_boundary = [project(displaced(point)) for point in element_corners]

right_corner_index = max(
    range(len(element_bottom_boundary)),
    key=lambda index: element_bottom_boundary[index][0],
)
element_plain_connectors = [
    [element_bottom_boundary[index], element_top_boundary[index]]
    for index in range(len(element_corners))
    if index != right_corner_index
]
element_projection_start = element_bottom_boundary[right_corner_index]
element_projection_end = project(
    add(element_corners[right_corner_index], normal_displacement)
)
element_velocity_side = [
    element_projection_start,
    element_top_boundary[right_corner_index],
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


values = {
    "lower-mesh-curves": curves_to_typst(lower_mesh),
    "upper-mesh-curves": curves_to_typst(upper_mesh),
    "lower-near-edge": curve_to_typst(lower_near),
    "lower-far-edge": curve_to_typst(lower_far),
    "lower-left-edge": curve_to_typst(lower_left),
    "lower-right-edge": curve_to_typst(lower_right),
    "upper-near-edge": curve_to_typst(upper_near),
    "upper-far-edge": curve_to_typst(upper_far),
    "upper-left-edge": curve_to_typst(upper_left),
    "upper-right-edge": curve_to_typst(upper_right),
    "front-sweep-connectors": curves_to_typst(front_sweep_connectors),
    "back-sweep-connectors": curves_to_typst(back_sweep_connectors),
    "ribbon-top-edge": curve_to_typst(ribbon_top_edge),
    "ribbon-opposite-side": curve_to_typst(ribbon_opposite_side),
    "ribbon-dell-start": point_to_typst(ribbon_dell_start),
    "ribbon-dell-end": point_to_typst(ribbon_dell_end),
    "ribbon-velocity-start": point_to_typst(ribbon_velocity_start),
    "ribbon-velocity-end": point_to_typst(ribbon_velocity_end),
    "ribbon-normal-start": point_to_typst(ribbon_normal_start),
    "ribbon-normal-end": point_to_typst(ribbon_normal_end),
    "element-bottom-boundary": curve_to_typst(element_bottom_boundary),
    "element-top-boundary": curve_to_typst(element_top_boundary),
    "element-plain-connectors": curves_to_typst(element_plain_connectors),
    "element-velocity-side": curve_to_typst(element_velocity_side),
    "element-projection-start": point_to_typst(element_projection_start),
    "element-projection-end": point_to_typst(element_projection_end),
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
