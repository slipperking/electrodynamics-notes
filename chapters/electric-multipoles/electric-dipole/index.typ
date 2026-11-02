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
in the multipole expansion as provided in @eq:electric-multipole-expansion. It can be @todo (analogy to centers of mass)

The corresponding dipole term in $phi$, defined to be the _electric dipole potential_, is given by
$
  phi_2(va(r)) = 1 / (4 uppi epsilon_0) (va(p) dot va(s)) / s^3.
$
Consider the choice of $rho$, $va(r)_0$, and the subsequent $phi$ and other variables such that the electric potential multipole expansion consists only of the dipole potential, in which case $Q$, the monopole term and equivalently the enclosed charge, is $0$.
