import os
import re
import json
from typing import List, Optional, Tuple
from pathlib import Path

import numpy as np
from shapely.geometry import (
    GeometryCollection,
    LineString,
    MultiPolygon,
    Point,
    Polygon,
)
from shapely.geometry.polygon import orient
from shapely.ops import unary_union


def camel_to_kebab(name: str) -> str:
    s = re.sub(r'(?<=[a-z0-9])([A-Z])', r'-\1', name)
    s = re.sub(r'(?<=[A-Z])([A-Z][a-z])', r'-\1', s)
    return s.lower()


def coords_to_typst_array(coords: np.ndarray) -> str:
    items = [f"({x:.6f}, {y:.6f})" for x, y in coords]
    return typst_array(items)


def typst_array(items: list) -> str:
    # typst needs trailing comma for single-element arrays
    if len(items) == 0:
        return "()"
    if len(items) == 1:
        return f"({items[0]},)"
    return "(" + ", ".join(items) + ")"


def typst_let(var_name: str, value: str) -> str:
    return f"#let {var_name} = {value}\n"


def read_input_json(filename: Path):
    with open(filename, "r") as f:
        data = json.load(f)

    global_offset               = float(data.get("global_offset", 0.4))
    input_disk_radius_scalar    = float(data.get("input_disk_radius_scalar", 1.0))
    subcover_disk_radius_scalar = float(data.get("subcover_disk_radius_scalar", 1.0))
    samples_per_segment         = int(data.get("samples_per_segment", 20))

    pre_erosion_curves = data.get("pre_erosion_curves", [])
    support_curves     = data.get("support_curves", [])
    disk_points        = data.get("disk_points", [])

    erosion_radius_indicators    = data.get("erosion_radius_indicators", [])
    input_disk_radius_indicators = data.get("input_disk_radius_indicators", [])

    for c in pre_erosion_curves:
        c["points"] = np.array(c["points"], dtype=float)
    for c in support_curves:
        c["points"] = np.array(c["points"], dtype=float)
    disk_points = [np.array(p, dtype=float) for p in disk_points]

    return {
        "global_offset":               global_offset,
        "input_disk_radius_scalar":    input_disk_radius_scalar,
        "subcover_disk_radius_scalar": subcover_disk_radius_scalar,
        "samples_per_segment":         samples_per_segment,
        "pre_erosion_curves":          pre_erosion_curves,
        "support_curves":              support_curves,
        "disk_points":                 disk_points,
        "erosion_radius_indicators":         erosion_radius_indicators,
        "input_disk_radius_indicators":      input_disk_radius_indicators,
    }


def tikz_bezier_sample(points, tension: float = 0.55, samples_per_seg: int = 20):
    pts = np.array(points)
    n = len(pts)
    out = []
    if n == 0:
        return np.array(out)
    for i in range(n):
        p0 = pts[(i - 1) % n]
        p1 = pts[i]
        p2 = pts[(i + 1) % n]
        p3 = pts[(i + 2) % n]
        s1 = tension * (p2 - p0)
        s2 = tension * (p3 - p1)
        c1 = p1 + s1 / 3.0
        c2 = p2 - s2 / 3.0
        for t in np.linspace(0, 1, samples_per_seg, endpoint=False):
            B = (
                (1 - t) ** 3 * p1
                + 3 * (1 - t) ** 2 * t * c1
                + 3 * (1 - t) * t ** 2 * c2
                + t ** 3 * p2
            )
            out.append(B)
    return np.array(out)


def number_to_letters(n: int) -> str:
    result = ""
    n = int(n)
    while n > 0:
        n -= 1
        n, rem = divmod(n, 26)
        result = chr(65 + rem) + result
    return result if result else "A"


