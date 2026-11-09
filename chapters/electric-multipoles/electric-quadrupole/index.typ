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
  Allow the consideration of two possible expansion points $va(r)_0$ and $va(r)'_0$ yielding two moments $vaa(Q)$ and $vaa(Q)'$ respectively. Then
  $
    Q_(i j) &= integral.triple_(s' < R) rho s'_i s'_j dif^3 r' = integral.triple_(s' < R) rho(va(r)') (r'_i - r'_(0, i) + r'_(0, i) - r_(0, i))(r'_j - r'_(0, j) + r'_(0, j) - r_(0, j)) dif^3 r' \
    & = Q'_(i j) + integral.triple_(s' < R) rho(va(r)') (r'_i - r'_(0, i)) dif^3 r' (r'_(0, j) - r_(0, j)) \
    & quad "" + (r'_(0, i) - r_(0, i)) integral.triple_(s' < R) rho(va(r)') (r'_j - r'_(0, j)) dif^3 r' \
    &wide"" + (r'_(0, i) - r_(0, i))(r'_(0, j) - r_(0, j)) integral.triple_(s' < R) rho(va(r)') dif^3 r' \
    &=Q'_(i j) + p'_i (r'_(0, j) - r_(0, j)) + p'_j (r'_(0, i) - r_(0, i)) + (r'_(0, i) - r_(0, i))(r'_(0, j) - r_(0, j)) Q = 0. qedhere
  $
]
