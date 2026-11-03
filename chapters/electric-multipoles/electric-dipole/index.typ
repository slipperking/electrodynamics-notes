#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("The Electric Dipole"),
  children: {
    include "singularity-at-origin/index.typ"
    include "dipole-force-and-torque/index.typ"
    include "dipole-potential-energy/index.typ"
    include "dipole-layers/index.typ"
  },
)

Recall the electric dipole moment
#thm-state.thm-restate("def:electric-dipole-moment")
in the multipole expansion as provided in @eq:electric-multipole-expansion. It can be thought roughly related to a "center of mass" $overline(va(r))$ by $overline(va(r)) = va(p) / Q$. Fittingly, the electric dipole moment is generally nonzero for uneven charge distributions. Where $Q = 0$, we aver that the dipole moment is independent of the chosen $va(r)_0$, the verification whereof can be determined by choice of two differing origin points $va(r)_0$ and $va(r)'_0$:
#theorem[
  A given localized volume charge density distribution $rho$ whose total charge is $0$ yields the same dipole moment across all possible expansion points.
]
#proof[
  Observing that
  $
    0 = (va(r)_0 - va(r)'_0) integral.triple rho(va(r)) dif^3 r' = integral.triple rho(va(r)) (va(r)_0 - va(r)'_0) dif^3 r',
  $
  it follows that
  $
    va(p) &= integral.triple rho(va(r)) (va(r)' - va(r)_0) dif^3 r' = integral.triple rho(va(r)) (va(r)' - va(r)_0 + va(r)_0 - va(r)'_0) dif^3 r' \
    &=integral.triple rho(va(r)) (va(r)' - va(r)'_0) dif^3 r' = va(p)'. qedhere
  $
]

The corresponding dipole term in $phi$, defined to be the _electric dipole potential_, is given by
$
  phi_1(va(r)) = 1 / (4 uppi epsilon_0) (va(p) dot va(s)) / s^3.
$
From the moment we obtain the complete typification of the _electric dipole field_
$
  va(E)_1(va(r)) & = - 1 / (4 uppi epsilon_0) grad_((va(s))) (va(p) dot va(s)) / s^3 = - 1 / (4 uppi epsilon_0) [(va(p) dot grad) va(s) / s^3 + va(p) times (curl va(s) / s^3)] \
  &=- 1 / (4 uppi epsilon_0) [1 / s^3 (va(p) dot grad) va(s) + va(s) (va(p) dot grad) 1 / s^3 - va(p) times (curl grad 1 / s)] #tag[($s != 0$)]\
  &=- 1 / (4 uppi epsilon_0) [1 / s^3 (va(p) dot grad) va(s) - va(s) (va(p) dot (3 va(s)) / s^5)] = - 1 / (4 uppi epsilon_0) [1 / s^3 p_i partial_i s_j vu(e)_j - va(s) (va(p) dot (3 va(s)) / s^5)] \
  &= - 1 / (4 uppi epsilon_0) [1 / s^3 p_i delta_(i j) vu(e)_j - va(s) (va(p) dot (3 va(s)) / s^5)]= 1 / (4 uppi epsilon_0) (3 vu(s) (va(p) dot vu(s)) - va(p)) / s^3
$ <eq:electric-dipole-field>
Consider the choice of $rho$, $va(r)_0$, and the subsequent $phi$ and other variables such that the electric potential multipole expansion comprises no monopole term, in which case $Q$, the enclosed charge, is $0$. It transpires that in a multitude of practical cases, such as in atoms, water, etc., $Q = 0$, wherein the leading term is the dipole term at far ($s >> R$), whence with $s >> R$, $phi(va(r)) = phi_1 (va(r))$ (asymptotically).

Appealing in @eq:electric-dipole-field to a spherical coordinate system $(s, theta, phi_"az")$ with a polar axis $vu(p)$, denoting by $theta$ the polar angle between $vu(s)$ and $vu(p)$ and by $phi_"az"$ an angle of rotation about $va(p)$ (with a fixed reference point), it follows thence that
$
  va(E)_1 (va(r)) /* = 1 / (4 uppi epsilon_0) (3 vu(s) p cos theta - va(p)) / s^3  */= 1 / (4 uppi epsilon_0) (3 vu(s) p cos theta - p[vu(s) cos theta - vu(theta) sin theta]) / s^3 = p / (4 uppi epsilon_0 s^3) [2 vu(s) cos theta + vu(theta) sin theta],
$
is azimuthally symmetric---if $phi_"az"$ were to change by some $delta phi_"az"$, such a variation would result in a rotation of $vu(r)$ and $vu(theta)$ by $delta phi_"az"$ about the $vu(p)$-axis; whereby the previous equation entails a rotation of $va(E)$ by $delta phi_"az"$ about the axis.

The historical motivation for the naming of "dipole" comes from the following geometric construction, due to Maxwell: consider a configuration wherein two point charges $plus.minus q / d$ respectively at $va(a) plus.minus d vu(c) / 2$ are held. With $d -> 0^+$, the resulting electric potential is
$
  phi(va(r)) &= lim_(d -> 0^+) 1 / (4 uppi epsilon_0) [hfrc(q / d) / norm(va(r) - va(a) - d / 2 vu(c)) - hfrc(q / d) / norm(va(r) - va(a) + d / 2 vu(c))] \
  &= lim_(d -> 0^+) hfrc(q / d) / (4 uppi epsilon_0) (ee^(- d / 2 vu(c) dot grad) - ee^(d / 2 vu(c) dot grad)) 1 / norm(va(r) - va(a)) \
  &= -lim_(d -> 0^+) hfrc(q / d) / (4 uppi epsilon_0) 2 sinh(d / 2 vu(c) dot grad) 1 / norm(va(r) - va(a)) \
  &= -lim_(d -> 0^+) hfrc(q / d) / (4 uppi epsilon_0) [d vu(c) dot grad + d^3 / 4 Order(vu(c) dot grad)^3] 1 / norm(va(r) - va(a)) \
  &= -q / (4 uppi epsilon_0) vu(c) dot grad 1 / norm(va(r) - va(a)) = -1 / (4 uppi epsilon_0) q vu(c) dot grad 1 / norm(va(r) - va(a)) \
$
