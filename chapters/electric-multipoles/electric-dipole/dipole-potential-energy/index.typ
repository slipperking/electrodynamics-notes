#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Dipole Potential Energy"),
)
#let pf = $phi_"ext"$
By @sec:work-and-energy, we may be determine the electrostatic potential energy on a neutral charge distribution $rho$ due to a slowly varying electric field $-grad pf$ to be
$
  U_E (va(r)) = integral.triple rho(va(r)') pf(va(r)') dif^3 r' & = integral.triple rho(va(r)') [pf(va(r)) + va(xi) dot grad pf(va(r)) + Order(xi^2)] dif^3 r' \
  & = integral.triple rho(va(r)') [pf(va(r)) + (va(s)' - va(s)) dot grad pf(va(r))] dif^3 r' + Order(xi^2) \
  & = integral.triple rho(va(r)') [pf(va(r)) - va(s) dot grad pf(va(r))] dif^3 r' \
  & quad "" + integral.triple rho(va(r)') va(s)' dot grad pf(va(r)) dif^3 r' + Order(xi^2) \
  & = - va(p) dot va(E)_"ext" (va(r)) + Order(xi^2).
$
Evidently as with previously a point dipole at $va(r)$ renders this exact:
$
  U_E (va(r)) &= -integral.triple va(p) dot grad delta(va(r)' - va(r)) pf(va(r)') dif^3 r' = integral.triple va(p) dot grad pf(va(r)') delta(va(r)' - va(r)) dif^3 r' \
  &= va(p) dot grad pf(va(r)) = -va(p) dot va(E)_"ext" (va(r)).
$ <eq:electric-point-dipole-interaction-energy>
The electric dipole force can be verified consistent herewith by @thm:electric-force-bodies-virtual-gradient
$
  va(F) = -grad U_E = -grad[-va(p) dot va(E)_"ext" (va(r))] = grad[va(p) dot va(E)_"ext" (va(r))].
$
because the virtual shift in $rho$ is equivalent to a shift in $va(r)$.

For particles at $va(r) = va(r)_0 + va(s)$ and $va(r)' = va(r)_0 + va(s)'$ rotating rigidly, we have mechanically
$
  dv(va(r), t) = dv(va(r)_0, t) + va(omega) times va(s), wide wide dv(va(r)', t) = dv(va(r)_0, t) + va(omega) times va(s)',
$
and moreover if we virtually apply a rotation fixing $va(r)_0$,
$
  delta va(r) = delta va(s) = delta va(theta) times va(s), wide wide delta va(r)' = delta va(s)' = delta va(theta) times va(s)'
$
Hence we have in analogy for a charge distribution virtually rotating about $va(r)_0$,
$
  delta va(p) = delta va(theta) times va(p),
$
whence such a rotation entails the following displacement in potential energy:
$
  delta U_E & = -delta(va(p) dot va(E)_"ext" (va(r))) = - delta va(p) dot va(E)_"ext" - va(p) dot delta va(E)_"ext" = - (delta va(theta) times va(p)) dot va(E)_"ext" - va(p) dot (delta va(r) dot grad) va(E)_"ext" (va(r)) \
  // todo, N should be torque about r0
  & = - delta va(theta) dot (va(p) times va(E)_"ext") - va(p) dot ((delta va(theta) times va(s)) dot grad) va(E)_"ext" (va(r)),
$
whereof closer examination of the second term gives
$
  va(p) dot ((delta va(theta) times va(s)) dot grad) va(E)_"ext" (va(r)) &= p_j (delta va(theta) times va(s))_i partial_i E_("ext", j) = p_j (epsilon_(i k l) delta theta_k s_l) partial_j E_("ext", i) \
  &= delta theta_k [epsilon_(k l i) s_l (p_j partial_j E_("ext", i))] = delta theta_k [epsilon_(k l i) s_l (va(p) dot grad va(E)_"ext")_i] \
  & = delta va(theta) dot [va(s) times (va(p) dot grad) va(E)_"ext"] = delta va(theta) dot [va(s) times va(F)_"ext"],
$
whence
$
  delta U_E = - delta va(theta) dot [va(p) times va(E)_"ext" + va(s) times va(F)_"ext"]= - delta va(theta) dot va(N)
$
wherein $va(N)$ is defined as in @sec:dipole-force-and-torque.

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