def compute_polygon_region(curves, samples_per_segment: int):
    outer_polys = []
    hole_polys  = []
    for c in curves:
        pts  = c["points"]
        samp = tikz_bezier_sample(pts, samples_per_seg=samples_per_segment)
        poly = Polygon(samp)
        typ  = c.get("type", "outer")
        if typ == "outer":
            poly = orient(poly, sign=1.0)
            outer_polys.append(poly)
        elif typ == "hole":
            poly = orient(poly, sign=-1.0)
            hole_polys.append(poly)
    if not outer_polys:
        return None
    outer = unary_union(outer_polys)
    holes = unary_union(hole_polys) if hole_polys else None
    return outer.difference(holes) if holes else outer


def compute_input_region(curves, samples_per_segment: int):
    return compute_polygon_region(curves, samples_per_segment)


def compute_eroded_region(curves, global_offset: float, samples_per_segment: int):
    region = compute_polygon_region(curves, samples_per_segment)
    if region is None:
        return None
    return region.buffer(-global_offset, resolution=80)


def compute_support_region(curves, samples_per_segment: int):
    return compute_polygon_region(curves, samples_per_segment)


def _arc_cumulative(coords: np.ndarray):
    diffs    = np.diff(coords, axis=0)
    seg_lens = np.sqrt((diffs ** 2).sum(axis=1))
    cum      = np.concatenate([[0.0], np.cumsum(seg_lens)])
    return diffs, cum, cum[-1]


def point_at_t(coords: np.ndarray, t: float) -> np.ndarray:
    diffs, cum, total = _arc_cumulative(coords)
    if total < 1e-12:
        return coords[0].copy()
    target = np.clip(t, 0.0, 1.0) * total
    idx    = int(np.searchsorted(cum, target, side="right")) - 1
    idx    = max(0, min(idx, len(coords) - 2))
    seg    = cum[idx + 1] - cum[idx]
    s      = (target - cum[idx]) / seg if seg > 1e-12 else 0.0
    return coords[idx] + s * diffs[idx]


def outward_normal_at_t(
    coords: np.ndarray,
    t: float,
    interior_geom,
) -> Tuple[np.ndarray, np.ndarray]:
    diffs, cum, total = _arc_cumulative(coords)
    if total < 1e-12:
        return np.array([1.0, 0.0]), coords[0].copy()

    target = np.clip(t, 0.0, 1.0) * total
    idx    = int(np.searchsorted(cum, target, side="right")) - 1
    idx    = max(0, min(idx, len(coords) - 2))

    tangent  = diffs[idx]
    tang_len = np.linalg.norm(tangent)
    tangent  = tangent / tang_len if tang_len > 1e-12 else np.array([1.0, 0.0])

    n_right = np.array([ tangent[1], -tangent[0]])
    n_left  = np.array([-tangent[1],  tangent[0]])

    point     = point_at_t(coords, t)
    test_dist = 1e-3

    if not interior_geom.contains(Point(point + test_dist * n_right)):
        return n_right, point
    return n_left, point


def all_polygons(geom) -> List[Polygon]:
    if geom is None or geom.is_empty:
        return []
    if isinstance(geom, Polygon):
        return [geom]
    if isinstance(geom, (MultiPolygon, GeometryCollection)):
        return [g for g in geom.geoms if isinstance(g, Polygon) and not g.is_empty]
    return []


def radius_indicator_endpoints(
    t: float,
    eroded_geom,
    k_geom,
    global_offset: float,
) -> Tuple[np.ndarray, np.ndarray]:
    polys = sorted(all_polygons(eroded_geom), key=lambda p: p.area, reverse=True)
    if not polys:
        raise ValueError("eroded geometry is empty - cannot compute radius indicator")

    # t spans all polygons weighted by perimeter
    coords_list  = [np.array(p.exterior.coords) for p in polys]
    perimeters   = [_arc_cumulative(c)[2] for c in coords_list]
    total_length = sum(perimeters)

    target      = t * total_length
    accumulated = 0.0
    local_coords = coords_list[0]
    local_poly   = polys[0]
    for coords, perim, poly in zip(coords_list, perimeters, polys):
        if accumulated + perim >= target or poly is polys[-1]:
            local_t      = (target - accumulated) / perim if perim > 1e-12 else 0.0
            local_coords = coords
            local_poly   = poly
            break
        accumulated += perim

    normal, start = outward_normal_at_t(local_coords, local_t, local_poly)

    ray   = LineString([start, start + global_offset * 10 * normal])
    k_bnd = k_geom.boundary
    inter = ray.intersection(k_bnd)

    if inter.is_empty:
        end = start + global_offset * normal
    elif inter.geom_type == "Point":
        end = np.array([inter.x, inter.y])
    else:
        candidates = [
            g for g in (inter.geoms if hasattr(inter, "geoms") else [inter])
            if g.geom_type == "Point"
        ]
        if candidates:
            dists = [np.linalg.norm(np.array([p.x, p.y]) - start) for p in candidates]
            pt    = candidates[int(np.argmin(dists))]
            end   = np.array([pt.x, pt.y])
        else:
            end = start + global_offset * normal

    return start, end


