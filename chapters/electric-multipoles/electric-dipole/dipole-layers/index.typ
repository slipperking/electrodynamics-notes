#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Dipole Layers"),
)
We shall now consider the case pertaining to particles trapped in the surface boundary between water and air mediums. Consider a situation in which the surface of a dish of water meets the air in a flat plane, whereupon neutrally charged phospholipid molecules are introduced, the properties whereof comprise notably the neutrality of charge and an uneven charge distribution. The molecules orient themselves in a way such that the polar heads anchor themselves into the water with hydrophobic tails oriented vertically upward.

Microscopically, each of these suspended molecules occupying a surface area of $S$ can be characterized with a dipole moment $va(p)$, whence a crude representation of the molecule can be given by a dipole of two charges $+q, -q$ separated by a displacement $va(b)$ reproducing the same moment $va(p) = q va(b)$. Therefore, over a surface of such contiguously arranged molecules, we introduce the description of a _electric dipole moment per unit area_
$
  va(tau) = va(p) / S = sigma va(b).
$
Our representation makes no attempt to individually model the charge or density of these molecules. Rather, in macroscopic consideration, letting $b -> 0$ fixing $va(p)$ (and consequently $sigma -> oo$) gives the construction of an _electric dipole layer_. Its approximation will prove to be of utility in many physical scenarios wherein charges exist near boundary surfaces.

The most general case of an electric dipole layer will consider an arbitrary surface $S$ and a surface dipole density $va(tau)(va(r)) = dv(va(p), S)$ which is not necessarily uniform in strength nor perpendicular to the surface in its directionality. @eq:electric-point-dipole-potential gives the electric potential to be
$
  phi(va(r)) = -1 / (4 uppi epsilon_0) integral dif va(p)' dot grad 1 / xi = 1 / (4 uppi epsilon_0) integral.double_S va(tau)(va(r)') dot grad' 1 / xi dif S'
$
We wish to rewrite the potential as a volume integral. Similar to the way in which @sec:electric-charges expresses a surface distribution $sigma$ and a line distribution $lambda$ as a volume density distribution, there exists a suitable generalization
$
  delta_S (va(r)) = integral.double_S delta^3 (va(r) - va(r)') dif S'
$
Defining
$
  va(r)'_S = argmin_(va(r)'' in S) norm(va(r)' - va(r)''), wide (va(r)_S = argmin_(va(r)'' in S) norm(va(r) - va(r)''))
$
the previous relation is simply
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) integral.triple delta_S (va(r)') va(tau) (va(r)'_S) dot gradp 1 / xi dif^3 r'.
$
The choice of $argmin$ is not of great importance; our goal is to extend $va(tau)$ to be defined outside the surface, although $delta_S$ picks only points in $S$. For simplicity we shall simply write $va(r)_S$ to imply the given meaning.

