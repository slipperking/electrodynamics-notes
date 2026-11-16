#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Legendre Polynomials"),
)

Herein shall we rederive an expansion by replacing the expansion in @eq:electric-multipole-expansion-kernel in lieu thereof with the following:
$
  1 / norm(va(s) - va(s)') &= 1 / sqrt((va(s) - va(s)') dot (va(s) - va(s)')) = 1 / sqrt(s^2 - 2 va(s) dot va(s)' + s'^2) = 1 / s [1 - 2 s' / s vu(s) dot vu(s)' + s'^2 / s^2]^(-1/2).
$
Denote
$
  x = vu(s) dot vu(s)', wide t = s' / s, #tag[$(s' < R < s)$]
$
whereby
$
  1 / norm(va(s) - va(s)') = 1 / s 1 / sqrt(1 - 2 x t + t^2) = 1 / s sum_(ell = 0)^oo evaluated(pdv(, t, [ell]) 1 / sqrt(1 - 2 x t + t^2))_(t = 0) t^ell / ell!.
$
wherein the function is singular for $t = x plus.minus ii sqrt(1 - x^2)$, notably occurring only when $abs(t) = 1$. Therefore, the previous representation is convergent for $abs(t) < 1$, whose veracity originates from $s' < R < s$. Let
#definition[Legendre Polynomial][
  $
    P_ell (x) = 1 / ell! evaluated(pdv(, t, [ell]) 1 / sqrt(1 - 2 x t + t^2))_(t = 0), wide wide (ell in NN)
  $ <eq:legendre-polynomial>
]
be denoted a _Legendre polynomial_, the polynomiality whereof we shall now substantiate. Write
$
  F(x, t) = 1 / sqrt(1 - 2 x t + t^2) = sum_(ell = 0)^oo evaluated(pdv(, t, [ell]) 1 / sqrt(1 - 2 x t + t^2))_(t = 0) t^ell / ell! = sum_(ell = 0)^oo P_ell (x) t^ell,\
  pdv(F, t)(x,t) = (x - t) (1 - 2 x t + t^2)^(-3/2) = (x - t) / (1 - 2 x t + t^2) F(x,t),
$
giving
$
  (1 - 2 x t + t^2) sum_(ell = 0)^oo (ell + 1) P_(ell + 1) (x) t^ell = (x - t) sum_(ell = 0)^oo P_ell (x) t^ell.
$
Comparing the coefficients of $t^ell$ for fixed $ell >= 1$,
$
  (ell + 1) P_(ell + 1) (x) - 2 x ell P_(ell) (x) + (ell - 1) P_(ell - 1)(x) = x P_ell (x) - P_(ell - 1) (x), \
  (ell + 1) P_(ell + 1) (x) = x(2 ell + 1) P_ell (x) - ell P_(ell - 1)(x) , \
$
with polynomial base cases $P_0 (x) = 1$ and $P_1 (x) = x$, we aver from recursion that each $P_ell$ is a polynomial.

The utilization of the raw expression @eq:legendre-polynomial is often inconvenient. In lieu thereof, we derive the _Rodrigues' formula_, for which we appeal to complex-analytic methods. Writing
$
  P_ell (x) = 1 / ell! evaluated(pdv(, t, [ell]) F(x,t))_(t = 0),
$
with $gamma = {t: abs(t) = 1/2 (<1)}$, by the Cauchy--Goursat (differentiation) formula we have
$
  P_ell (x) &= 1 / (2 uppi ii) integral.cont_gamma F(x,t) / (t^(ell + 1)) dt = 1 / (2 uppi ii) integral.cont_gamma dt / (t^(ell + 1) sqrt(1 - 2 x t + t^2)),
