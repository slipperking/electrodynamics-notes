#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Legendre Polynomials"),
  children: include "spherical-harmonics/index.typ",
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
be denoted a _Legendre polynomial_.

The proceeding majority of this section will be dedicated to the development of the mathematical theory required to formulate certain results. We will make use of certain mathematically analytic results that are not of great pertinence to the general comprehension of this text. The most important mathematical results are summarized in @thm:rodrigues-formula, @thm:legendre-polynomials-orthogonality-relation, and @thm:legendre-polynomials-completeness-relation.

We shall substantiate the polynomiality of each $P_ell$ at present. Write
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
with polynomial base cases $P_0 (x) = 1$ and $P_1 (x) = x$, we aver from recursion that each $P_ell$ is a polynomial. Thus we have, in its original form, relevant to the present practical application,

$
  1 / norm(va(s) - va(s)') = 1 / s sum_(ell = 0)^oo P_ell (va(s) dot va(s)') (s' / s)^ell, s' < s.
$ <eq:inverse-separation-legendre-polynomial>

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
  Gamma = {(1 - sqrt(1 - 2 x t + t^2) ) / t : t in gamma},
$
giving
$
  P_ell (x) & = 1 / (2 uppi ii) integral.cont_Gamma (2(1 - t z)) / (z^2 - 1) dz / (((2(z - x)) / (z^2 - 1))^(ell + 1) (1 - t z)) = 1 / (2 uppi ii) integral.cont_Gamma ((z^2 - 1)^ell) / (2^ell (z - x)^(ell + 1)) dz \
  & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell op("Ind")_Gamma x #tag[(Cauchy--Goursat formula)] \
  & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell 1 / (2 uppi ii) integral.cont_Gamma dz / (z - x) \
  &= 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell 1 / (2 uppi ii) integral.cont_gamma dt / t(1- t z).
$
Expressing $F$ in lieu of $1 - t z$,
$
  P_ell (x) & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell 1 / (2 uppi ii) sum_(ell' = 0)^oo P_ell' (x) integral.cont_gamma t^(ell' - 1) dt \
  &= 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell 1 / (2 uppi ii) integral.cont_gamma t^(- 1) dt,
$
giving
#theorem[Rodrigues' Formula][
  $ P_ell (x) & = 1 / (2^ell ell!) dv(, x, ell) (x^2 - 1)^ell. $
] <thm:rodrigues-formula>
This consequently gives rise to
#theorem[The Orthogonality Relation][
  $
    integral_(-1)^1 P_ell (x) P_(ell') (x) dx = 2 / (2 ell + 1) delta_(ell ell').
  $
] <thm:legendre-polynomials-orthogonality-relation>
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
The significance of this relation is most readily understood mathematically. Let $L^2 ([-1,1])$ denote the Hilbert space of real square-integrable functions on the specified interval, for which the inner product is given by
$
  chev(f, g) = integral_(-1)^1 f(x) g(x) dx.
$
The orthogonality relation implies that the collection of Legendre polynomials forms a countable orthogonal system for $L^2 ([-1,1])$.

#lemma[
  Let $q_0, q_1, dots, q_n$ be polynomials such that $deg q_k = k$ for every $0 <= k <= n$. Then
  $
    span {q_0, q_1, dots, q_n} = span {1, x, dots, x^n}.
  $
] <lem:polynomials-successive-degrees-span>
#proof(collapsed: true)[of @lem:polynomials-successive-degrees-span][
  Each $q_k$ has degree at most $n$, so the left-hand span is contained in the right-hand span. Since $q_0$ is a nonzero constant, $1 in span{q_0}$. For $k >= 1$, write $q_k = a_k x^k + r_k (x)$, where $a_k != 0$ and $deg r_k < k$ if $r_k != 0$. If $1, x, dots, x^(k-1)$ belong to $span{q_0, dots, q_(k-1)}$, then so does $r_k$, and $x^k = (q_k - r_k) / a_k$ belongs to $span{q_0, dots, q_k}$. Induction thus gives the desired assertion.
]

