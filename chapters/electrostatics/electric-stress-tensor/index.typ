#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Electric Stress Tensor"),
)

Where $rho$ is a volume charge density distribution in $Omega$, restricting $rho$ to $V subset.eq Omega$ and $Omega without V$ and extending the restrictions to vanish outside their previous regions, we obtain two charge distributions $rho_V, rho_(Omega without V)$ with disjoint supports such that $rho_V + rho_(Omega without V) = rho$ everywhere in $Omega$. The force exerted on the former distribution due to the latter is given by
$
  va(F) = integral.triple_V rho_V (va(r)) va(E)_(Omega without V) (va(r)) dif^3 r.
$
Observation of the self-force that
$
  integral.triple_V rho_V va(E)_V (va(r)) dif^3 r &= 1 / (4 uppi epsilon_0) integral.triple_V integral.triple_V (rho_V (va(r)) rho_V (va(r)')) / norm(va(r) - va(r)')^3 (va(r) - va(r)') dif^3 r' dif^3 r \
  &= 1 / (4 uppi epsilon_0) integral.triple_V integral.triple_V (rho_V (va(r)) rho_V (va(r)')) / norm(va(r) - va(r)')^3 va(r) dif^3 r' dif^3 r - /* integral.triple_V integral.triple_V */ (rho_V (va(r)) rho_V (va(r)')) / norm(va(r) - va(r)')^3 va(r)' dif^3 r' dif^3 r \
  &= 1 / (4 uppi epsilon_0) integral.triple_V integral.triple_V (rho_V (va(r)) rho_V (va(r)')) / norm(va(r) - va(r)')^3 va(r) dif^3 r' dif^3 r - /* integral.triple_V integral.triple_V */ (rho_V (va(r)') rho_V (va(r))) / norm(va(r)' - va(r))^3 va(r) dif^3 r dif^3 r' = 0,
$
it thus follows that
$
  va(F) &= integral.triple_V rho_V (va(r)) va(E)_(Omega without V) (va(r)) dif^3 r = integral.triple_V rho (va(r)) (va(E)_(Omega without V) + va(E)_V) (va(r)) dif^3 r = integral.triple_V rho (va(r)) va(E) (va(r)) dif^3 r \
  &= epsilon_0 integral.triple_V (div va(E)) va(E) (va(r)) dif^3 r
$
due to Gauss' Law (@thm:gauss-law). By the Einstein convention summing over repeated indices, and by realization that $div va(E) = partial_j E_j$, we have
$
  va(F) = epsilon_0 integral.triple_V vu(e)_i E_i partial_j E_j dif^3 r = epsilon_0 integral.triple_V vu(e)_i [partial_j (E_i E_j) - E_j partial_j E_i] dif^3 r.
$
In the electrostatic case,
$
  curl va(E) = 0 ==> partial_i E_j - partial_j E_i = 0 ==> E_j partial_j E_i &= E_k partial_i E_k #tag[(renaming $j -> k$)]\
  &= 1 / 2 partial_i (E_k E_k) = 1 / 2 (delta_(i j)partial_j) (E_k E_k)
$
thus entailing
$
  va(F) = epsilon_0 integral.triple_V vu(e)_i partial_j [E_i E_j - 1 / 2 delta_(i j) E_k E_k] dif^3 r = epsilon_0 integral.triple_V vu(e)_i partial_j [E_i E_j - 1 / 2 delta_(i j) va(E) dot va(E)] dif^3 r.
$ <eq:maxwell-electric-force-pre-tensor>
The inside quantity is given by:
#definition[Maxwell Electric Stress Tensor][
  The _Maxwell electric stress tensor_---a symmetric dyadic tensor---shall we denote by $vaa(T)$, is given with components
  $ T_(i j) = epsilon_0 (E_i E_j - 1 / 2 delta_(i j) E^2), $
  whence
  $
    vaa(T) = T_(i j) vu(e)_i times.o vu(e)_j & =
    #($x$, $y$, $z$).map(i => ($x$, $y$, $z$).map(j => $T_(#i#j) vu(#i) times.o vu(#j)$).join($+$)).join($\ &quad "" +$) \
    &= epsilon_0 (va(E) times.o va(E) - E^2 / 2 va(e)_i times.o va(e)_i),
  $
  wherein the last equality is its decomposition into dyads.
]
By virtue of rewriting @eq:maxwell-electric-force-pre-tensor using the above, we have
$
  va(F) &= vu(e)_i integral.triple_V partial_j T_(i j) dif^3 r = vu(e)_i integral.triple_V div (vu(e)_i dot vaa(T)) dif^3 r \
  &= vu(e)_i integral.triple_V div (vu(e)_i dot vaa(T)) dif^3 r = vu(e)_i integral.surf_(partial V) (vu(e)_i dot vaa(T)) dot dif va(S) \
  &=vu(e)_i [vu(e)_i dot integral.surf_(partial V) vaa(T) dot dif va(S)] = integral.surf_(partial V) vaa(T) dot dif va(S)
$ <eq:force-stress-surface-equation>
by the Divergence Theorem (@thm:divergence).
#todo[
  Add a section in math preliminaries comprising tensors, product notations (including juxtaposition), the dot products, non-commutativity except symmetry
]
