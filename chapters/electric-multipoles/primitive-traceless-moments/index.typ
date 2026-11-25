#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Primitive and Traceless Multipole Moments"),
  label: "primitive-traceless-moments",
)
Recall the expression given in @eq:electric-multipole-expansion, which we reproduce below:
$
  phi(va(r)) = sum_(ell = 0)^oo vb(C)^((ell)) limits(dot)^ell [(-1)^ell grad^(times.o ell) 1 / s] = sum_(ell = 0)^oo (-1)^ell C_(i_1 dots.c i_ell) partial_i_1 dots.c partial_i_ell 1 / s,
$
wherein each term contains a $ell$-fold tensor contraction with a primitive Cartesian moment. In @sec:traceless-quadrupole-tensor (more specifically @eq:traceless-quadrupole-tensor-potential), we obtained the alternate representation
$
  vaa(Q) : grad^(times.o 2) 1 / s = vaa(Theta) : (va(s)^(times.o 2)) / s^5.
$
It is our present intention to generalize this "traceless" expression from arbitrarily chosen primitive moments. In particular, we make use of @eq:inverse-distance-legendre-polynomial to write (where $rho(va(r)')$ is supported in $s' < s$)
$
  phi(va(r)) & = 1 / (4 uppi epsilon_0) integral.triple rho(va(r)') / xi dif^3 r' = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo 1 / s^(ell + 1) integral.triple rho(va(r)') P_ell (vu(s) dot vu(s)') s'^ell dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo 1 / s^(ell + 1) integral.triple rho(va(r)') [1 / ell! evaluated(pdv(, t, [ell]) 1 / norm(vu(s)' - t vu(s)))_(t = 0)] s'^ell dif^3 r' #tag[(see @sec:legendre-polynomials)] \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo 1 / s^(ell + 1) integral.triple rho(va(r)') [evaluated(1 / ell! (-vu(s) dot grad'')^ell 1 / s'')_(va(s)'' = vu(s)')] s'^ell dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (-1)^ell / ell! 1 / s^(ell + 1) integral.triple rho(va(r)') evaluated((hat(s)_i partial''_i)^ell 1 / s'')_(va(s)'' = vu(s)') s'^ell dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (-1)^ell / ell! 1 / s^(ell + 1) integral.triple rho(va(r)') evaluated(hat(s)_i_1 dots.c hat(s)_i_ell partial''_i_1 dots.c partial''_i_ell 1 / s'')_(va(s)'' = vu(s)') s'^ell dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (-1)^ell / ell! 1 / s^(ell + 1) integral.triple rho(va(r)') evaluated(hat(s)_i_1 dots.c hat(s)_i_ell (pdv(s'''_j_1, s''_i_1) partial'''_j_1) dots.c (pdv(s'''_j_ell, s''_i_ell) partial'''_j_ell) s' / s''')_(va(s)'' = vu(s)') s'^ell dif^3 r' #tag[$(va(s)''' = s' va(s)'')$]\
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (-1)^ell / ell! 1 / s^(ell + 1) integral.triple rho(va(r)') evaluated(hat(s)_i_1 dots.c hat(s)_i_ell (s' delta_(i_1 j_1) partial'''_j_1) dots.c (s' delta_(i_ell j_ell) partial'''_j_ell) s' / s''')_(va(s)''' = va(s)') s'^ell dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (-1)^ell / ell! 1 / s^(ell + 1) integral.triple rho(va(r)') evaluated(hat(s)_i_1 dots.c hat(s)_i_ell s'^ell partial'''_i_1 dots.c partial'''_i_ell s' / s''')_(va(s)''' = va(s)') s'^ell dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (-1)^ell / ell! 1 / s^(2 ell + 1) integral.triple rho(va(r)') s'^(2 ell + 1) [s_i_1 dots.c s_i_ell] [partial'_i_1 dots.c partial'_i_ell] 1 / s' dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (-1)^ell / ell! va(s)^(times.o ell) / s^(2 ell + 1) limits(dot)^ell integral.triple rho(va(r)') s'^(2 ell + 1) grad'^(times.o ell) 1 / s' dif^3 r'.
$
Thus writing
#definition[Traceless Cartesian Electric Multipole Moment][
  $
    vb(T)^((ell)) = (-1)^ell / ell! integral.triple rho(va(r)') s'^(2 ell + 1) grad'^(times.o ell) 1 / s' dif^3 r',
  $
]
one obtains
#theorem[Traceless Cartesian Electric Multipole Expansion][
  $
    phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo va(s)^(times.o ell) / s^(2 ell + 1) limits(dot)^ell vb(T)^((ell)).
  $
]
The tracelessness of $vb(T)^((ell))$ ($ell >= 2$) is provided in the sense that for any two indices $i_n, i_m$ of the $ell$ indices $i_1, dots, i_ell$,
$
  delta_(i_n i_m) T^((ell))_(i_1 dots.c i_ell) &= (-1)^ell / ell! integral.triple rho(va(r)') s'^(2 ell + 1) [product_(k != m,n) partial'_i_k] [delta_(i_n i_m) partial'_i_n partial'_i_m 1 / s'] dif^3 r' \
  &= (-1)^ell / ell! integral.triple rho(va(r)') s'^(2 ell + 1) [product_(k != m,n) partial'_i_k] [laplacianp 1 / s'] dif^3 r' \
  &= -4 uppi (-1)^ell / ell! integral.triple rho(va(r)') s'^(2 ell + 1) [product_(k != m,n) partial'_i_k] delta(va(s)') dif^3 r'.
$
By the distributional derivative $integral f partial delta = -integral delta partial f$, it follows that
$
  delta_(i_n i_m) T^((ell))_(i_1 dots.c i_ell) &= -(4 uppi) / ell! integral.triple delta(va(s)') [product_(k != m,n) partial'_i_k] [rho(va(r)') s'^(2 ell + 1)] dif^3 r' \
  & = -(4 uppi) / ell! evaluated([product_(k != m,n) partial'_i_k] [rho(va(r)') s'^(2 ell + 1)])_(va(r)_0).
$ <eq:traceless-electric-multipole-moment-tracelessness>
(Herewith to facilitate our discussion it will become rather imperative the introduction of relevant terminology.)
#definition[
  A function $f(va(r))$ is said to be _homogeneous of degree $d in NN$_ iff for any $lambda >= 0$,
  $
    f(lambda va(r)) = lambda^d f(va(r)).
  $
]
(One of the defining properties of linearity is homogeneity of degree $1$.)

Of the various properties of homogeneous functions, we note that the derivative of $f(lambda va(r))$, along any such component of $va(r)$, such as $r_k$, may be computed by the chain rule to be
$
  partial_k [f(lambda va(r))] = (grad f)(lambda va(r)) dot partial_k (lambda va(r)) = (grad f)(lambda va(r)) dot lambda vu(e)_k = lambda (partial_k f)(lambda va(r)),
$
and by the homogeneity of $f$ to be
$
  partial_k [f(lambda va(r))] = partial_k [lambda^d f(va(r))] = lambda^d (partial_k f) (va(r)),
$
whence we have
#lemma[
  Where $f(va(r))$ is homogeneous with degree $d$,
  $
    (partial_k f) (lambda va(r)) = lambda^(d - 1) (partial_k f)(va(r))
  $
  is homogeneous with degree $d - 1$.
] <lem:derivative-of-homogeneous-function-is-homogeneous>
In contending with iterated derivatives of unspecified arbitrary indices, it becomes of often utility to use
#definition[Multi-Index][
  A $3$-tuple $alpha = (alpha_1, alpha_2, alpha_3)$ of nonnegative integers, known as a _multi-index_, is defined with the following notations:
  $
    abs(alpha) = alpha_1 + alpha_2 + alpha_3, quad partial_alpha = partial_i^alpha_i = (partial^abs(alpha)) / (partial r_1^(alpha_1) partial r_2^(alpha_2) partial r_3^(alpha_3)).
  $
]
The multi-indices define a partial ordering through total component comparison. The additive and subtractive operations are also defined component-wise. Thus we obtain
#lemma[
  Where $f$ is homogeneous with degree $d$, for a multi-index $alpha:abs(alpha) <= d$, $partial_alpha f$ is homogeneous with degree $d - abs(alpha)$.
] <lem:multi-index-homogeneous-function-derivative-degree-decrement>
Moreover, we have the following generalization of the product rule:
#lemma[
  Where $f,g$ are two functions in $RR^3$ and $alpha$ is a multi-index,
  $
    partial_alpha (f g) = sum_(k <= alpha) binom(alpha, k) (partial_k f) (partial_(alpha - k) g) = sum_(k <= alpha) binom(alpha_1, k_1) binom(alpha_2, k_2) binom(alpha_3, k_3) (partial_k f) (partial_(alpha - k) g),
  $
] <lem:multi-index-generalized-leibniz-rule>
which may be obtained by performing induction whilst incrementing the value of $abs(alpha)$.

The specified indices $i_1,i_2,dots,i_ell$ (without $m,n$) in @eq:traceless-electric-multipole-moment-tracelessness construct the multi-index corresponding to
$
  alpha = (sum_(k != m,n) delta_(i_k 1), sum_(k != m,n) delta_(i_k 2), sum_(k != m,n) delta_(i_k 3)), quad (abs(alpha) = ell - 2).
$
Thus, one may find (in continuation of @eq:traceless-electric-multipole-moment-tracelessness) that (where homogeneity is with respect to $va(s)$)
$
  tr_(i_m i_n) vb(T)^((ell)) & = -(4 uppi) / ell! evaluated(partial'_alpha [rho(va(r)') s'^(2 ell + 1)])_(va(r)_0) \
  & = -(4 uppi) / ell! sum_(k <= alpha) binom(alpha, k) (partial'_k rho)(va(r)_0) [#[hom. func. of deg. $2 ell + 1 - abs(alpha - k) >= ell + 3$]](va(s) = 0) = 0.
$