def write_region_boundaries(
    folder: str,
    geom_list,
    prefix: str,
    list_macro: str,
    generate_individuals: bool = True,
):
    os.makedirs(folder, exist_ok=True)
    print(f"Writing region boundaries to {folder}")

    list_var = camel_to_kebab(list_macro)

    if all(geom is None or geom.is_empty for geom in geom_list):
        path = os.path.join(folder, "all.typ")
        with open(path, "w") as f:
            f.write(typst_let(list_var, "()"))
        print(f"  empty geometry -> empty list in {path}")
        return

    rings = []
    polys = [
        g
        for geom in geom_list
        for g in (
            geom.geoms
            if isinstance(geom, (MultiPolygon, GeometryCollection))
            else [geom]
        )
    ]
    for poly in polys:
        if not isinstance(poly, Polygon):
            continue
        rings.append(poly.exterior)
        rings.extend(poly.interiors)

    all_path = os.path.join(folder, "all.typ")
    with open(all_path, "w") as f:
        if generate_individuals:
            import_lines = []
            ref_names    = []
            for i, ring in enumerate(rings, 1):
                letter   = number_to_letters(i)
                var      = camel_to_kebab(f"{prefix}{letter}")
                ref_names.append(var)

                coords = np.array(ring.coords)
                value  = coords_to_typst_array(coords)

                file_path = os.path.join(folder, f"{i}.typ")
                with open(file_path, "w") as ind:
                    ind.write(typst_let(var, value))
                print(f"  written curve {i} to {file_path}")

                import_lines.append(f'#import "{i}.typ": {var}')

            f.write("\n".join(import_lines) + "\n")
            f.write(typst_let(list_var, typst_array(ref_names)))
            print(
                f"  written list variable {list_var} with {len(ref_names)}"
                f" references to {all_path}"
            )

        else:
            path_values = []
            for ring in rings:
                coords = np.array(ring.coords)
                path_values.append(coords_to_typst_array(coords))

            if len(path_values) <= 1:
                list_value = typst_array(path_values)
            else:
                inner      = ",\n  ".join(path_values)
                list_value = f"(\n  {inner},\n)"

            f.write(typst_let(list_var, list_value))
            print(
                f"  written list variable {list_var} with {len(path_values)}"
                f" inline paths to {all_path}"
            )