$
wherein $F = 1 / sqrt(1 - 2 x t + t^2)$ utilizes the principal branch square root and is analytic in $t$ on the unit disk. Utilize a substitution $z in CC$ such that
$
  sqrt(1 - 2 x t + t^2) = 1 - t z, \
  1 - 2 x t + t^2 = 1 + t^2 z^2 - 2 t z ==> t^2 (z^2 - 1) + 2 t(x - z) = 0 ==> t = (2(z - x)) / (z^2 - 1), \
  dt = (2(z^2 - 1) - 4z(z - x)) / (z^2 - 1)^2 dz = (2(1 - t z)) / (z^2 - 1) dz,\
  Gamma = {z : abs((2(z - x)) / (z^2 - 1)) = 1/2 } = {(1 - sqrt(1 - 2 x t + t^2) ) / t : t in gamma},
$
giving
$
  P_ell (x) & = 1 / (2 uppi ii) integral.cont_Gamma (2(1 - t z)) / (z^2 - 1) dz / (((2(z - x)) / (z^2 - 1))^(ell + 1) (1 - t z)) = 1 / (2 uppi ii) integral.cont_Gamma ((z^2 - 1)^ell) / (2^ell (z - x)^(ell + 1)) dz \
  & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell op("Ind")_Gamma x #tag[(Cauchy--Goursat formula)] \
  & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell 1 / (2 uppi ii) integral.cont_Gamma dz / (z - x) \
  &= 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell integral.cont_gamma dt / t(1- t z).
$
Expressing $F$ in lieu of $1 - t z$,
$
  P_ell (x) & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell 1 / (2 uppi ii) sum_(ell = 0)^oo P_ell (x) integral.cont_gamma t^(ell - 1) dt \
  &= 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell 1 / (2 uppi ii) integral.cont_gamma t^(- 1) dt,
