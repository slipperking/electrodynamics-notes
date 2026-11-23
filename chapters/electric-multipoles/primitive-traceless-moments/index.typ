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
It is our present intention to generalize this "traceless" expression from arbitrarily chosen primitive moments. In particular, we make use of @eq:inverse-distance-legendre-polynomial to write (where $rho(va(r)')$ is supported in $s' > s$)
$
  phi(va(r)) & = 1 / (4 uppi epsilon_0) integral.triple rho(va(r)') / xi dif^3 r' \
  // & = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo 1 / s^(ell + 1) integral.triple rho(va(r)') P_ell ((s_i s'_i) / (s s')) s'^ell dif^3 r'
$
