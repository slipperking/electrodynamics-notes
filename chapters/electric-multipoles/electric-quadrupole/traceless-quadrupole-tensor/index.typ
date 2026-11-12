#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("The Traceless Quadrupole Tensor"),
)

Apparently the direct observation of the principal axis system in @eq:electric-quadrupole-moment-principal-axis transpires to be often convoluted and implausible (often we do not know in advance the principal axis basis). It is possible to perform further reiterations on $vaa(Q)$ in an arbitrary coordinate system: by @eq:electric-quadrupole-potential,
$
  phi_2 (va(r)) &= 1 / (4 uppi epsilon_0) vaa(Q) : grad^(times.o 2) 1 / s = 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' (3 s_i s_j - s^2 delta_(i j)) / s^5 \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' (3 s_i s_j - s^2 delta_(i j)) / s^5 \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') (3 s_i s_j s'_i s'_j - s^2 s'_i^2) / s^5 d^3 r' \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') (3 s_i s_j s'_i s'_j - s^2 s'^2) / s^5 d^3 r' \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') (3 s'_i s'_j - delta_(i j) s'^2) d^3 r' (s_i s_j) / s^5 = 1 / (4 uppi epsilon_0) [3 vaa(Q) - vaa(I) tr vaa(Q)] : va(s)^(times.o 2) / s^5.
$
Thus we are provided with sufficient motivation to define
#theorem[Electric Traceless Quadrupole Moment][
  Denote by $Theta_(i j)$ the _electric traceless quadrupole moment_, given by the symmetric dyadic tensor
  $
    Theta_(i j) = 1/2 integral.triple_(s' < R) rho(va(r)') (3 s'_i s'_j - delta_(i j) s'^2) d^3 r' = 3 Q_(i j) - delta_(i j) Q_(k k), \
    vaa(Theta) = Theta_(i j) vu(e)_i times.o vu(e)_j = 3 vaa(Q) - vaa(I) tr vaa(Q).
  $
]
We will now verify the veracity in the term "traceless":
#proof[of the Tracelessness of $vaa(Theta)$][
  $
    tr vaa(Theta) = Theta_(i j) delta_(i j) = delta_(i j) [3 Q_(i j) - delta_(i j) Q_(k k)] = 3 Q_(i i) - delta_(i j) delta_(i j) Q_(k k) = 3 tr vaa(Q) - tr vaa(I) tr vaa(Q) = 0. qedhere
  $
]
It is incumbent to realize that the constraint $tr vaa(Theta) = 0$ implies---by symmetry---that the electric quadrupole can be determined by five numbers as two given numbers of the diagonal determine uniquely the third. This is also evident in the expression of @eq:electric-point-quadrupole-density-two-vectors that $va(p) in va(R)^3$ and $vu(c) in ["unit sphere"]$ give five degrees of freedom.
#example[
  Determine the traceless quadrupole tensor $vaa(Theta)$ about $va(r)_0$ in the principal axis coordinate system for an ellipsoid centered at $va(r)_0$ carrying a uniform volume charge density $rho$ with volume $V$ and semi-axes $a_x,a_y,a_z$.
] <ex:electric-traceless-quadrupole-tensor-ellipsoid>
#solution[to @ex:electric-traceless-quadrupole-tensor-ellipsoid][
  Choose the orthonormal basis $vu(x), vu(y), vu(z)$ to be parallel with the semi-axes. Then substituting $s'_k = a_k s_k$,
  $
    Theta_(i j) = rho /2 integral.triple_(sum_k s'_k^2 / a_k^2 < 1) (3 s'_i s'_j - delta_(i j) s'^2) dif^3 r' = rho / 2 integral.triple_(s < 1) (3 a_i a_j s_i s_j - delta_(i j) sum_k a_k^2 s_k^2) a_x a_y a_z dif^3 r,
  $
  vanishing whensoever $i != j$ by symmetry and otherwise giving
  $
    Theta_(i i) &= (rho a_x a_y a_z) / 2 [integral.triple_(s < 1) 3 a_i^2 s_i^2 dif^3 r - integral.triple_(s < 1) sum_k a_k^2 s_k^2 dif^3 r] \
    &= (rho a_x a_y a_z) / 2 [integral.triple_(s < 1) (2 a_i^2 s_i^2 - sum_(k != i) a_k^2 s_k^2) dif^3 r].
  $
  By virtue of symmetry,
  $
    integral.triple_(s < 1) s_1^2 dif^3 r = integral.triple_(s < 1) s_2^2 dif^3 r = integral.triple_(s < 1) s_3^2 dif^3 r,\
    integral.triple_(s < 1) (s_1^2 + s_2^2 + s_3^2) dif^3 r = integral.triple_(s < 1) s^2 dif^3 r = integral_0^1 s^2 (4 uppi s^2) dif s = (4 uppi) / 5, \
    integral.triple_(s < 1) s_k^2 dif^3 r = (4 uppi) / 15,
  $
  whereby
  $
    Theta_(i i) &= (rho a_x a_y a_z) / 2 [integral.triple_(s < 1) (2 a_i^2 s_i^2 - sum_(k != i) a_k^2 s_k^2) dif^3 r] = (rho a_x a_y a_z) / 2 [2 a_i^2 - sum_(k != i) a_k^2] (4 uppi) / 15 \
    &= (3V) / (4 uppi) rho / 2 [2 a_i^2 - sum_(k != i) a_k^2] (4 uppi) / 15 = (rho V) / (10) [2 a_i^2 - sum_(k != i) a_k^2]. qedhere
  $
  Observe in its particularity that $Theta_(x x) + Theta_(y y) + Theta_(z z)$.
]

