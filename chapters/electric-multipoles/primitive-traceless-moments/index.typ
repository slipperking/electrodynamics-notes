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
  vaa(Q) : grad^(times.o 2) = vaa(Theta) : (va(s)^(times.o 2)) / s^5.
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
$
// For some fixed $j$,
// $
//   partial'_i_j [rho(va(r)') s'^(2 ell + 1)] &= partial'_i_j rho(va(r)') s'^(2 ell + 1) + rho(va(r)') partial'_i_j sqrt(s'^2_i_k)^(2 ell + 1) \
//   & = rho_(i_j) rho(va(r)') s'^(2 ell + 1) + rho(va(r)') (2 ell + 1) s'^(2 ell) (2 s'_i_j)
// $
