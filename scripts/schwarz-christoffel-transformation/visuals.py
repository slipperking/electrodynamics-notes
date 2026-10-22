import os
import pathlib
import math
import numpy as np
import mpmath as mp

mp.mp.dps = 35

PROJECT_ROOT = pathlib.Path.cwd()
OUTPUT_ROOT = PROJECT_ROOT / "build" / "visual-output" / "schwarz-christoffel-transformation"

# inset to avoid singularity at |w|=1
XS = np.linspace(-0.9, 0.9, 18)
YS = np.linspace(-0.9, 0.9, 18)
SAMPLES_PER_LINE = 41
BOUNDARY_SAMPLES = 121
INSET_FACTOR = 0.999
OUTPUT_SCALE = 2.3
QUADRATURE_ORDER = 64

quadrature_nodes, quadrature_weights = np.polynomial.legendre.leggauss(QUADRATURE_ORDER)
quadrature_nodes = (quadrature_nodes + 1.0) / 2.0
quadrature_weights /= 2.0

Gamma = mp.gamma
C_mp = 4 * mp.sqrt(2 * mp.pi) / (Gamma(mp.mpf(1)/4) ** 2)
l_global_mp = 2 * mp.quad(lambda u: 1/mp.sqrt(1 - u**4), [0, 1])

print(f"C = {C_mp}")
print(f"l = {l_global_mp}")
print(f"C*l = {C_mp*l_global_mp} (should be 2)")

C_float = float(C_mp)
l_float = float(l_global_mp)

def I_pos_gt1_integral(z0_pos_gt1):
    upper = mp.sqrt(z0_pos_gt1 - 1)
    f = lambda s: 1/(mp.sqrt(s**2 + 1) * mp.sqrt(s**2 + 2))
    return mp.quad(f, [0, upper])

def f_real(z0_real: float):
    if abs(z0_real) < 1e-14:
        return mp.mpc(0)
    if z0_real > 0:
        if z0_real < 1 - 1e-12:
            lim = mp.sqrt(z0_real)
            I = mp.quad(lambda u: 1/mp.sqrt(1 - u**4), [0, lim])
            return -1j * 2 * I
        elif abs(z0_real - 1) <= 1e-12:
            return -1j * l_global_mp
        else:  # >1
            I = I_pos_gt1_integral(z0_real)
            return 2*I - 1j*l_global_mp
    else:
        a = -z0_real
        if a < 1 - 1e-12:
            lim = mp.sqrt(a)
            I = mp.quad(lambda u: 1/mp.sqrt(1 - u**4), [0, lim])
            return 2*I
        elif abs(a - 1) <= 1e-12:
            return l_global_mp
        else:
            I = I_pos_gt1_integral(a)
            return l_global_mp - 1j*2*I

def f_complex_upper(z0):
    if abs(z0) < 1e-14:
        return mp.mpc(0)
    def integrand(s):
        return 1/(mp.sqrt(s*s*z0 + 1) * mp.sqrt(s*s*z0 - 1))
    split = 1 / mp.sqrt(abs(z0))
    if split < 1:
        I = mp.quad(integrand, [0, split, 1])
    else:
        I = mp.quad(integrand, [0, 1])
    return 2 * mp.sqrt(z0) * I

def f_complex_upper_float(z0: complex):
    """Evaluate the smooth interior integral without adaptive mp quadrature."""
    if abs(z0) < 1e-14:
        return 0j

    split = 1.0 / math.sqrt(abs(z0))

    def integrate_interval(start, end):
        if end <= start:
            return 0j
        samples = start + (end - start) * quadrature_nodes
        integrand = 1.0 / (
            np.sqrt(samples * samples * z0 + 1.0) *
            np.sqrt(samples * samples * z0 - 1.0)
        )
        return (end - start) * np.dot(quadrature_weights, integrand)

    integral = integrate_interval(0.0, min(split, 1.0))
    if split < 1.0:
        integral += integrate_interval(split, 1.0)
    return 2.0 * np.sqrt(z0) * integral

def f_of_z0(z0):
    if isinstance(z0, (mp.mpc, mp.mpf)):
        re = float(mp.re(z0))
        im = float(mp.im(z0))
    else:
        re = z0.real if isinstance(z0, complex) else float(z0)
        im = z0.imag if isinstance(z0, complex) else 0.0

    if abs(im) < 1e-12:
        return f_real(re)
    else:
        return f_complex_upper_float(complex(z0))

def F_of_w(w):
    w_mp = mp.mpc(complex(w)) if not isinstance(w, (mp.mpc, mp.mpf)) else w
    if abs(1 - w_mp) < 1e-14:
        return mp.mpc(1, -1)
    z0 = 1j * (1 + w_mp) / (1 - w_mp)
    f = f_of_z0(z0)
    return C_mp * f - 1 + 1j

def generate_input_curves():
    input_vertical = []
    input_horizontal = []
    for x in XS:
        ym = math.sqrt(max(0.0, 1 - x*x))
        if ym < 1e-9:
            continue
        ym_eff = ym * INSET_FACTOR
        ys = np.linspace(-ym_eff, ym_eff, SAMPLES_PER_LINE)
        curve = [(float(x), float(y)) for y in ys]
        input_vertical.append(curve)
    for y in YS:
        xm = math.sqrt(max(0.0, 1 - y*y))
        if xm < 1e-9:
            continue
        xm_eff = xm * INSET_FACTOR
        xs = np.linspace(-xm_eff, xm_eff, SAMPLES_PER_LINE)
        curve = [(float(x), float(y)) for x in xs]
        input_horizontal.append(curve)

    thetas = np.linspace(0, 2*math.pi, BOUNDARY_SAMPLES)
    boundary = [(math.cos(t)*INSET_FACTOR, math.sin(t)*INSET_FACTOR) for t in thetas]
    return input_vertical, input_horizontal, boundary