$
giving
#theorem[Rodrigues' Formula][
  $ P_ell (x) & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell. $
] <thm:rodrigues-formula>
This consequently gives rise to
#theorem[The Orthogonality Relation][
  $
    integral_(-1)^1 P_ell (x) P_(ell') (x) dx = 2 / (2 ell + 1) delta_(ell ell')
  $
]
#proof(collapsed: true)[of the Orthogonality Relation][
  Without loss of generality we shall assume $ell >= ell'$. We substitute @thm:rodrigues-formula and integrate by parts:
  $
    integral_(-1)^1 P_ell (x) P_(ell') (x) dx & = 1 / (2^ell ell!) integral_(-1)^1 P_ell' (x) dv(, x, ell) (x^2 - 1)^ell dx \
    & = 1 / (2^ell ell!) [evaluated(P_ell' (x) dv(, x, ell-1) (x^2 - 1)^ell)_(-1)^1 - integral_(-1)^1 P'_ell' (x) dv(, x, ell-1) (x^2 - 1)^ell dx].
  $
  For any $k < ell$, applying the Cauchy--Goursat formula gives
  $
    evaluated(dv(, x, k) [(x + 1)^ell (x-1)^ell])_(x = plus.minus 1) &= k! / (2 uppi ii) integral.cont_(abs(x minus.plus 1) = epsilon) ((x + 1)^ell (x-1)^ell) / (x minus.plus 1)^(k + 1) dx \
    &= k! / (2 uppi ii) integral.cont_(abs(x minus.plus 1) = epsilon) (x plus.minus 1)^ell (x minus.plus 1)^(ell - k - 1) dx = 0,
  $
  whence we obtain
  $
    integral_(-1)^1 P_ell (x) P_(ell') (x) dx & = -1 / (2^ell ell!) integral_(-1)^1 P'_ell' (x) dv(, x, ell-1) (x^2 - 1)^ell dx \
    &=1 / (2^ell ell!) integral_(-1)^1 P''_ell' (x) dv(, x, ell-2) (x^2 - 1)^ell dx \
    &wide dots.v \
    &=(-1)^ell / (2^ell ell!) integral_(-1)^1 P_ell'^((ell)) (x) (x^2 - 1)^ell dx.
  $
  If $ell' < ell$,
  $
    P_ell'^((ell)) (x) = 1 / (2^ell' ell'!) dv(, x, ell + ell') (x^2 - 1)^ell' = 0
  $
  by observation that the $ell + ell' > 2 ell'$-th derivative of a polynomial of degree $2 ell'$ vanishes. Thus $ell != ell'$ gives the original integral to be zero. If in lieu thereof $ell' = ell$,
  $
    P_ell'^((ell)) (x) & = 1 / (2^ell ell!) dv(, x, 2ell) (x^2 - 1)^ell \
    & = 1 / (2^ell ell!) dv(, x, 2ell) [x^(2 ell) + #[[polynomial of degree $< 2 ell$]]] = (2 ell)! / (2^ell ell!),
  $
  whereupon
  $
    integral_(-1)^1 P_ell (x) P_(ell') (x) dx & = ((-1)^ell (2 ell)!) / (4^ell ell!^2) 2 integral_0^1 (x^2 - 1)^ell dx \
    & = ((-1)^ell (2 ell)!) / (4^ell ell!^2) integral_(-1)^0 (t^ell) / (sqrt(t + 1)) dt = ((2 ell)!) / (4^ell ell!^2) integral_0^1 t^ell (1 - t)^(-1/2) dt \
    &= ((2 ell)!) / (4^ell ell!^2) Beta(ell + 1, 1/2) = ((2 ell)!) / (4^ell ell!^2) (Gamma(ell + 1)Gamma(1/2)) / Gamma(ell + 3/2) \
    &=((2 ell)!) / (4^ell ell!) 1/((ell + 1/2)(ell - 1/2) dots.c 1/2)=(2^(ell + 1)) / (4^ell ell!) ((2 ell)(2 ell - 1) dots.c 1)/((2 ell + 1)(2 ell - 1) dots.c 1) \
    &=2 / (2^ell ell!) ((2 ell)(2 ell - 2) dots.c 2)/(2 ell + 1) = 2 / (2 ell + 1). qedhere
  $
]
and also gives rise to
#theorem[Completeness Relation][
  $
    sum_(ell = 0)^oo (2ell + 1) / 2 P_ell (x) P_ell (x') = delta(x - x').
  $ <eq:legendre-polynomials-completeness-relation>
]
#proof(collapsed: true)[of the Completeness Relation][
  //
]
The significance of these two relations are best understood mathematically. Let $L^2 ([-1,1])$ denote the Hilbert space of square-integrable functions on the specified interval, for which the inner product is given by
$
  chev(f, g) = integral_(-1)^1 f(x) g(x) dx.
$
The orthogonality relation implies that the collection of Legendre polynomials forms a countable orthogonal system for $L^2 ([-1,1])$. The relation @eq:legendre-polynomials-completeness-relation also assumes the following form, dependent on the filtering property:
$
  f(x) &= integral_(-1)^1 f(x') delta(x - x') dx' = integral_(-1)^1 f(x') sum_(ell = 0)^oo (2 ell + 1) / 2 P_ell (x) P_ell (x') dx' \
  &= sum_(ell = 0)^oo (2ell + 1) / 2 P_ell (x) integral_(-1)^1 f(x') P_ell (x') dx' = sum_(ell = 0)^oo (2ell + 1) / 2 P_ell (x) chev(f, P_ell).
$
(Qualitatively, each $L^2 ([-1,1])$ function is the countably infinite linear combination of Legendre polynomials.) Thus the set of Legendre polynomials forms a countable basis of $L^2 ([-1,1])$ (and consequently proves the separability of $L^2 ([-1,1])$).

(For further background on this Hilbert-space viewpoint, see #link("https://slipperking.github.io/complex-analysis/hilbert-spaces-of-holomorphic-functions/")[Chapter 10, _Hilbert Spaces of Holomorphic Functions_,] and in particular #link("https://slipperking.github.io/complex-analysis/hilbert-spaces-of-holomorphic-functions/orthonormal-systems-of-a-hilbert-space/")[§10.2, _Orthonormal Systems of a Hilbert Space_,] of @slipperking2025complexanalysis.)
