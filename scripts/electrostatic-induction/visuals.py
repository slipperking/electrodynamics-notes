import json
import math
from pathlib import Path

import numpy as np


PROJECT_ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = PROJECT_ROOT / "build" / "visual-output" / "electrostatic-induction"

# Preserve the original smooth, irregular conductor silhouette.  The exterior
# electrostatic problem is solved on this boundary by the method of fundamental
# solutions; field lines are then integrated from that numerical solution.
BODY_RADIUS = 0.9
BOUNDARY_SAMPLE_COUNT = 180
PANEL_COUNT = 480
BOUNDARY_FIELD_OFFSET = 0.002
BOUNDARY_APPROACH_LENGTH = 0.008
VERIFICATION_BOUNDARY_SAMPLES = 1440
FIELD_X_LIMIT = 2.65
FIELD_STEP = 0.005
MAX_FIELD_STEPS = 2500
FIELD_LEVEL_STEP = 5 / 16
FIELD_LEVELS = tuple((index - 6) * FIELD_LEVEL_STEP for index in range(13))
CHARGE_LEVELS = tuple(index * FIELD_LEVEL_STEP for index in (-4, -2, 0, 2, 4))
E0 = 1.0


def blob_scale(angle):
    broad_lobe = -0.16 * math.cos(angle - math.radians(25))
    upper_dent = -0.12 * math.sin(2 * angle + math.radians(10))
    lower_lobe = 0.11 * math.cos(3 * angle + math.radians(40))
    edge_ripple = 0.08 * math.sin(5 * angle - math.radians(15))
    return 1 + broad_lobe + upper_dent + lower_lobe + edge_ripple


def blob_scale_derivative(angle):
    return (
        0.16 * math.sin(angle - math.radians(25))
        - 0.24 * math.cos(2 * angle + math.radians(10))
        - 0.33 * math.sin(3 * angle + math.radians(40))
        + 0.40 * math.cos(5 * angle - math.radians(15))
    )


def boundary_point(angle):
    radius = BODY_RADIUS * blob_scale(angle)
    return radius * complex(math.cos(angle), math.sin(angle))


def boundary_tangent(angle):
    radius = BODY_RADIUS * blob_scale(angle)
    radius_derivative = BODY_RADIUS * blob_scale_derivative(angle)
    direction = complex(math.cos(angle), math.sin(angle))
    return direction * complex(radius_derivative, radius)


def body_boundary():
    return [
        boundary_point(2 * math.pi * index / BOUNDARY_SAMPLE_COUNT)
        for index in range(BOUNDARY_SAMPLE_COUNT + 1)
    ]


def is_inside(point):
    radius = abs(point)
    if radius == 0:
        return True
    angle = math.atan2(point.imag, point.real)
    return radius <= BODY_RADIUS * blob_scale(angle)


def panel_geometry():
    angles = 2 * math.pi * np.arange(PANEL_COUNT + 1) / PANEL_COUNT
    vertices = np.array([boundary_point(angle) for angle in angles])
    starts = vertices[:-1]
    ends = vertices[1:]
    vectors = ends - starts
    lengths = np.abs(vectors)
    tangents = vectors / lengths
    return {
        "centers": (starts + ends) / 2,
        "lengths": lengths,
        "tangents": tangents,
        "left_normals": 1j * tangents,
    }


PANELS = panel_geometry()


def panel_potential_integrals(point):
    relative = point - PANELS["centers"]
    local = relative / PANELS["tangents"]
    along = local.real
    normal = local.imag
    half_length = PANELS["lengths"] / 2
    normal_abs = np.abs(normal)

    def antiderivative(value):
        radius_squared = value**2 + normal**2
        base = 0.5 * value * np.log(radius_squared) - value
        angle_term = np.zeros_like(value)
        nonzero = normal_abs > 1e-15
        angle_term[nonzero] = normal_abs[nonzero] * np.arctan(
            value[nonzero] / normal_abs[nonzero]
        )
        return base + angle_term

    return antiderivative(along + half_length) - antiderivative(
        along - half_length
    ) - PANELS["lengths"] * math.log(BODY_RADIUS)


def panel_field_integrals(point):
    relative = point - PANELS["centers"]
    local = relative / PANELS["tangents"]
    along = local.real
    normal = local.imag
    half_length = PANELS["lengths"] / 2
    plus_squared = (along + half_length) ** 2 + normal**2
    minus_squared = (along - half_length) ** 2 + normal**2
    parallel = 0.5 * np.log(plus_squared / minus_squared)
    perpendicular = np.arctan2(along + half_length, normal) - np.arctan2(
        along - half_length, normal
    )
    perpendicular = (perpendicular + math.pi) % (2 * math.pi) - math.pi
    return parallel * PANELS["tangents"] + perpendicular * PANELS["left_normals"]