We then have
$
  phi(va(r)) &= 1 / (4 uppi epsilon_0) integral.triple [divp [1 / xi delta_S (va(r)') va(tau) (va(r)'_S)] - (divp [delta_S (va(r)') va(tau) (va(r)'_S)]) / xi] dif^3 r' \
  &= 1 / (4 uppi epsilon_0) integral.triple (-divp [delta_S (va(r)') va(tau) (va(r)'_S)]) / xi dif^3 r',
$
which is the precise result we would have obtained by setting
#theorem[Volume Charge Distribution of an Electric Dipole Layer][
  $
    rho(va(r)) = -div [delta_S (va(r)) va(tau) (va(r)_S)].
  $
]
Observe that
$
  delta_S (va(r)) va(tau) (va(r)_S) = integral.double_S delta^3 (va(r) - va(r)') va(tau) (va(r)_S) dif S' = integral.double_S va(tau) (va(r)') delta^3(va(r) - va(r)') dif S',
$
giving
$
  rho(va(r)) = -integral.double_S va(tau) (va(r)') dot grad delta^3 (va(r) - va(r)') dif S'.
$
Denote by $vu(n) = vu(n)_(va(r)')$ the unit surface normal and decompose
$
  va(tau) &= va(tau)_parallel + va(tau)_perp, wide "where" quad va(tau)_perp = vu(n) (vu(n) dot va(tau)) = vu(n) tau_perp, quad va(tau)_parallel = va(tau) - va(tau)_perp = (vaa(I) - vu(n)^(times.o 2)) dot va(tau), \
  grad &= grad_parallel + grad_perp, wide "where" quad grad_perp = vu(n)(vu(n) dot grad), quad grad_parallel = (vaa(I) - vu(n)^(times.o 2)) dot grad,
$
(wherein we define $tau_perp$ to be signed to be dependent on the direction of $vu(n)$) whence
$
  rho(va(r)) = -integral.double_S va(tau)_parallel (va(r)') dot grad delta^3 (va(r) - va(r)') dif S' - integral.double_S va(tau)_perp (va(r)') dot grad delta^3 (va(r) - va(r)') dif S'.
$ <eq:electric-dipole-layer-auxiliary-1>
As generalized functions of $xi$, $grad = -gradp$ entails that
$
  -integral.double_S &va(tau)_parallel (va(r)') dot grad delta^3(va(r) - va(r)') dif S' = integral.double_S va(tau)_parallel (va(r)') dot gradp_parallel delta^3(va(r) - va(r)') dif S' \
  &= integral.double_S [divpsu(parallel) [va(tau)_parallel (va(r)') delta^3(va(r) - va(r)')] - [divpsu(parallel) va(tau)_parallel (va(r)')] delta^3(va(r) - va(r)')] dif S'
$ <eq:electric-dipole-layer-auxiliary-2>
//
Denote by $vu(m) = vu(m)_(va(r)') = (dif va(ell)') / (dif ell') times vu(n)$ at $va(r)' in partial S$ the outward unit conormal tangent to $S$ and normal to $partial S$. Then
$
  integral.double_S divpsu(parallel) [va(tau)_parallel (va(r)') delta^3(va(r) - va(r)')] dif S' = integral.cont_(partial S) delta^3 (va(r) - va(r)') va(tau)_parallel (va(r)') dot vu(m)_(va(r)') dif ell'
$
Where
$
  delta_(partial S)(va(r)) = integral.cont_(partial S) delta^3(va(r) - va(r)') dif ell', wide va(r)_(partial S) = argmin_(va(r)'' in partial S) norm(va(r) - va(r)''), \
  lambda(va(r)_(partial S)) = va(tau)_parallel (va(r)_(partial S)) dot vu(m)_(va(r)_(partial S)) = va(tau) (va(r)_(partial S)) dot vu(m)_(va(r)_(partial S)),
$ <eq:electric-dipole-layer-effective-line-charge-density>
the first term of @eq:electric-dipole-layer-auxiliary-2 assumes the form (distributionally)
$
  integral.double_S divpsu(parallel) [va(tau)_parallel (va(r)') delta^3 (va(r) - va(r)')] dif S' = lambda(va(r)_(partial S)) delta_(partial S)(va(r)). /* #tag[(distributionally)] */
$
The second term of @eq:electric-dipole-layer-auxiliary-2 is similarly (up to a sign)
$
  integral.double_S [divpsu(parallel) va(tau)_parallel (va(r)')] delta^3(va(r) - va(r)') dif S' = [divsu(parallel) va(tau)_parallel (va(r)_S)] delta_S (va(r)).
$
In consideration of @eq:electric-dipole-layer-auxiliary-1, observe that
$
  delta_S (va(r)) va(tau)_perp (va(r)_S) = integral.double_S va(tau)_perp (va(r)') delta^3 (va(r) - va(r)') dif S',
$
$
  div[delta_S (va(r)) va(tau)_perp (va(r)_S)] &= va(tau)_perp (va(r)_S) dot grad delta_S (va(r)) + [div va(tau)_perp (va(r)_S)] delta_S (va(r)) \
  &= div integral.double_S va(tau)_perp (va(r)') delta^3 (va(r) - va(r)') dif S' = integral.double_S va(tau)_perp (va(r)') dot grad delta^3 (va(r) - va(r)') dif S'.
$
As $va(r)_S$ remains invariant under sufficiently small displacements along $vu(n)_va(r)_S$, we aver that $divsu(perp) va(tau)_perp = 0$, whence it follows that $div va(tau)_perp = divsu(parallel) va(tau)_perp$. Thus,
$
  va(tau)_perp (va(r)_S) dot grad delta_S (va(r)) + [div va(tau)_perp (va(r)_S)] delta_S (va(r)) &= tau_perp (va(r)_S) vu(n)_va(r)_S dot grad delta_S (va(r)) + [divsu(parallel) va(tau)_perp (va(r)_S)] delta_S (va(r)) \
  &=integral.double_S va(tau)_perp (va(r)') dot grad delta^3 (va(r) - va(r)') dif S',
$
which is the second term of @eq:electric-dipole-layer-auxiliary-1. Combining @eq:electric-dipole-layer-auxiliary-1, @eq:electric-dipole-layer-auxiliary-2, and @eq:electric-dipole-layer-effective-line-charge-density,
$
  rho(va(r)) &= lambda(va(r)_(partial S)) delta_(partial S) (va(r)) - [divsu(parallel) va(tau)_parallel (va(r)_S)] delta_S (va(r)) - [tau_perp (va(r)_S) vu(n)_va(r)_S dot grad delta_S (va(r)) + [divsu(parallel) va(tau)_perp (va(r)_S)] delta_S (va(r))] \
  &= lambda(va(r)_(partial S)) delta_(partial S) (va(r)) - divsu(parallel) va(tau) (va(r)_S) delta_S (va(r)) - tau_perp (va(r)_S) vu(n)_va(r)_S dot grad delta_S (va(r)) \
$
#theorem[
  The volume distribution of an electric dipole layer characterized by a surface dipole moment density $va(tau)$ is
  $
    rho(va(r)) = -tau_perp (va(r)_S) [pdv(, n_va(r)_S) delta_S (va(r))] + sigma(va(r)_S) delta_S (va(r)) + lambda(va(r)_(partial S)) delta_(partial S) (va(r)),
  $
  wherein
  $
    sigma = -divsu(parallel) va(tau), wide lambda = va(tau) dot vu(m)
  $
  are the _effective surface and line charge densities_.
]
Here we shall briefly consider a simpler case wherein $S = {z = 0}$. Accordingly, $va(r)_S = op("proj")_S va(r) = va(x) + va(y)$ and $vu(n) = vu(z)$. Then, where $delta$ is the one-dimensional Dirac delta,
$
  rho(va(r)) = -tau_z (va(r)_S) delta'(z) + sigma(va(r)_S) delta(z),
$ <eq:electric-dipole-layer-volume-density-distribution-expansion-flat>
wherein a complete typification of $sigma$ is given by
$
  sigma = - (vu(x) pdv(, x) + vu(y) pdv(, y)) dot va(tau).
$
(We have reasonably omitted the $lambda$ term: describing $S$ via the limit of concentric flat disks of increasing radii, we see that $supp delta_(partial S) -> {oo}$.)

In derivation of heuristics, let us consider a simplified representation thereof as a parallel plate capacitor, comprising two charged slabs of opposite sign.

For the first term, continuing to consider $S = {z = 0}$, let the dipole moment density be directed entirely along $vu(z)$ with $tau_z$ constant. Consider then a slab of negative charge immediately below $S$ and a slab of positive charge immediately above $S$, each uniform for fixed $z$. The resulting microscopic charge density, which shall here be denoted by $rho_L (z)$, is typified by two peaks of opposite sign in the immediate neighborhood of $z = 0$, negative for $z < 0$ and positive for $z > 0$, in such a manner that the total charge distribution is neutral:
$
  integral rho_L (z) dz = 0
$
with the dipole moment per unit area
$
  tau_z = integral z rho_L (z) dz.
$
In the macroscopic limit, wherein the separation of the slabs vanishes, the two peaks of $rho_L$ combine, similar much to the description $delta'$. (Appealing to the colloquial model of $delta$: a function with a single peak gives a derivative containing two opposite peaks, therefore it is natural for the macroscopic limit of $rho_L$ to contain $delta'$.) This is precisely the effect of the first term in @eq:electric-dipole-layer-volume-density-distribution-expansion-flat.

The second term arises only when $va(tau)$ is nonconstant along $S$, for otherwise the effective surface charge vanishes by cancellation. If for instance the dipoles vary in a way such that each specific $va(tau)_parallel$ points toward a central point, then thereat would the effective charge transpire to be positive, as the negative ends of each dipole point away thence. The local excess is measured by the surface divergence, $sigma = - nabla_parallel dot va(tau)_parallel$, in which sense that a variation in the relative description of neighboring dipoles, such that they cannot eliminate one another, gives rise to the second term.

// THIRD TERM!!!
The third term arises only when $partial S != emptyset$. Permit a brief and heuristic consideration of a neighborhood of $partial S$. Let $va(r)_(partial S)$ be a point of the edge, and let $vu(m)$ be the outward unit conormal thereat. The value $lambda = va(tau) dot vu(m)$ measures the component of the dipole density pointing outward from $S$ within its own plane, toward its edge. If this quantity is positive, $va(tau)$ points outward, and the positive end of each dipole near the edge lies nearer to $partial S$ than its negative end, insofar that at the outermost boundary $partial S$, the positive ends remain without canceling neighbor dipoles beyond the edge. If it is negative, the reverse implication holds and the leftover ends are negative. In the macroscopic limit, these uncancelled dipole ends give rise to an effective line charge $lambda$, and thus require the third term.

Considering $va(r) in S without partial S$ so that the calculation of $rho$ need not include the $lambda$ term, we now rederive the boundary conditions for $va(E)$ upon crossing the dipole layer. For this we appeal to superposition; writing
$ rho = -tau_perp pdv(, n_S) delta_S + sigma delta_S = rho_"dip" + rho_"surf", $
identifying "above" with the side matching $vu(n)$ and "below" with the other,
$
  vu(n) times Delta va(E) = vu(n) times Delta va(E)_"dip" + vu(n) times Delta va(E)_"surf" = vu(n) times Delta va(E)_"dip"
$ <eq:electric-dipole-layer-pre-boundary-cross-product>
since $Delta va(E)_"surf"$ is the precise change in electric field for a standard surface distribution $sigma$, which is parallel to $vu(n)$ by @sec:boundary-conditions.
/* By Poisson's equation (@eq:poisson),
$
  laplacian phi_"dip" = -rho_"dip" / epsilon_0 = tau_perp / epsilon_0 pdv(, n_S)delta
$
 */
Similar to therein shall we fix a small disk $D$ of radius $epsilon > 0$ about $va(r)$, whence
$
  Delta phi_"dip" & = Delta phi_("dip", S without D) + Delta phi_("dip", D) = Delta phi_("dip", D) \
  & = 1 / (4 uppi epsilon_0) Delta integral.triple_(D times (-, +)) (rho_"dip" (va(r)')) / xi dif^3 r' = - 1 / (4 uppi epsilon_0) Delta integral.triple_(D times (-, +)) (tau_perp (va(r)'_S) vu(n)_(va(r)'_S)) / xi dot gradp delta_S (va(r)') dif^3 r' \
  & = - Delta 1 / (4 uppi epsilon_0) integral.triple_(D times (-, +)) (tau_perp (va(r)'_S) vu(n)_(va(r)'_S) dot gradp) / xi integral.double_D delta^3 (va(r)' - va(r)'') dif S'' dif^3 r' \
  & = - Delta 1 / (4 uppi epsilon_0) integral.double_D integral.triple_(D times (-, +)) (tau_perp hat(n)_i) / xi partial_i delta^3 (va(r)' - va(r)'') dif^3 r' dif S'' \
  & = - Delta 1 / (4 uppi epsilon_0) integral.double_D integral.triple_(D times (-, +)) [partial_i ((tau_perp hat(n)_i) / xi delta^3) - delta^3 partial_i (tau_perp hat(n)_i) / xi] dif^3 r' dif S'' \
  & = Delta 1 / (4 uppi epsilon_0) integral.double_D [grad'' dot (tau_perp (va(r)''_S) vu(n)_(va(r)''_S)) / xi - integral.surf_(partial [D times (-, +)]) (tau_perp vu(n)) / xi delta^3 dot dif va(S)'] dif S'' \
  & = Delta 1 / (4 uppi epsilon_0) integral.double_D grad'' dot (tau_perp (va(r)''_S) vu(n)_(va(r)''_S)) / xi dif S''
$
wherein have we used the Divergence Theorem (@thm:divergence), and the observation that the support of $delta$, $va(r)' = va(r)''$, can only be attained when $va(r)'' in partial [D times (-, +)]$, which cannot occur with $D inter partial [D times (-, +)] = 0$. Hence, with a renaming of variables,
$
  Delta phi_"dip" & = Delta 1 / (4 uppi epsilon_0) integral.double_D divp (tau_perp (va(r)'_S) vu(n)_(va(r)'_S)) / xi dif S' = 1 / (4 uppi epsilon_0) Delta integral.double_D [(tau_perp gradp 1 / xi + 1 / xi gradp tau_perp) dot vu(n) + tau_perp / xi divp vu(n)] dif S' \
  &= Delta 1 / (4 uppi epsilon_0) integral.double_D [(tau_perp gradp 1 / xi + 1 / xi gradp tau_perp) dot vu(n) + tau_perp / xi divp vu(n)] dif S' \
  &= Delta 1 / (4 uppi epsilon_0) integral.double_D (gradp tau_perp dot vu(n) + tau_perp divp vu(n)) / xi dif S' + Delta 1 / (4 uppi epsilon_0) integral.double_D tau_perp gradp 1 / xi dot dif va(S)'.
$
Since for any bounded $f$,
$
  va(r) |-> integral.double_D f(va(r)') / xi dif S'
$
is continuous, an application hereof gives
$
  Delta phi_"dip" & = Delta 1 / (4 uppi epsilon_0) integral.double_D tau_perp gradp 1 / xi dot dif va(S)' = -Delta 1 / (4 uppi epsilon_0) integral.double_D tau_perp (va(r)'_S)(va(xi)) / xi^3 dot dif va(S)'.
$
For sufficiently small $epsilon$, $vu(n)$ and $tau_perp$ can be understood as approximately constant, thus
$
  Delta phi_"dip" & = Delta 1 / (4 uppi epsilon_0) integral.double_D tau_perp gradp 1 / xi dot dif va(S)' = -1 / (4 uppi epsilon_0) Delta [tau_perp (va(r)_S) vu(n)_va(r)_S dot integral.double_D (va(xi)) / xi^3 dif S'],
$
where the integral on the right was computed in @ex:electric-field-at-point-for-uniformly-charged-disk to give
$
  Delta phi_"dip" & -> Delta tau_perp (va(r)_S) vu(n)_va(r)_S dot plus.minus (vu(n)_va(r)_S) / (2 epsilon_0) &= tau_perp / epsilon_0,
$ <eq:electric-dipole-layer-potential-dipole-term-boundary-potential>
as $Delta va(r) -> 0$. Consequently,
$
  vu(n) times Delta va(E)_"dip" = 1 / epsilon_0 [grad tau_perp times vu(n)]
  /* = -(grad_parallel + grad_perp) tau_perp / epsilon_0,\
  vu(n) times Delta va(E)_"dip" = -vu(n) times grad_parallel tau_perp / epsilon_0 - vu(n) times vu(n)(vu(n) dot grad) tau_perp / epsilon_0 = grad_parallel tau_perp / epsilon_0 times vu(n) */
  = 1 / epsilon_0 [curl(tau_perp vu(n)_S) - tau_perp curl vu(n)_S] = (curl va(tau)_perp) / epsilon_0
$
By @eq:electric-dipole-layer-pre-boundary-cross-product,
#theorem[Boundary Conditions for a Dipole Layer][
  $
    vu(n) times Delta va(E) = (curl va(tau)_perp) / epsilon_0,
  $
  where $va(tau)$ is continued by $va(tau)(va(r)) = va(tau)(va(r)_S)$.
]
#todo[
  Make more explicit the definition of the curl of a surface-defined function and the vanishing of the curl of normal term
]
#todo[
  Also add surface divergence theorem somewhere
]
