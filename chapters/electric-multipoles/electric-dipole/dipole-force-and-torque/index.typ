#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Dipole Force and Torque"),
)
#let ef = $va(E)_"ext"$
When a neutral charge distribution is considered in the presence of an external electric field $ef$, the electric dipole moment arises of its own accord. Expressing for fixed $va(r) in supp rho$, and using the separation $va(xi) = va(r)' - va(r)$,
$
  ef(va(r)') = ee^(va(xi) dot grad) ef(va(r)) = ef(va(r)) + (va(xi) dot grad) ef(va(r)) + Order(xi^2),
$
if $ef(va(r)')$ varies sufficiently slowly throughout space insomuch as to omit consideration for the quadratic and higher order terms, then
$
  va(F)_"ext" &= integral.triple ef(va(r)') rho(va(r)') dif^3 r' = integral.triple [ef(va(r)) + ((va(r)' - va(r)) dot grad) ef(va(r))] rho(va(r)') dif^3 r' \
  &= [1 - (va(r) - va(r)_0) dot grad] ef(va(r)) integral.triple rho(va(r)') dif^3 r' + integral.triple (va(s)' dot grad) ef(va(r)) rho(va(r)') dif^3 r' \
  &= integral.triple (va(s)' dot grad) ef(va(r)) rho(va(r)') dif^3 r' = (integral.triple va(s)' rho(va(r)') dif^3 r' dot grad) ef(va(r)) \
  &= (va(p) dot grad) ef(va(r)) = p_i [partial_i E_("ext", j)] vu(e)_j = p_i [partial_j E_("ext", i)] vu(e)_j #tag[$("since" curl ef ==> partial_i E_("ext", j) = partial_j E_("ext", i))$] \
  &= vu(e)_j partial_j p_i E_("ext", i) = grad (va(p) dot ef(va(r)))
$ <eq:electric-dipole-force>
Where $va(N)$ is the torque about the pole expansion point $va(r)_0$,
$
  va(N) & = integral.triple va(s)' rho(va(r)') times [ef(va(r)) + (va(xi) dot grad) ef(va(r))] dif^3 r' \
  & = integral.triple va(s)' rho(va(r)') dif^3 r' times ef(va(r)) + integral.triple rho(va(r)') (va(s) + va(xi)) times (va(xi) dot grad) ef(va(r)) dif^3 r' \
  &= va(p) times ef + va(s) times (integral.triple rho(va(r)') va(xi) dif^3 r' dot grad) ef(va(r)) + integral.triple rho(va(r)') va(xi) times (va(xi) dot grad) ef(va(r)) dif^3 r'
$
wherein the last integral is $Order(xi^2)$ and thus:
$
  &= va(p) times ef + va(s) times [(integral.triple rho(va(r)') va(s)' dif^3 r' - va(s) integral.triple rho(va(r)') dif^3 r') dot grad] ef(va(r)) + Order(xi^2) \
  &= va(p) times ef + va(s) times (va(p) dot grad) ef(va(r)) + Order(xi^2) \
  &= va(p) times ef + va(s) times va(F)_"ext" + Order(xi^2).
$ <eq:electric-dipole-torque>
The relation
$
  va(N) = va(p) times ef + va(s) times va(F)_"ext"
$
is exact when $rho$ is the point dipole charge density distribution at $va(r)$. Indeed, by the distributional gradient (integration by parts),
$
  va(N) &= -integral.triple va(s)' times va(E)_"ext" (va(r)') va(p) dot gradp delta(va(xi)) dif^3 r' = integral.triple delta(va(xi)) (va(p) dot gradp) [va(s)' times va(E)_"ext" (va(r)')] dif^3 r' \
  &= (va(p) dot grad) [va(s) times va(E)_"ext" (va(r))] = p_i partial_i [epsilon_(j k l) vu(e)_j s_k E_("ext", l)] = p_i epsilon_(j k l) vu(e)_j partial_i [s_k E_("ext", l) ] \
  &= p_i epsilon_(j k l) vu(e)_j (E_("ext", l) partial_i s_k + s_k partial_i E_("ext", l)) \
  &= p_i epsilon_(j k l) vu(e)_j (E_("ext", l) delta_(i k) + s_k partial_i E_("ext", l)) \
  &= epsilon_(j k l) vu(e)_j p_k E_("ext",l) + epsilon_(j k l) vu(e)_j s_k (va(p) dot grad) E_("ext",l) \
  &= va(p) times ef + va(s) times (va(p) dot grad) ef \
  &=va(p) times ef + va(s) times va(F)_"ext".
$