def write_input_disks(folder: str, disk_points: List[np.ndarray], disk_r: float):
    os.makedirs(folder, exist_ok=True)
    print(f"Writing input disks to {folder}")

    ref_names = []
    for i, center in enumerate(disk_points, 1):
        letter = number_to_letters(i)
        var    = camel_to_kebab(f"InputDisk{letter}")
        ref_names.append(var)

        angles   = np.linspace(0, 2 * np.pi, 100)
        circle_x = center[0] + disk_r * np.cos(angles)
        circle_y = center[1] + disk_r * np.sin(angles)
        coords   = np.column_stack((
            np.append(circle_x, circle_x[0]),
            np.append(circle_y, circle_y[0]),
        ))
        value = coords_to_typst_array(coords)

        file_path = os.path.join(folder, f"{i}.typ")
        with open(file_path, "w") as f:
            f.write(typst_let(var, value))
        print(f"  written disk boundary {i} to {file_path}")

    centers_path = os.path.join(folder, "centers.typ")
    center_items = [f"({p[0]:.6f}, {p[1]:.6f})" for p in disk_points]
    with open(centers_path, "w") as f:
        f.write(typst_let("input-disk-centers", typst_array(center_items)))
    print(f"  written {len(disk_points)} centers to {centers_path}")

    all_path = os.path.join(folder, "all.typ")
    with open(all_path, "w") as f:
        import_lines = "\n".join(
            f'#import "{i + 1}.typ": {ref_names[i]}' for i in range(len(ref_names))
        )
        f.write(import_lines + "\n")
        f.write('#import "centers.typ": *\n')
        f.write(typst_let("input-disk-list", typst_array(ref_names)))
    print(f"  written input-disk-list to {all_path}")


def write_subcover_centers(folder: str, sub_centers: List[np.ndarray], r_sub: float):
    os.makedirs(folder, exist_ok=True)
    print(f"Writing subcover centers to {folder}")

    lib_path     = os.path.join(folder, "lib.typ")
    center_items = [f"({p[0]:.6f}, {p[1]:.6f})" for p in sub_centers]
    with open(lib_path, "w") as f:
        f.write(typst_let("subcover-disk-centers", typst_array(center_items)))
        f.write(typst_let("subcover-disk-radius", f"{r_sub:.6f}"))
    print(f"  written {len(sub_centers)} subcover centers and radius to {lib_path}")


def write_wkt(folder: str, name: str, geom):
    os.makedirs(folder, exist_ok=True)
    path    = os.path.join(folder, f"{name}.wkt")
    content = "EMPTY\n" if geom is None or geom.is_empty else geom.wkt + "\n"
    with open(path, "w") as f:
        f.write(content)
    print(f"Written WKT for {name} to {path} (empty: {geom is None or geom.is_empty})")


def write_erosion_radius_indicators(
    folder: str,
    indicators: list,
    eroded_geom,
    k_geom,
    global_offset: float,
):
    os.makedirs(folder, exist_ok=True)
    print(f"Writing erosion radius indicators to {folder}")

    ref_names    = []
    import_lines = []

    for i, ind in enumerate(indicators, 1):
        t = float(ind["t"])

        start, end = radius_indicator_endpoints(t, eroded_geom, k_geom, global_offset)

        var = f"erosion-radius-indicator-{i}"
        ref_names.append(var)
        value = typst_array([
            f"({start[0]:.6f}, {start[1]:.6f})",
            f"({end[0]:.6f}, {end[1]:.6f})",
        ])

        file_path = os.path.join(folder, f"{i}.typ")
        with open(file_path, "w") as f:
            f.write(typst_let(var, value))

        import_lines.append(f'#import "{i}.typ": {var}')
        print(
            f"  erosion radius indicator {i}  t={t:.4f}"
            f"  start=({start[0]:.4f}, {start[1]:.4f})"
            f"  end=({end[0]:.4f}, {end[1]:.4f})"
        )

    all_path = os.path.join(folder, "all.typ")
    with open(all_path, "w") as f:
        f.write("\n".join(import_lines) + "\n")
        f.write(typst_let("erosion-radius-indicator-list", typst_array(ref_names)))
    print(f"  written erosion-radius-indicator-list ({len(ref_names)} entries) to {all_path}")


