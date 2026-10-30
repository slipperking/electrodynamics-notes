#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Total Electrostatic Energy"),
)
Now let us entertain the case of a collection of $n in NN$ point charges $q_1, ..., q_n$. The _total electrostatic energy_ $U_(va(E), "tot")$ is defined to be the total amount of work necessary to be done in order to move all the point charges to a specified configuration from spatial infinity.

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
  U_(va(E), "tot") &= sum_(k = 1)^n W_k = sum_(k = 1)^n q_k phi_(k-1)(va(r)_k) = sum_(k=1)^n q_k 1 / (4 uppi epsilon_0)[sum_(j = 1)^(k-1) q_j / norm(va(r)_k - va(r)_j)] = 1 / (4 uppi epsilon_0) sum_(k = 1)^n sum_(j = 1)^(k - 1) (q_k q_j) / norm(va(r)_k - va(r)_j) \
  & = 1 / (8 uppi epsilon_0) sum_(k = 1)^n sum_(j = 1)^(k - 1) (q_k q_j) / norm(va(r)_k - va(r)_j) + 1 / (8 uppi epsilon_0) sum_(j = 1)^(n - 1) sum_(k = j + 1)^n (q_k q_j) / norm(va(r)_k - va(r)_j) = 1 / (8 uppi epsilon_0) sum_(k = 1)^n sum_(j = 1 \ j != k)^n (q_k q_j) / norm(va(r)_k - va(r)_j) \
  &= 1 / 2 sum_(k = 1)^n q_k phi_("all but" va(r)_k) (va(r)_k).
$
As with previous instance, the natural extension hereof would be to consider a volume charge density distribution $rho(va(r))$, which is given by
$
  U_(va(E), "tot") = 1 / (8 uppi epsilon_0) integral.triple rho(va(r)) integral.triple_(va(r)' != va(r)) rho(va(r)') / norm(va(r) - va(r)') dif^3 r' dif^3 r.
$
In the case that $rho$ is truly continuous, without the consideration of representations involving $delta$, the above may be plainly expressed as
$
  U_(va(E), "tot") = 1 / (8 uppi epsilon_0) integral.triple integral.triple (rho(va(r)) rho(va(r)')) / norm(va(r) - va(r)') dif^3 r' dif^3 r = 1 / 2 integral.triple rho(va(r)) phi(va(r)) dif^3 r,
$ <eq:total-electrostatic-energy-integral-no-E>
because for a small $epsilon$-ball $B_epsilon$ centered at $va(r)$ ,
$
  abs(integral.triple_B_epsilon (rho(va(r))rho(va(r)')) / norm(va(r) - va(r)') dif^3 r') <= max abs(rho)^2 integral_0^epsilon integral.double_(partial B_(r')) 1 / u dif S' dif u = max abs(rho)^2 integral_0^epsilon 4 uppi u dif u = 2 uppi epsilon^2 -> 0.
$
The formulation of $U_(va(E), "tot")$ cannot be made dependent on the order in which the charges were thus assembled. We also note that the given formulation of the total potential energy gives rise to a fundamental limitation to the formulation by point charges, whereto this we point to:
#example[
  Consider a solid ball of radius $R$ carrying a uniform volume charge density
  $
    rho = Q / (4 / 3 uppi R^3).
  $
  Compute its total electrostatic potential energy.
]
#solution[
  $
    U_(va(E), "tot") = 1 /2 integral.triple
  $
]

By Gauss' Law, $epsilon_0 div va(E) = rho$, whence @eq:total-electrostatic-energy-integral-no-E gives
$
  U_(va(E), "tot") & = 1 / 2 integral.triple rho(va(r)) phi(va(r)) dif^3 r = epsilon_0 / 2 integral.triple phi div va(E) dif^3 r = epsilon_0 / 2 integral.triple [div(phi va(E)) - va(E) dot grad phi] dif^3 r \
  &= lim_(R -> oo) epsilon_0 / 2 integral.surf_(r = R) phi va(E) dot dif va(S) + epsilon_0 / 2 integral.triple_(r < R) va(E)^2 dif^3 r
$ <eq:total-electrostatic-energy-integral-with-E>
(by the Divergence Theorem (@thm:divergence)). Imperatively, the expression in @eq:total-electrostatic-energy-integral-no-E holds throughout any volume which encloses all the charge, as all extraneous values for which $rho = 0$ contribute not to the integral. Correspondingly, this must entail, that in @eq:total-electrostatic-energy-integral-with-E, assuming $R$ sufficiently large as to enclose all charge, the volume integral can only be increasing therewith. It then must follow that the surface integral itself decreases, by an equal amount, to maintain this equality.

Assuming this compact support condition upon $rho$, #todo(inline: true)[Vanish of term], the first integral vanishes, leaving
$
  U_(va(E), "tot") = epsilon_0 / 2 integral.triple_(RR^3) va(E)^2 dif^3 r.
$
