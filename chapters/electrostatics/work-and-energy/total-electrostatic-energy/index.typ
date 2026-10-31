#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Total Electrostatic Energy"),
)
#let uetot = $U_("E", "tot")$
#let uetoti = $U_("E", "tot", "no-self")$
Now let us entertain the case of a collection of $n in NN$ point charges $q_1, ..., q_n$. The _total electrostatic energy_ $uetoti$ is defined to be the total amount of work necessary to be done (performed quasi-statically by some "external agent," or infinitely slowly such that the kinetic energy never changes) in order to move all the point charges to a specified configuration from spatial infinity.

In the initial state, given that all charges lie at $oo$, we necessarily have $va(E) = 0$. Then the work required to bring the first charge $q_1$ to $va(r)_1$ is $W_1 = 0$. Upon completion hereof, the task of bringing a second charge $q_2$ now demands consideration of the potential field $ phi_1 : va(r) |-> 1 / (4 uppi epsilon_0) [q_1 / norm(va(r) - va(r)_1)] $ previously introduced by the first charge, which by @eq:electrostatic-work-to-bring-charge-to-point, is:
$
  W_2 = q_2 phi_1(va(r)_2),
$
whereupon the potential field is now
$
  phi_2(va(r)) = phi_1(va(r)) + 1 / (4 uppi epsilon_0) [q_2 1 / norm(va(r) - va(r)_2)] = 1 / (4 uppi epsilon_0) [q_1 / norm(va(r) - va(r)_1) + q_2 / norm(va(r) - va(r)_2)].
$
By repetition of said process across the span of all point charges,
$
  uetoti &= sum_(k = 1)^n W_k = sum_(k = 1)^n q_k phi_(k-1)(va(r)_k) = sum_(k=1)^n q_k 1 / (4 uppi epsilon_0)[sum_(j = 1)^(k-1) q_j / norm(va(r)_k - va(r)_j)] = 1 / (4 uppi epsilon_0) sum_(k = 1)^n sum_(j = 1)^(k - 1) (q_k q_j) / norm(va(r)_k - va(r)_j) \
  & = 1 / (8 uppi epsilon_0) sum_(k = 1)^n sum_(j = 1)^(k - 1) (q_k q_j) / norm(va(r)_k - va(r)_j) + 1 / (8 uppi epsilon_0) sum_(j = 1)^(n - 1) sum_(k = j + 1)^n (q_k q_j) / norm(va(r)_k - va(r)_j) = 1 / (8 uppi epsilon_0) sum_(k = 1)^n sum_(j = 1 \ j != k)^n (q_k q_j) / norm(va(r)_k - va(r)_j) \
  &= 1 / 2 sum_(k = 1)^n q_k phi_("all but" va(r)_k) (va(r)_k).
