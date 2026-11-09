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
As with the previous two instances, the construction of this term is describable with aid from a _point quadrupole_. In particular, we consider four point charges in a checkerboard pattern converging to a single point. As such, we consider two point dipoles with moments $plus.minus va(p) / d$ at $va(r)_0 plus.minus d/2 vu(c)$ with a vanishing separation $d -> 0$.

With @eq:electric-dipole-potential, the electrostatic potential of a point quadrupole is hence
$
  phi (va(r)) &= lim_(d -> 0^+) 1 / (4 uppi epsilon_0) va(p) / d dot [(va(r) - va(r)_0 - d/2 vu(c)) / norm(va(r) - va(r)_0 - d/2 vu(c))^3 - (va(r) - va(r)_0 + d/2 vu(c)) / norm(va(r) - va(r)_0 + d/2 vu(c))^3] \
  &= -lim_(d -> 0^+) 1 / (4 uppi epsilon_0) 2 / d sinh(d / 2 vu(c) dot grad) (va(p) dot va(s)) / s^3 \
  &= -lim_(d -> 0^+) 1 / (4 uppi epsilon_0) 2 / d [d / 2 vu(c) dot grad + Order(d / 2 vu(c) dot grad)^3] (va(p) dot va(s)) / s^3 \
  &= -1 / (4 uppi epsilon_0) (vu(c) dot grad) (va(p) dot va(s)) / s^3 = 1 / (4 uppi epsilon_0) (vu(c) dot grad) (va(p) dot grad) 1 / s \
  &= 1 / (4 uppi epsilon_0) 1 / 2 (vu(c) times.o va(p)) : grad^(times.o 2) 1 / s + 1 / (4 uppi epsilon_0) 1 / 2 (vu(c) times.o va(p))^top : (grad^(times.o 2))^top 1 / s \
  &= 1 / (4 uppi epsilon_0) 1 / 2 (vu(c) times.o va(p) + va(p) times.o vu(c)) : grad^(times.o 2) 1 / s
$ <eq:electric-point-quadrupole-potential>
which bears resemblance to the quadrupole term of @eq:electric-multipole-expansion, if we had previously found
$
  vaa(Q) = vu(c) times.o va(p) + va(p) times.o vu(c), wide Q_(i j) = hat(c)_i p_j + p_i hat(c)_j
$
to be consistent with @def:electric-quadrupole-moment. Notably, the charge density is expressible as the sum of that for two point dipoles:
$
  rho(va(r)) & = - lim_(d -> 0^+) va(p) / d dot grad [delta(va(r) - va(r)_0 - d/2 vu(c)) - delta(va(r) - va(r)_0 + d / 2 vu(c))] \
  & = - lim_(d -> 0^+) (2 va(p)) / d dot grad sinh(-d/2 vu(c) dot grad) delta(va(r) - va(r)_0) \
  & = - lim_(d -> 0^+) (2 va(p)) / d dot grad [-d / 2 vu(c) dot grad + d^3 Order(vu(c) dot grad)^3] delta(va(r) - va(r)_0),
$
giving
#theorem[The Point Quadrupole Density Distribution][
  $
    rho(va(r)) = (va(p) dot grad) (vu(c) dot grad) delta(va(r) - va(r)_0) = (va(p) times.o vu(c)) : grad^(times.o 2) delta(va(s)),
  $
] <thm:electric-quadrupole-charge-density>
whence
$
  vaa(Q) &= integral.triple_(s' < R) rho(va(r)') va(s)'^(times.o 2) dif^3 r' = integral.triple_(s' < R) [(va(p) times.o vu(c)) : grad'^(times.o 2) delta(va(s)')] va(s)'^(times.o 2) dif^3 r' \
  &= integral.triple_(s' < R) [(va(p) times.o vu(c)) : grad'^(times.o 2) delta(va(s)')] va(s)'^(times.o 2) dif^3 r' \
  &= integral.triple_(s' < R) va(s)'^(times.o 2) p_m hat(c)_n partial'_m partial'_n delta(va(s)') dif^3 r' = p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') partial'_m partial'_n (s'_i s'_j) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') partial'_m (s'_j partial'_n s'_i + s'_i partial'_n s'_j) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') (partial'_m s'_j partial'_n s'_i + s'_j partial'_m partial'_n s'_i + partial'_m s'_i partial'_n s'_j + s'_i partial'_m partial'_n s'_j) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') (delta_(m j) delta_(n i) + delta_(m i) delta_(n j)) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= (p_j hat(c)_i integral.triple_(s' < R) delta(va(s)') dif^3 r' + p_i hat(c)_j integral.triple_(s' < R) delta(va(s)') dif^3 r') vu(e)_i times.o vu(e)_j \
  &= vu(c) times.o va(p) + va(p) times.o vu(c),
$
wherein we have used integration by parts twice. This confirms the quadrupole as the sole term in the multipole expansion for a given point quadrupole. The corresponding moment is given by
#theorem[Electric Quadrupole Moment][
  $
    vaa(Q) = vu(c) times.o va(p) + va(p) times.o vu(c).
  $
] <thm:electric-quadrupole-moment>