Of relevancy is also the following distributional identity:
#theorem[The Completeness Relation][
  $
    sum_(ell = 0)^oo (2ell + 1) / 2 P_ell (x) P_ell (x') = delta(x - x')
  $ <eq:legendre-polynomials-completeness-relation>
  distributionally (it does not converge pointwise).
] <thm:legendre-polynomials-completeness-relation>
The relation @eq:legendre-polynomials-completeness-relation also assumes the following form, dependent on the filtering property (which is, in effect, the methodology of its distributional form):
$
  f(x) &= integral_(-1)^1 f(x') delta(x - x') dx' = integral_(-1)^1 f(x') sum_(ell = 0)^oo (2 ell + 1) / 2 P_ell (x) P_ell (x') dx' \
  &= sum_(ell = 0)^oo (2ell + 1) / 2 P_ell (x) integral_(-1)^1 f(x') P_ell (x') dx' = sum_(ell = 0)^oo (2ell + 1) / 2 P_ell (x) chev(f, P_ell).
$
#proof(collapsed: true)[of the Completeness Relation][
  By @thm:rodrigues-formula, $P_ell$ has degree $ell$. Hence @lem:polynomials-successive-degrees-span gives
  $
    span{P_0, dots, P_n} = span{1, x, dots, x^n}.
  $
  Thus, any polynomial $p$ of degree $n$ is a finite linear combination $sum_(ell = 0)^n c_ell P_ell (x)$, whereby the orthogonality of ${P_ell}$ performs the filtering action characterized by
  $
    chev(p, P_ell) = sum_(ell' = 0)^n c_ell' chev(P_ell', P_ell) = c_ell chev(P_ell, P_ell) = (2 c_ell) / (2 ell + 1)
  $ <eq:legendre-polynomials-completeness-relation-filtering>
  whensoever $ell <= n$. By Bessel's Inequality,
  $
    norm(sum_(ell = 0)^n (2ell + 1 ) /2 P_ell (x) chev(g, P_ell))^2 = sum_(ell = 0)^n (2ell + 1 ) /2 chev(g, P_ell)^2 <= norm(g)^2.
  $ <eq:legendre-polynomials-completeness-relation-bessel>
  Since polynomials are dense in $C([-1,1])$ by the Stone--Weierstrass theorem and $C([-1,1])$ is dense in $L^2 ([-1,1])$, for any $epsilon > 0$, $L^2$ function $f$, there exists a polynomial $p$ such that
  $
    norm(f - p) < epsilon.
  $
  For $n >= deg p$,
  //
  $
    norm(f - sum_(ell = 0)^n (2ell + 1 ) /2 P_ell (x) chev(f, P_ell)) &<= norm(f - p) + norm(p - sum_(ell = 0)^n (2ell + 1 ) /2 P_ell (x) chev(p, P_ell)) \
    & quad""+ norm(sum_(ell = 0)^n (2ell + 1 ) /2 P_ell (x) chev(p - f, P_ell)) \
    &< epsilon + norm(p - f) < 2 epsilon
  $
  by applications of @eq:legendre-polynomials-completeness-relation-filtering and @eq:legendre-polynomials-completeness-relation-bessel.

  Since $epsilon$ was arbitrary,
  $
    f(x) = sum_(ell = 0)^oo (2ell + 1 ) /2 P_ell (x) chev(f, P_ell) = integral_(-1)^1 f(x') [sum_(ell = 0)^oo (2 ell + 1) / 2 P_ell (x) P_ell (x')] dx',
  $
  wherein the satisfaction of the filtering property by the bracketed factor yields the desired assertion.
]
(Qualitatively, each $L^2 ([-1,1])$ function is the countably infinite linear combination of Legendre polynomials.) Thus the set of Legendre polynomials forms a complete countable orthogonal system of $L^2 ([-1,1])$ (and consequently proves the separability of $L^2 ([-1,1])$).

(For further background on this Hilbert-space viewpoint, see #link("https://slipperking.github.io/complex-analysis/hilbert-spaces-of-holomorphic-functions/")[Chapter 10, _Hilbert Spaces of Holomorphic Functions_,] and in particular #link("https://slipperking.github.io/complex-analysis/hilbert-spaces-of-holomorphic-functions/orthonormal-systems-of-a-hilbert-space/")[§10.2, _Orthonormal Systems of a Hilbert Space_,] of @slipperking2025complexanalysis.)