def write_input_disk_radius_indicators(
    folder: str,
    indicators: list,
    disk_points: List[np.ndarray],
    disk_r: float,
):
    os.makedirs(folder, exist_ok=True)
    print(f"Writing input disk radius indicators to {folder}")

    ref_names    = []
    import_lines = []

    for i, ind in enumerate(indicators, 1):
        disk_idx  = int(ind["disk_index"])
        angle_deg = float(ind["angle_deg"])

        if disk_idx < 0 or disk_idx >= len(disk_points):
            raise IndexError(
                f"input_disk_radius_indicators[{i - 1}].disk_index={disk_idx}"
                f" is out of range (have {len(disk_points)} disk points)"
            )

        center    = disk_points[disk_idx]
        angle_rad = np.deg2rad(angle_deg)
        direction = np.array([np.cos(angle_rad), np.sin(angle_rad)])
        end       = center + disk_r * direction

        var = f"input-disk-radius-indicator-{i}"
        ref_names.append(var)
        value = typst_array([
            f"({center[0]:.6f}, {center[1]:.6f})",
            f"({end[0]:.6f}, {end[1]:.6f})",
        ])

        file_path = os.path.join(folder, f"{i}.typ")
        with open(file_path, "w") as f:
            f.write(typst_let(var, value))

        import_lines.append(f'#import "{i}.typ": {var}')
        print(
            f"  input disk radius indicator {i}"
            f"  disk_index={disk_idx}  angle={angle_deg}deg"
            f"  center=({center[0]:.4f}, {center[1]:.4f})"
            f"  edge=({end[0]:.4f}, {end[1]:.4f})"
        )

    all_path = os.path.join(folder, "all.typ")
    with open(all_path, "w") as f:
        f.write("\n".join(import_lines) + "\n")
        f.write(typst_let("input-disk-radius-indicator-list", typst_array(ref_names)))
    print(
        f"  written input-disk-radius-indicator-list ({len(ref_names)} entries)"
        f" to {all_path}"
    )


def write_lib_typ(root: str):
    os.makedirs(root, exist_ok=True)
    lib_path = os.path.join(root, "lib.typ")
    lines = [
        '#import "covered_disjoint_union_region/all.typ": *',
        '#import "covered_region/all.typ": *',
        '#import "eroded_region/all.typ": *',
        '#import "erosion_radius_indicators/all.typ": *',
        '#import "input_disk_radius_indicators/all.typ": *',
        '#import "input_disks/all.typ": *',
        '#import "no_centers_region/all.typ": *',
        '#import "pre_erosion_region/all.typ": *',
        '#import "subcover/lib.typ": *',
        '#import "support_region/all.typ": *',
    ]
    content = "\n".join(lines) + "\n"
    if os.path.exists(lib_path):
        with open(lib_path) as f:
            if f.read() == content:
                print(f"no changes to {lib_path}")
                return
    with open(lib_path, "w") as f:
        f.write(content)
    print(f"written {lib_path}")


def prune_redundant_disks(
    centers: List[np.ndarray],
    r_sub: float,
    covered_region,
    nocenters_region,
) -> List[np.ndarray]:
    if not centers:
        return []

    points           = [Point(p) for p in centers]
    disks            = [p.buffer(r_sub, resolution=50) for p in points]
    useful_areas     = [disk.intersection(covered_region) for disk in disks]
    useful_area_vals = [ua.area for ua in useful_areas]

    sorted_idx = sorted(
        range(len(centers)), key=lambda i: useful_area_vals[i], reverse=True
    )

    kept_idx      = []
    current_union = None
    epsilon       = 1e-8

    for i in sorted_idx:
        contrib = useful_areas[i]
        if contrib.is_empty or contrib.area < epsilon:
            continue
        remaining = contrib if current_union is None else contrib.difference(current_union)
        if not remaining.is_empty and remaining.area >= epsilon:
            kept_idx.append(i)
            current_union = (
                disks[i] if current_union is None
                else current_union.union(disks[i])
            )

    pruned = [centers[i] for i in kept_idx]
    print(
        f"Pruned subcover disks: {len(centers)} -> {len(pruned)}"
        f" (strict: zero-contribution only)"
    )
    return pruned