def solve_exterior_problem():
    matrix = np.zeros((PANEL_COUNT + 1, PANEL_COUNT + 1))
    for index, point in enumerate(PANELS["centers"]):
        matrix[index, :-1] = panel_potential_integrals(point)
        matrix[index, -1] = -1
    matrix[-1, :-1] = PANELS["lengths"]

    right_hand_side = np.zeros(PANEL_COUNT + 1)
    right_hand_side[:-1] = E0 * PANELS["centers"].real
    solution = np.linalg.solve(matrix, right_hand_side)
    residual = matrix @ solution - right_hand_side
    return {
        "charge_density": solution[:-1],
        "conductor_potential": solution[-1],
        "linear_system_max_residual": float(np.max(np.abs(residual))),
        "linear_system_condition_number": float(np.linalg.cond(matrix)),
    }


MODEL = solve_exterior_problem()
CHARGE_DENSITY = MODEL["charge_density"]


def electric_potential(point):
    return -E0 * point.real + float(
        np.dot(CHARGE_DENSITY, panel_potential_integrals(point))
    )


def electric_field(point):
    induced_gradient = np.dot(CHARGE_DENSITY, panel_field_integrals(point))
    return complex(E0, 0) - induced_gradient


def unit_field(point, direction=1):
    field = electric_field(point)
    magnitude = abs(field)
    if magnitude < 1e-12:
        raise ValueError("field-line integration reached a stagnation point")
    return direction * field / magnitude


def solve_seed_y(x_coordinate, target_flux):
    y_values = np.linspace(-2.5, 2.5, 1201)
    horizontal_fields = np.array(
        [electric_field(complex(x_coordinate, y)).real for y in y_values]
    )
    increments = (horizontal_fields[1:] + horizontal_fields[:-1]) * np.diff(
        y_values
    ) / 2
    flux_values = np.concatenate(([0.0], np.cumsum(increments)))
    zero_index = int(np.argmin(np.abs(y_values)))
    flux_values -= flux_values[zero_index]
    if target_flux < flux_values[0] or target_flux > flux_values[-1]:
        raise ValueError("failed to bracket the field-line flux seed")
    return float(np.interp(target_flux, flux_values, y_values))


def boundary_intersection(outside_point, inside_point):
    outside = outside_point
    inside = inside_point
    for _ in range(60):
        middle = (outside + inside) / 2
        if is_inside(middle):
            inside = middle
        else:
            outside = middle
    return (outside + inside) / 2


def append_orthogonal_endpoint(points, endpoint):
    angle = math.atan2(endpoint.imag, endpoint.real)
    tangent = boundary_tangent(angle)
    outward_normal = -1j * tangent / abs(tangent)
    approach = endpoint + BOUNDARY_APPROACH_LENGTH * outward_normal
    while len(points) > 1 and abs(points[-1] - endpoint) < 1.5 * BOUNDARY_APPROACH_LENGTH:
        points.pop()
    points.extend((approach, endpoint))


def integrate_field_line(start, direction):
    points = [start]
    point = start
    for _ in range(MAX_FIELD_STEPS):
        first = unit_field(point, direction)
        first_trial = point + FIELD_STEP * first
        if is_inside(first_trial):
            append_orthogonal_endpoint(
                points, boundary_intersection(point, first_trial)
            )
            return points, True
        second = unit_field(point + FIELD_STEP * first / 2, direction)
        third = unit_field(point + FIELD_STEP * second / 2, direction)
        fourth = unit_field(point + FIELD_STEP * third, direction)
        next_point = point + FIELD_STEP * (
            first + 2 * second + 2 * third + fourth
        ) / 6

        if is_inside(next_point):
            append_orthogonal_endpoint(
                points, boundary_intersection(point, next_point)
            )
            return points, True

        points.append(next_point)
        point = next_point
        if direction > 0 and point.real >= FIELD_X_LIMIT:
            return points, False
        if direction < 0 and point.real <= -FIELD_X_LIMIT:
            return points, False
        if abs(point.imag) > 3:
            raise ValueError("field-line integration left the plotting domain")

    raise ValueError(
        f"field-line integration exceeded its step limit: start={start}, point={point}"
    )


def trace_from_left(target_flux):
    seed_y = solve_seed_y(-FIELD_X_LIMIT, target_flux)
    return integrate_field_line(complex(-FIELD_X_LIMIT, seed_y), 1)


