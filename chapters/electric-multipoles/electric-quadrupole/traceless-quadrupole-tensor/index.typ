#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("The Traceless Quadrupole Tensor"),
)

Apparently the direct observation of the principal axis system in @eq:electric-quadrupole-moment-principal-axis transpires to be often convoluted and implausible (often we do not know in advance the principal axis basis). It is possible to perform further reiterations on $vaa(Q)$ in an arbitrary coordinate system: by @eq:electric-quadrupole-potential,
$
  phi_2 (va(r)) &= 1/2 vaa(Q) : grad^(times.o 2) 1 / s = 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' (3 s_i s_j - s^2 delta_(i j)) / s^5 \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' (3 s_i s_j - s^2 delta_(i j)) / s^5 \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') (3 s_i s_j s'_i s'_j - s^2 s'_i^2) / s^5 d^3 r' \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') (3 s_i s_j s'_i s'_j - s^2 s'^2) / s^5 d^3 r' \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') (3 s'_i s'_j - delta_(i j) s'^2) d^3 r' (s_i s_j) / s^5 = 1 / (4 uppi epsilon_0) 1 / 2 [3 vaa(Q) - vaa(I) tr vaa(Q)] : va(s)^(times.o 2) / s^5.
$
Thus we are provided with sufficient motivation to define
#theorem[Electric Traceless Quadrupole Moment][
  Denote by $Theta_(i j)$ the _electric traceless quadrupole moment_, given by the symmetric dyadic tensor
  $
    Theta_(i j) = integral.triple_(s' < R) rho(va(r)') (3 s'_i s'_j - delta_(i j) s'^2) d^3 r' = 3 Q_(i j) - delta_(i j) Q_(k k), \
    vaa(Theta) = Theta_(i j) vu(e)_i times.o vu(e)_j = 3 vaa(Q) - vaa(I) tr vaa(Q).
  $
]
We will now verify the veracity in the term "traceless":
#proof[of the Tracelessness of $vaa(Theta)$][
  $
    tr vaa(Theta) = Theta_(i j) delta_(i j) = delta_(i j) [3 Q_(i j) - delta_(i j) Q_(k k)] = 3 Q_(i i) - delta_(i j) delta_(i j) Q_(k k) = 3 tr vaa(Q) - tr vaa(I) tr vaa(Q) = 0. qedhere
  $
]
It is incumbent to realize that the constraint $tr vaa(Theta) = 0$ implies---by symmetry---that the electric quadrupole can be determined by five numbers as two given numbers of the diagonal determine uniquely the third. This is also evident in the expression of @thm:electric-point-quadrupole-density that $va(p) in va(R)^3$ and $vu(c) in ["unit sphere"]$ give five degrees of freedom.