def main():
    SCRIPT_DIR   = Path(__file__).parent.resolve()
    PROJECT_ROOT = Path.cwd()
    INPUT_JSON   = SCRIPT_DIR / "curves.json"
    OUTPUT_ROOT  = PROJECT_ROOT / "build" / "visual-output" / "mergelyans-theorem"

    OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)

    cfg = read_input_json(INPUT_JSON)

    K       = compute_input_region(cfg["pre_erosion_curves"], cfg["samples_per_segment"])
    Eroded  = compute_eroded_region(
        cfg["pre_erosion_curves"], cfg["global_offset"], cfg["samples_per_segment"]
    )
    Support = compute_support_region(cfg["support_curves"], cfg["samples_per_segment"])

    CoveredRegion = Support.difference(Eroded) if Support and Eroded else Support

    disk_r = cfg["input_disk_radius_scalar"] * cfg["global_offset"]
    D = (
        unary_union([Point(p).buffer(disk_r, resolution=50) for p in cfg["disk_points"]])
        if cfg["disk_points"]
        else None
    )
    NoCentersRegion = unary_union([g for g in [K, D] if g])

    for name, geom in [
        ("K_region",         K),
        ("ErodedRegion",     Eroded),
        ("support_region",   Support),
        ("CoveredRegion",    CoveredRegion),
        ("D_region",         D),
        ("NoCentersRegion",  NoCentersRegion),
    ]:
        write_wkt(str(OUTPUT_ROOT), name, geom)

    write_input_disks(str(OUTPUT_ROOT / "input_disks"), cfg["disk_points"], disk_r)

    write_region_boundaries(
        str(OUTPUT_ROOT / "pre_erosion_region"),
        [K], "PreErosionRegion", "PreErosionRegionList", False,
    )
    write_region_boundaries(
        str(OUTPUT_ROOT / "eroded_region"),
        [Eroded], "ErodedRegion", "ErodedRegionList", False,
    )
    write_region_boundaries(
        str(OUTPUT_ROOT / "support_region"),
        [Support], "SupportRegion", "SupportRegionList", False,
    )
    write_region_boundaries(
        str(OUTPUT_ROOT / "covered_region"),
        [CoveredRegion], "CoveredRegion", "CoveredRegionList", False,
    )
    write_region_boundaries(
        str(OUTPUT_ROOT / "no_centers_region"),
        [NoCentersRegion], "NoCentersRegion", "NoCentersRegionList", False,
    )

    if cfg["erosion_radius_indicators"]:
        write_erosion_radius_indicators(
            str(OUTPUT_ROOT / "erosion_radius_indicators"),
            cfg["erosion_radius_indicators"],
            Eroded, K,
            cfg["global_offset"],
        )

    if cfg["input_disk_radius_indicators"]:
        write_input_disk_radius_indicators(
            str(OUTPUT_ROOT / "input_disk_radius_indicators"),
            cfg["input_disk_radius_indicators"],
            cfg["disk_points"],
            disk_r,
        )

    r_sub = cfg["global_offset"] * cfg["subcover_disk_radius_scalar"]
    l = max(0, (cfg["subcover_disk_radius_scalar"] - 1) / 8 * cfg["global_offset"])

    H_prime       = CoveredRegion.buffer(l, resolution=80) if CoveredRegion else Polygon()
    H_doubleprime = H_prime.boundary
    N             = NoCentersRegion.buffer(l, resolution=80) if NoCentersRegion else Polygon()
    N_prime       = N.boundary
    curves_geom   = unary_union([H_doubleprime, N_prime]).difference(NoCentersRegion)

    linestrings = []
    if curves_geom.geom_type == "LineString":
        linestrings.append(curves_geom)
    elif curves_geom.geom_type == "MultiLineString":
        linestrings.extend(curves_geom.geoms)
    elif curves_geom.geom_type == "GeometryCollection":
        for g in curves_geom.geoms:
            if g.geom_type == "LineString":
                linestrings.append(g)

    sub_centers = []
    d    = r_sub * np.sqrt(3)

    # FIX: tighter boundary sampling — was d * 0.8, now d * 0.4 — so centers
    # hug the NoCentersRegion boundary much more densely.
    step = d * 0.4

    for ls in linestrings:
        length = ls.length
        if length == 0:
            continue
        distances = np.arange(0, length, step)
        for dist in distances:
            pt = ls.interpolate(dist)
            if not NoCentersRegion.contains(pt):
                sub_centers.append(np.array([pt.x, pt.y]))
        last_dist = distances[-1] if len(distances) > 0 else 0
        if length - last_dist > 1e-6:
            pt = ls.interpolate(length)
            if not NoCentersRegion.contains(pt):
                sub_centers.append(np.array([pt.x, pt.y]))

    allowed_interior = CoveredRegion.difference(NoCentersRegion)
    if not allowed_interior.is_empty:
        minx, miny, maxx, maxy = allowed_interior.bounds
        row_spacing = (np.sqrt(3) / 2) * d
        col_spacing = d
        row = 0
        y = miny - row_spacing
        while y <= maxy + row_spacing:
            offset = (col_spacing / 2) if row % 2 == 1 else 0
            x = minx - col_spacing + offset
            while x <= maxx + col_spacing:
                pt = Point(x, y)
                if allowed_interior.contains(pt):
                    sub_centers.append(np.array([x, y]))
                x += col_spacing
            y += row_spacing
            row += 1

    for _ in range(10):
        sub_disks  = [Point(p).buffer(r_sub, resolution=50) for p in sub_centers]
        union_sub  = unary_union(sub_disks) if sub_disks else Polygon()
        uncovered  = CoveredRegion.difference(union_sub)
        if uncovered.is_empty:
            break
        geoms = uncovered.geoms if hasattr(uncovered, "geoms") else [uncovered]
        for g in geoms:
            if g.is_empty:
                continue
            cent = g.centroid
            if not NoCentersRegion.contains(cent):
                sub_centers.append(np.array([cent.x, cent.y]))
            else:
                possible = cent.buffer(r_sub).difference(NoCentersRegion)
                if not possible.is_empty:
                    # FIX: centroid of a crescent/donut can land back inside
                    # NoCentersRegion. Use representative_point() as fallback —
                    # it is guaranteed to lie within the geometry.
                    candidate = possible.centroid
                    if NoCentersRegion.contains(candidate):
                        candidate = possible.representative_point()
                    if not NoCentersRegion.contains(candidate):
                        sub_centers.append(np.array([candidate.x, candidate.y]))

    # Safety net: strip any center that somehow ended up inside NoCentersRegion.
    before = len(sub_centers)
    sub_centers = [
        c for c in sub_centers
        if not NoCentersRegion.contains(Point(c))
    ]
    removed = before - len(sub_centers)
    if removed:
        print(f"Safety filter removed {removed} center(s) inside NoCentersRegion")

    sub_centers = prune_redundant_disks(
        sub_centers, r_sub, CoveredRegion, NoCentersRegion
    )
    write_subcover_centers(str(OUTPUT_ROOT / "subcover"), sub_centers, r_sub)

    final_union = (
        unary_union([Point(p).buffer(r_sub, resolution=80) for p in sub_centers])
        if sub_centers
        else Polygon()
    )
    write_wkt(str(OUTPUT_ROOT), "SubcoverRegion", final_union)

    covered_disjoint_union_region = []
    current_union = None
    for center in sub_centers:
        disk    = Point(center).buffer(r_sub, resolution=80)
        contrib = disk.intersection(CoveredRegion)
        if contrib.is_empty:
            covered_disjoint_union_region.append(Polygon())
            continue
        remaining = contrib if current_union is None else contrib.difference(current_union)
        covered_disjoint_union_region.append(remaining)
        current_union = (
            disk.intersection(CoveredRegion)
            if current_union is None
            else current_union.union(contrib)
        )

    write_region_boundaries(
        str(OUTPUT_ROOT / "covered_disjoint_union_region"),
        covered_disjoint_union_region,
        "CoveredDisjointUnionRegion", "CoveredDisjointUnionRegionList", False,
    )
    write_lib_typ(str(OUTPUT_ROOT))


if __name__ == "__main__":
    main()