def trace_from_right(target_flux):
    seed_y = solve_seed_y(FIELD_X_LIMIT, target_flux)
    points, hit_boundary = integrate_field_line(
        complex(FIELD_X_LIMIT, seed_y), -1
    )
    points.reverse()
    return points, hit_boundary


def vector_dot(left, right):
    return left.real * right.real + left.imag * right.imag


def vector_cross(left, right):
    return left.real * right.imag - left.imag * right.real


def orientation(first, second, third):
    return vector_cross(second - first, third - first)


def verify_boundary_shape():
    points = body_boundary()[:-1]
    point_count = len(points)
    turn_sines = []
    for index in range(point_count):
        incoming = points[index] - points[index - 1]
        outgoing = points[(index + 1) % point_count] - points[index]
        turn_sines.append(vector_cross(incoming, outgoing) / (abs(incoming) * abs(outgoing)))

    intersection_count = 0
    for first_index in range(point_count):
        first_start = points[first_index]
        first_end = points[(first_index + 1) % point_count]
        for second_index in range(first_index + 1, point_count):
            if second_index in (
                first_index,
                (first_index + 1) % point_count,
                (first_index - 1) % point_count,
            ):
                continue
            second_start = points[second_index]
            second_end = points[(second_index + 1) % point_count]
            if (
                orientation(first_start, first_end, second_start)
                * orientation(first_start, first_end, second_end)
                < 0
                and orientation(second_start, second_end, first_start)
                * orientation(second_start, second_end, first_end)
                < 0
            ):
                intersection_count += 1

    return {
        "minimum_boundary_turn_sine": min(turn_sines),
        "negative_boundary_turn_samples": sum(turn < 0 for turn in turn_sines),
        "boundary_segment_intersections": intersection_count,
    }


def verify_boundary_solution():
    potentials = []
    max_tangential_fraction = 0.0
    fields_and_tangential = []
    signed_flux = 0.0
    absolute_flux = 0.0
    angle_step = 2 * math.pi / VERIFICATION_BOUNDARY_SAMPLES

    for index in range(VERIFICATION_BOUNDARY_SAMPLES):
        angle = (index + 0.5) * angle_step
        point = boundary_point(angle)
        tangent = boundary_tangent(angle)
        normal = -1j * tangent / abs(tangent)
        field = electric_field(point + BOUNDARY_FIELD_OFFSET * normal)
        normal_field = vector_dot(field, normal)
        arc_element = abs(tangent) * angle_step

        potentials.append(electric_potential(point))
        tangential_field = abs(vector_dot(field, tangent)) / abs(tangent)
        fields_and_tangential.append((abs(field), tangential_field))
        signed_flux += normal_field * arc_element
        absolute_flux += abs(normal_field) * arc_element

    peak_field = max(field for field, _ in fields_and_tangential)
    for field, tangential_field in fields_and_tangential:
        if field >= 0.1 * peak_field:
            max_tangential_fraction = max(
                max_tangential_fraction, tangential_field / field
            )
    max_tangential_over_peak = max(
        tangential for _, tangential in fields_and_tangential
    ) / peak_field

    return {
        "boundary_potential_span": max(potentials) - min(potentials),
        "max_nonstagnant_boundary_tangential_field_fraction": max_tangential_fraction,
        "max_boundary_tangential_field_over_peak_field": max_tangential_over_peak,
        "relative_net_flux": abs(signed_flux) / absolute_flux,
        "linear_system_max_residual": MODEL["linear_system_max_residual"],
        "linear_system_condition_number": MODEL["linear_system_condition_number"],
    }


def verify_trajectories(curves):
    max_alignment_sine = 0.0
    min_direction_cosine = 1.0

    for points in curves:
        for index in range(2, len(points) - 2):
            rendered_tangent = points[index + 1] - points[index - 1]
            field = electric_field(points[index])
            scale = abs(rendered_tangent) * abs(field)
            max_alignment_sine = max(
                max_alignment_sine,
                abs(vector_cross(rendered_tangent, field)) / scale,
            )
            min_direction_cosine = min(
                min_direction_cosine,
                vector_dot(rendered_tangent, field) / scale,
            )

    return {
        "max_rendered_trajectory_alignment_sine": max_alignment_sine,
        "min_rendered_trajectory_direction_cosine": min_direction_cosine,
    }


