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
  1 / norm(va(s) - va(s)') = 1 / s 1 / sqrt(1 - 2 x t + t^2) = 1 / s sum_(ell = 0)^oo evaluated(dv(, t, ell) 1 / sqrt(1 - 2 x t + t^2))_(t = 0) t^ell / ell!.
$
wherein the function is singular for $t = x plus.minus ii sqrt(1 - x^2)$, notably occurring only when $abs(t) = 1$. Therefore, the previous representation is convergent for $abs(t) < 1$, whose veracity originates from $s' < R < s$. Let
#definition[Legendre Polynomial][
  $
    P_ell (x) = 1 / ell! evaluated(dv(, t, ell) 1 / sqrt(1 - 2 x t + t^2))_(t = 0) #tag[$(ell in NN)$]
  $
]
be denoted a _Legendre polynomial_, the polynomiality whereof we shall now substantiate. Write
$
  F(x, t) = 1 / sqrt(1 - 2 x t + t^2) = sum_(ell = 0)^oo evaluated(dv(, t, ell) 1 / sqrt(1 - 2 x t + t^2))_(t = 0) t^ell / ell! = sum_(ell = 0)^oo P_ell (x) t^ell,\
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
