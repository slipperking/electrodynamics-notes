#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Electric Stress Tensor"),
)

Where $rho$ is a volume charge density distribution in $Omega$, restricting $rho$ to $V subset.eq Omega$ and $Omega without V$ and extending the restrictions to vanish outside their previous regions, we obtain two charge distributions $rho_V, rho_(Omega without V)$ with disjoint supports such that $rho_V + rho_(Omega without V) = rho$ everywhere in $Omega$. The force exerted on the former distribution due to the latter is given by
$
  va(F) = integral.triple_V rho_V (va(r)) va(E)_(Omega without V) (va(r)) dif^3 r.
$
It thus follows from @eq:electric-distribution-force-self-vanish that
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
  va(F) &= vu(e)_i integral.triple_V partial_j T_(i j) dif^3 r = vu(e)_i integral.triple_V div (T_(i j) vu(e)_j) dif^3 r \
  &= vu(e)_i integral.triple_V div (vu(e)_i dot vaa(T)) dif^3 r = vu(e)_i integral.surf_(partial V) (vu(e)_i dot vaa(T)) dot dif va(S) \
  &=vu(e)_i [vu(e)_i dot integral.surf_(partial V) vaa(T) dot dif va(S)] = integral.surf_(partial V) vaa(T) dot dif va(S)
$ <eq:force-stress-surface-equation>
by the Divergence Theorem (@thm:divergence).
#todo[
  Add a section in math preliminaries comprising tensors, product notations (including juxtaposition), the dot products, non-commutativity except symmetry
]
To illustrate the validity of the stress tensor in the given formulation @eq:force-stress-surface-equation, we proceed through the following example:
#example[
  Let there be two point charges $q$ at $plus.minus d vu(z)$ ($d > 0$). Determine the electrostatic force exerted on the charge located at $d vu(z)$ by that located at $-d vu(z)$/*  by using the Maxwell electric stress tensor */.
] <ex:electric-stress-tensor-point-charges>
#solution[to @ex:electric-stress-tensor-point-charges][
  Denote by
  $
    S_R &= partial V_R = {va(r) = x vu(x) + y vu(y) + z vu(z) : norm(r) = R and z >= 0} union {x vu(x) + y vu(y) : x^2 + y^2 <= R^2} \ & = L_R (subset.eq {norm(r) = R}) union P_R (subset.eq #[$x y$-plane])
  $
  to be the closed hemispherical surface of radius $R$. The total electric field is thence given by
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) q / norm(va(r) - d vu(z))^3 (va(r) - d vu(z)) + 1 / (4 uppi epsilon_0) q / norm(va(r) + d vu(z))^3 (va(r) + d vu(z)),
  $
  $
    va(r) in P_r &==> va(E)(va(r)) = q / (4 uppi epsilon_0) [(x vu(x) + y vu(y) - d vu(z)) / (x^2 + y^2 + d^2)^(3 / 2) + (x vu(x) + y vu(y) + d vu(z)) / (x^2 + y^2 + d^2)^(3 / 2)]= (2 q) / (4 uppi epsilon_0) va(r) / (r^2 + d^2)^(3 / 2) \
    & ==> vaa(T)(va(r)) = (4 q^2 r^2) / (16 uppi^2 epsilon_0 (r^2 + d^2)^3) (vu(r) times.o vu(r) - 1 / 2 vaa(I)),
  $
  $
    va(r) in L_R &==> va(E)(va(r)) = q / (4 uppi epsilon_0) [(va(r) - d vu(z)) / (x^2 + y^2 + (z - d)^2)^(3 / 2) + (va(r) + d vu(z)) / (x^2 + y^2 + (z + d)^2)^(3 / 2)] \ & wide wide quad = q / (4 uppi epsilon_0) (2va(r)) / (R^2 + Order(R))^(3 / 2) = Order(1 / R^2) #tag[(as $R -> oo$)] \
    & ==> vaa(T)(va(r)) = Order(E^2) = Order(1 / R^4),
  $
  whence
  $
    va(F) &= lim_(R -> oo) integral.surf_S_R vaa(T) dot dif va(S) = lim_(R -> oo) integral.double_L_R vaa(T) dot dif va(S) + integral.double_P_R vaa(T) dot dif va(S) \
    &= lim_(R -> oo) integral.double_L_R Order(1 / R^4) dif S + integral.double_P_R (4 q^2 r^2) / (16 uppi^2 epsilon_0 (r^2 + d^2)^3) (vu(r) times.o vu(r) - 1 / 2 vaa(I)) dot vu(n) dif S \
    &= lim_(R -> oo) 2 uppi R^2 Order(1 / R^4) + integral.double_P_R (4 q^2 r^2) / (16 uppi^2 epsilon_0 (r^2 + d^2)^3) (vu(r) times.o vu(r) - 1 / 2 vaa(I)) dot vu(n) dif S \
    &= integral_0^oo integral_(-uppi)^uppi (4 q^2 r^3) / (16 uppi^2 epsilon_0 (r^2 + d^2)^3) (vu(r) times.o vu(r) - 1 / 2 vaa(I)) dot vu(n) dif theta dif r \
    &= integral_0^oo integral_(-uppi)^uppi (4 q^2 r^3) / (16 uppi^2 epsilon_0 (r^2 + d^2)^3) (1 / 2 vu(z) - vu(r) (vu(r) dot vu(z))) dif theta dif r #tag[(where $vu(n) = -vu(z)$)] \
    &= q^2 / (8 uppi^2 epsilon_0) integral_0^oo integral_(-uppi)^uppi r^3 / (r^2 + d^2)^3 vu(z) dif theta dif r = 1 / (4 uppi epsilon_0) q^2 vu(z) integral_0^oo r^3 / (r^2 + d^2)^3 dif r \
    &= 1 / (4 uppi epsilon_0) (q^2 vu(z)) / 2 integral_(d^2)^oo (u - d^2) / u^3 dif u = 1 / (4 uppi epsilon_0) (q^2 vu(z)) / 2 integral_(d^2)^oo (u - d^2) / u^3 dif u #tag[(where $u = r^2 + d^2$)]\
    &= 1 / (4 uppi epsilon_0) (q^2 vu(z)) / 2 integral_(d^2)^oo (u - d^2) / u^3 dif u = 1 / (4 uppi epsilon_0) (q^2 vu(z)) / (4 d^2). qedhere
  $
  //
]