def verify_endpoint_orthogonality(intersecting_curves):
    max_tangent_fraction = 0.0
    for points, branch in intersecting_curves:
        if branch < 0:
            adjacent = points[-2]
            endpoint = points[-1]
        else:
            endpoint = points[0]
            adjacent = points[1]
        rendered_tangent = endpoint - adjacent
        surface_tangent = boundary_tangent(math.atan2(endpoint.imag, endpoint.real))
        max_tangent_fraction = max(
            max_tangent_fraction,
            abs(vector_dot(rendered_tangent, surface_tangent))
            / (abs(rendered_tangent) * abs(surface_tangent)),
        )
    return {"max_rendered_endpoint_tangent_fraction": max_tangent_fraction}


def verify_charge_markers(negative_points, positive_points):
    negative_fields = []
    positive_fields = []
    for point in negative_points:
        angle = math.atan2(point.imag, point.real)
        normal = -1j * boundary_tangent(angle) / abs(boundary_tangent(angle))
        negative_fields.append(
            vector_dot(electric_field(point + BOUNDARY_FIELD_OFFSET * normal), normal)
        )
    for point in positive_points:
        angle = math.atan2(point.imag, point.real)
        normal = -1j * boundary_tangent(angle) / abs(boundary_tangent(angle))
        positive_fields.append(
            vector_dot(electric_field(point + BOUNDARY_FIELD_OFFSET * normal), normal)
        )
    return {
        "largest_negative_marker_normal_field": max(negative_fields),
        "smallest_positive_marker_normal_field": min(positive_fields),
    }


def verify(curves, intersecting_curves, negative_points, positive_points):
    results = {
        **verify_boundary_shape(),
        **verify_boundary_solution(),
        **verify_trajectories(curves),
        **verify_endpoint_orthogonality(intersecting_curves),
        **verify_charge_markers(negative_points, positive_points),
    }

    assert results["minimum_boundary_turn_sine"] < 0
    assert results["negative_boundary_turn_samples"] >= 10
    assert results["boundary_segment_intersections"] == 0
    assert results["boundary_potential_span"] < 5e-4
    assert results["max_nonstagnant_boundary_tangential_field_fraction"] < 5e-2
    assert results["max_boundary_tangential_field_over_peak_field"] < 2e-2
    assert results["relative_net_flux"] < 1e-3
    assert results["max_rendered_trajectory_alignment_sine"] < 3e-2
    assert results["min_rendered_trajectory_direction_cosine"] > 0.9996
    assert results["max_rendered_endpoint_tangent_fraction"] < 1e-10
    assert results["largest_negative_marker_normal_field"] < 0
    assert results["smallest_positive_marker_normal_field"] > 0
    return results


def point_to_typst(point):
    return f"({point.real:.6f}, {point.imag:.6f})"


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


def write_if_changed(path, content):
    if not path.exists() or path.read_text(encoding="utf-8") != content:
        path.write_text(content, encoding="utf-8", newline="\n")
        print(f"written {path}")
    else:
        print(f"no changes to {path}")


def main():
    curves = []
    intersecting_curves = []
    endpoints = {}

    for display_level in FIELD_LEVELS:
        target_flux = E0 * display_level
        left_points, left_hit = trace_from_left(target_flux)
        if left_hit:
            right_points, right_hit = trace_from_right(target_flux)
            if not right_hit:
                raise ValueError(
                    f"right field-line branch missed the conductor: level={display_level}"
                )
            curves.extend((left_points, right_points))
            intersecting_curves.extend(((left_points, -1), (right_points, 1)))
            endpoints[(round(display_level, 12), -1)] = left_points[-1]
            endpoints[(round(display_level, 12), 1)] = right_points[0]
        else:
            curves.append(left_points)

    negative_points = [
        endpoints[(round(level, 12), -1)] for level in CHARGE_LEVELS
    ]
    positive_points = [
        endpoints[(round(level, 12), 1)] for level in CHARGE_LEVELS
    ]
    verification = verify(
        curves, intersecting_curves, negative_points, positive_points
    )

    values = {
        "induction-body-boundary": curve_to_typst(body_boundary()),
        "induction-negative-charge-points": curve_to_typst(negative_points),
        "induction-positive-charge-points": curve_to_typst(positive_points),
        "induction-field-levels": numbers_to_typst(FIELD_LEVELS),
        "induction-total-field-curves": curves_to_typst(curves),
    }

    OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)
    geometry_content = "".join(
        typst_let(name, value) for name, value in values.items()
    )
    write_if_changed(OUTPUT_ROOT / "geometry.typ", geometry_content)
    write_if_changed(OUTPUT_ROOT / "lib.typ", '#import "geometry.typ": *\n')
    write_if_changed(
        OUTPUT_ROOT / "verification.json",
        json.dumps(verification, indent=2, sort_keys=True) + "\n",
    )
    print(json.dumps(verification, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
