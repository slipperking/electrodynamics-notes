#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Dipole Potential Energy"),
)
#let pf = $phi_"ext"$
By @sec:work-and-energy, we may be determine the electrostatic potential energy on a neutral charge distribution $rho$ due to a slowly varying electric field $-grad pf$ to be
$
  U_E (va(r)) = integral.triple rho(va(r)') pf(va(r)') dif^3 r' & = integral.triple rho(va(r)') [pf(va(r)) + (va(r)' - va(r)) dot grad pf(va(r)) + Order(s^2)] dif^3 r' \
  & = integral.triple rho(va(r)') [pf(va(r)) + (va(r)' - va(r)) dot grad pf(va(r))] dif^3 r' + Order(s^2) \
  & = integral.triple rho(va(r)') [pf(va(r)) - va(r) dot grad pf(va(r))] dif^3 r' \
  & quad "" + integral.triple rho(va(r)') va(r)' dot grad pf(va(r)) dif^3 r' + Order(s^2) \
  & = - va(p)(va(r)) dot va(E)_"ext" (va(r)) (+ Order(s^2)).
$
Evidently as with before a point dipole at $va(r)$ renders this exact:
$
  U_E (va(r)) &= -integral.triple va(p) dot grad delta(va(r)' - va(r)) pf(va(r)') dif^3 r' = integral.triple va(p) dot grad pf(va(r)') delta(va(r)' - va(r)) dif^3 r' \
  &= va(p) dot grad pf(va(r)) = -va(p) dot va(E)_"ext" (va(r)).
$ <eq:electric-point-dipole-interaction-energy>
The electric dipole force can be verified consistent herewith by @thm:electric-force-bodies-virtual-gradient
$
  va(F) = -grad U_E = -grad[-va(p) dot va(E)_"ext" (va(r))] = grad[va(p) dot va(E)_"ext" (va(r))].
$
because the virtual shift in $rho$ is equivalent to a shift in $va(r)$.

#todo[Torque Verif]

We now characterize the total electrostatic energy $U_("E", "tot")$ in a system of point dipoles, by method of assemblage. In greater specificity, consider $n$ point dipoles with moments $va(p)_k$ respectively at $va(r)_k$. The discussion in @sec:total-electrostatic-energy gives this quantity to be
$
  U_("E", "tot") = sum_(j = 1)^n sum_(k = 1)^(j - 1) W_(j k) = 1 / 2 sum_(j = 1)^n sum_(k = 1 \ k != j)^n W_(j k),
$
where $W_(j k)$ is the interaction energy between $va(r)_j$ and $va(r)_k$, which may be computed---by superposition---considering the electric field $va(E)_k$ to be $va(E)_"ext"$, to be the work necessitated to introduce the $j$-th dipole, wherefor @thm:electric-point-dipole-field gives
$
  va(E)_k (va(r)) = 1 / (4 uppi epsilon_0) (3 vu(s)_k (va(p)_k dot vu(s)_k) - va(p)_k) / s_k^3 #tag[$(va(s)_k = va(r) - va(r)_k)$]
$
wherein the Distributional scaffolds have been removed in assuming a positive separation distance; and whereby @eq:electric-point-dipole-interaction-energy yields
$
  W_(j k) = -va(p)_j dot va(E)_k (va(r)_j) = 1 / (4 uppi epsilon_0) (va(p)_j dot va(p)_k - 3 (va(p)_j dot vu(s)_(j k)) (va(p)_k dot vu(s)_(j k))) / s_(j k)^3, #tag[$(va(s)_(j k) = va(r)_j - va(r)_k)$]
$
whence
#theorem[
  The total electrostatic energy of a system containing $n$ point dipoles with moments $va(p)_k$ respectively at $va(r)_k$ is given by
  $
    U_("E", "tot") &= 1 / 2 sum_(j = 1)^n sum_(k = 1 \ k != j)^n W_(j k) = -1 / 2 sum_(j = 1)^n va(p)_j dot va(E)_("all but" j) (va(r)_j) \
    &= 1 / (8 uppi epsilon_0) sum_(j = 1)^n sum_(k = 1 \ k != j)^n (va(p)_j dot va(p)_k - 3 (va(p)_j dot vu(s)_(j k)) (va(p)_k dot vu(s)_(j k))) / s_(j k)^3.
  $
]
