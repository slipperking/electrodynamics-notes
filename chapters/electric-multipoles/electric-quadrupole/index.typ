#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("The Electric Quadrupole"),
  children: {
    include "traceless-quadrupole-tensor/index.typ"
    include "quadrupole-force-and-torque/index.typ"
  },
)

Following from @eq:electric-multipole-expansion, we now consider the effect for when $Q = 0 = va(p)$, so that the leading term of the expansion is the quadrupole with moment
#thm-state.thm-restate("def:electric-quadrupole-moment")
As with @sec:electric-dipole,
#theorem[
  If $Q = va(p) = 0$, then the electric quadrupole moment is independent of $va(r)_0$.
] <thm:electric-quadrupole-moment-exp-point-invariance>
#proof[
  Allow the consideration of two possible expansion points $va(r)_0$ and $va(r)'_0$ yielding two moments $vaa(Q)$ and $vaa(Q)'$ respectively. Then we also have $va(p) = va(p)' = 0$ by @thm:electric-dipole-moment-exp-point-invariance. Then
  $
    Q_(i j) &= integral.triple_(s' < R) rho s'_i s'_j dif^3 r' = integral.triple_(s' < R) rho(va(r)') (r'_i - r'_(0, i) + r'_(0, i) - r_(0, i))(r'_j - r'_(0, j) + r'_(0, j) - r_(0, j)) dif^3 r' \
    & = Q'_(i j) + integral.triple_(s' < R) rho(va(r)') (r'_i - r'_(0, i)) dif^3 r' (r'_(0, j) - r_(0, j)) \
    & quad "" + (r'_(0, i) - r_(0, i)) integral.triple_(s' < R) rho(va(r)') (r'_j - r'_(0, j)) dif^3 r' \
    &wide"" + (r'_(0, i) - r_(0, i))(r'_(0, j) - r_(0, j)) integral.triple_(s' < R) rho(va(r)') dif^3 r' \
    &=Q'_(i j) + p'_i (r'_(0, j) - r_(0, j)) + p'_j (r'_(0, i) - r_(0, i)) + (r'_(0, i) - r_(0, i))(r'_(0, j) - r_(0, j)) Q = Q'_(i j). qedhere
  $
]
As with the previous two instances, the construction of this term is describable a _point quadrupole_. In particular, we consider four point charges in a checkerboard pattern converging to a single point. As such, we consider two point dipoles with moments $plus.minus va(p) / d$ at $va(r)_0 plus.minus d/2 vu(c)$ with a vanishing separation $d -> 0$.

With @eq:electric-dipole-potential, the electrostatic potential of a point quadrupole is hence
$
  phi_2 (va(r)) &= lim_(d -> 0^+) 1 / (4 uppi epsilon_0) va(p) / d dot [(va(r) - va(r)_0 - d/2 vu(c)) / norm(va(r) - va(r)_0 - d/2 vu(c))^3 - (va(r) - va(r)_0 + d/2 vu(c)) / norm(va(r) - va(r)_0 + d/2 vu(c))^3] \
  &= -lim_(d -> 0^+) 1 / (4 uppi epsilon_0) 2 / d sinh(d / 2 vu(c) dot grad) (va(p) dot va(s)) / s^3 \
  &= -lim_(d -> 0^+) 1 / (4 uppi epsilon_0) 2 / d [d / 2 vu(c) dot grad + Order(d / 2 vu(c) dot grad)^3] (va(p) dot va(s)) / s^3 \
  &= -1 / (4 uppi epsilon_0) (vu(c) dot grad) (va(p) dot va(s)) / s^3 = 1 / (4 uppi epsilon_0) (vu(c) dot grad) (va(p) dot grad) 1 / s
$ <eq:electric-point-quadrupole-potential>