def apply_F_to_curves(curves):
    out_curves = []
    total = sum(len(c) for c in curves)
    count = 0
    for curve in curves:
        out_curve = []
        for (x, y) in curve:
            w = complex(x, y)
            F = F_of_w(w)
            # convert to float
            out_curve.append((float(mp.re(F)), float(mp.im(F))))
            count += 1
            if count % 100 == 0:
                print(f"  mapped {count}/{total} points...")
        out_curves.append(out_curve)
    return out_curves

print("Generating input curves...")
in_vert, in_horiz, in_bound = generate_input_curves()
print(f"  vertical: {len(in_vert)} curves, horizontal: {len(in_horiz)}, boundary: 1")

print("Mapping to output...")
out_vert = apply_F_to_curves(in_vert)
out_horiz = apply_F_to_curves(in_horiz)

out_bound_pts = []
epsilons = [1e-5, 1e-4, 1e-3, 1e-2]
# Right edge (1, -1) to (1, 1)
out_bound_pts.append((1.0, -1.0))
for e in epsilons: out_bound_pts.append((1.0, -1.0 + e))
for t in np.linspace(-1, 1, BOUNDARY_SAMPLES // 4)[1:-1]:
    out_bound_pts.append((1.0, float(t)))
for e in reversed(epsilons): out_bound_pts.append((1.0, 1.0 - e))

# Top edge (1, 1) to (-1, 1)
out_bound_pts.append((1.0, 1.0))
for e in epsilons: out_bound_pts.append((1.0 - e, 1.0))
for t in np.linspace(1, -1, BOUNDARY_SAMPLES // 4)[1:-1]:
    out_bound_pts.append((float(t), 1.0))
for e in reversed(epsilons): out_bound_pts.append((-1.0 + e, 1.0))

# Left edge (-1, 1) to (-1, -1)
out_bound_pts.append((-1.0, 1.0))
for e in epsilons: out_bound_pts.append((-1.0, 1.0 - e))
for t in np.linspace(1, -1, BOUNDARY_SAMPLES // 4)[1:-1]:
    out_bound_pts.append((-1.0, float(t)))
for e in reversed(epsilons): out_bound_pts.append((-1.0, -1.0 + e))

# Bottom edge (-1, -1) to (1, -1)
out_bound_pts.append((-1.0, -1.0))
for e in epsilons: out_bound_pts.append((-1.0 + e, -1.0))
for t in np.linspace(-1, 1, BOUNDARY_SAMPLES // 4)[1:-1]:
    out_bound_pts.append((float(t), -1.0))
for e in reversed(epsilons): out_bound_pts.append((1.0 - e, -1.0))

out_bound = [out_bound_pts]

def typst_array(items):
    if len(items) == 0:
        return "()"
    if len(items) == 1:
        return f"({items[0]},)"
    return "(" + ", ".join(items) + ")"

def point_to_str(p):
    return f"({p[0]*OUTPUT_SCALE:.6f}, {p[1]*OUTPUT_SCALE:.6f})"

def curve_to_typst(curve):
    pts = [point_to_str(p) for p in curve]
    return typst_array(pts)

def curves_to_typst(curves):
    cs = [curve_to_typst(c) for c in curves]
    return typst_array(cs)

def typst_let(var_name, value):
    return f"#let {var_name} = {value}\n"

def write_typst_file(path, var_name, value_str):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        f.write(typst_let(var_name, value_str))
    print(f"written {path}")


OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)
write_typst_file(str(OUTPUT_ROOT / "input_vertical.typ"),
                 "input-vertical-curves",
                 curves_to_typst(in_vert))
write_typst_file(str(OUTPUT_ROOT / "input_horizontal.typ"),
                 "input-horizontal-curves",
                 curves_to_typst(in_horiz))
write_typst_file(str(OUTPUT_ROOT / "input_boundary.typ"),
                 "input-boundary-curve",
                 curves_to_typst([in_bound]))
write_typst_file(str(OUTPUT_ROOT / "output_vertical.typ"),
                 "output-vertical-curves",
                 curves_to_typst(out_vert))
write_typst_file(str(OUTPUT_ROOT / "output_horizontal.typ"),
                 "output-horizontal-curves",
                 curves_to_typst(out_horiz))
write_typst_file(str(OUTPUT_ROOT / "output_boundary.typ"),
                 "output-boundary-curve",
                 curves_to_typst(out_bound))
lib_content = ""
lib_content += f'#import "input_vertical.typ": input-vertical-curves\n'
lib_content += f'#import "input_horizontal.typ": input-horizontal-curves\n'
lib_content += f'#import "input_boundary.typ": input-boundary-curve\n'
lib_content += f'#import "output_vertical.typ": output-vertical-curves\n'
lib_content += f'#import "output_horizontal.typ": output-horizontal-curves\n'
lib_content += f'#import "output_boundary.typ": output-boundary-curve\n'
lib_content += typst_let("input-curves", typst_array(["input-vertical-curves", "input-horizontal-curves", "input-boundary-curve"]))
lib_content += typst_let("output-curves", typst_array(["output-vertical-curves", "output-horizontal-curves", "output-boundary-curve"]))

with open(OUTPUT_ROOT / "lib.typ", "w") as f:
    f.write(lib_content)
print(f"written {OUTPUT_ROOT / 'lib.typ'}")
print("Done. Files in", OUTPUT_ROOT)