$ <eq:total-electrostatic-energy-integral-discrete>
As with previous instance, the natural extension hereof would be to consider a volume charge density distribution $rho(va(r))$, which is given by
$
  uetoti = 1 / (8 uppi epsilon_0) integral.triple rho(va(r)) integral.triple_(va(r)' != va(r)) rho(va(r)') / norm(va(r) - va(r)') dif^3 r' dif^3 r.
$
In the case that $rho$ is truly continuous, without the consideration of representations involving $delta$, the above may be plainly expressed as
$
  uetot = 1 / (8 uppi epsilon_0) integral.triple integral.triple (rho(va(r)) rho(va(r)')) / norm(va(r) - va(r)') dif^3 r' dif^3 r = 1 / 2 integral.triple rho(va(r)) phi(va(r)) dif^3 r,
$ <eq:total-electrostatic-energy-integral-no-E>
because for a small $epsilon$-ball $B_epsilon$ centered at $va(r)$ ,
$
  abs(integral.triple_B_epsilon (rho(va(r))rho(va(r)')) / norm(va(r) - va(r)') dif^3 r') <= max abs(rho)^2 integral_0^epsilon integral.double_(partial B_u) 1 / u dif S' dif u = max abs(rho)^2 integral_0^epsilon 4 uppi u dif u = 2 uppi epsilon^2 -> 0.
$
The form given in @eq:total-electrostatic-energy-integral-no-E is thus defined be the _total electrostatic potential energy_, whose important distinction from $uetoti$ is that we permit the diagonal cases in the integrand. In such a continuous distribution, as thus demonstrated, there is no difference therebetween. But it will not perpetually be as such, as shall be demonstrated in the immediate future.

The formulation of $uetoti$ cannot be made dependent on the order in which the charges were thus assembled. With great relevance to the previously made distinction, we also wish to redirect attention to the crucial fact that the given formulation of the total potential energy gives rise to a fundamental limitation to the electrodynamic formulation by point charges, whereto we point:
#example[
  Consider a solid ball of radius $R$ carrying a uniform volume charge density
  $
    rho = Q / (4 / 3 uppi R^3).
  $
  Compute its total electrostatic potential energy.
] <ex:uniform-ball-electrostatic-potential-energy>
#solution[to @ex:uniform-ball-electrostatic-potential-energy][
  Allow us to approach by direction of assemblage. Consider the ordering in which at each iteration, we aim to add a spherical shell of thickness $dr$ where a solid sphere of $r$ is already present. At the present moment, the electric field in the field exterior, by virtue of the Spherical Shell Theorem (@thm:spherical-shell), is identical to that of a point charge $Q$, whereby the electric potential (of only charges already assembled) at a point on the sphere boundary is also equivalent to that of a point charge:
  $
    phi_r (va(r)) = 1 / (4 uppi epsilon_0) (rho 4/3 uppi r^3) / r = 1 / (4 uppi epsilon_0) (Q r^2) / R^3
  $
  The work required to introduce a single constituent charge $dif Q$ is
  $
    dif W = 1 / (4 uppi epsilon_0) (Q r^2 dif Q) / R^3, //
  $
  whence that of which required to bring the entirety of $Q$ is
  $
    uetot &= integral dif W = integral.triple (Q r^2) / (4 uppi epsilon_0 R^3) rho dif^3 r = integral_0^R integral.double_(norm(va(r)) = r) (Q r^2) / (4 uppi epsilon_0 R^3) rho dif S dif r \
    &= integral_0^R 4 uppi r^2 (Q r^2) / (4 uppi epsilon_0 R^3) rho dif r = 1 / (4 uppi epsilon_0) (3 Q^2) / (R^6) integral_0^R r^4 dif r = 1 / (4 uppi epsilon_0) (3 Q^2) / (5 R). qedhere
  $

]
It could indeed transpire that calculation through the given chosen order of assemblage is actually easier than a direct application of @eq:total-electrostatic-energy-integral-no-E.

But to obtain the significance, as hinted at earlier, which is beheld within @ex:uniform-ball-electrostatic-potential-energy, we consider a point charge $Q$, which could be precisely modeled by @ex:uniform-ball-electrostatic-potential-energy under the limiting condition $R -> 0^+$. The result, by virtue of the calculation performed previously, diverges thereunder, whereas the representation in @eq:total-electrostatic-energy-integral-discrete gives $0$---the confusion or described discrepancy arises from the inclusion of diagonal self-terms (or the relaxation of $va(r)' != va(r)$ in @eq:total-electrostatic-energy-integral-discrete). For the natural handling of these discrepancies, the remaining contribution of said diagonal terms---the _self-energy_---is defined and thus transpires to be infinite for the case of point charges.

By Gauss' Law, $epsilon_0 div va(E) = rho$, whence @eq:total-electrostatic-energy-integral-no-E gives
$
  uetot & = 1 / 2 integral.triple rho(va(r)) phi(va(r)) dif^3 r = epsilon_0 / 2 integral.triple phi div va(E) dif^3 r = epsilon_0 / 2 integral.triple [div(phi va(E)) - va(E) dot grad phi] dif^3 r \
  &= lim_(R -> oo) epsilon_0 / 2 integral.surf_(r = R) phi va(E) dot dif va(S) + epsilon_0 / 2 integral.triple_(r < R) va(E)^2 dif^3 r
$ <eq:total-electrostatic-energy-integral-with-E>
(by the Divergence Theorem (@thm:divergence)). Imperatively, the expression in @eq:total-electrostatic-energy-integral-no-E holds throughout any volume which encloses all the charge, as all extraneous values for which $rho = 0$ contribute not to the integral. Correspondingly, this must entail, that in @eq:total-electrostatic-energy-integral-with-E, assuming $R$ sufficiently large as to enclose all charge, the volume integral can only be increasing therewith. It then must follow that the surface integral itself decreases, by an equal amount, to maintain this equality.

Assuming this compact support condition upon $rho$, #todo(block: false)[Vanish of term], the first integral vanishes, leaving in lieu thereof
#definition[
  $
    uetot = epsilon_0 / 2 integral.triple_(RR^3) va(E)^2 dif^3 r.
  $
]
In this formulation, the quantity $uetot$ is dependent on the electric field, and not necessarily $rho$. For this very reason $uetot$ has also been given the name "electric field energy." In the field of general relativity, it becomes incumbent to consider $uetot$ as a part of the field, with a volume energy density $epsilon_0 / 2 va(E)^2$.

The total field energy can also be determined as the sum of _self_ and _interaction_ energies of any two constituent bodies, which constitutes the preceding developments of this section. For instance, consider a continuous volume charge distribution $rho$, separated into two bodies $rho = rho_1 + rho_2$, whence
$
  uetot &= 1 / (8 uppi epsilon_0) integral.triple integral.triple (rho(va(r)) rho(va(r)')) / norm(va(r) - va(r)') dif^3 r' dif^3 r = 1 / (8 uppi epsilon_0) integral.triple integral.triple ((rho_1 + rho_2)(va(r)) (rho_1 + rho_2)(va(r)')) / norm(va(r) - va(r)') dif^3 r' dif^3 r\
  &= 1 / (8 uppi epsilon_0) integral.triple integral.triple (rho_1(va(r)) rho_1(va(r)') + rho_2(va(r)) rho_2(va(r)')) / norm(va(r) - va(r)') dif^3 r' dif^3 r + 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1(va(r)) rho_2(va(r)')) / norm(va(r) - va(r)') dif^3 r' dif^3 r \
  &= U_("E", "self") + U_("E", "int").
$
The term $U_"int"$ is the _interaction energy_ between the two distributions, which is precisely the potential energy between the two as defined in @eq:electrostatic-potential-energy-distribution. The previous relation entails that the given quantity does _not_ acquiesce to the superposition principle:
$
  U_("E", "tot", rho) = U_("E", "tot", rho_1) + U_("E", "tot", rho_2) + U_("E", "tot", "int")
$
by virtue of the quadraticity of its nature.
