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
  phi_2(va(r)) = phi_1(va(r)) + 1 / (4 uppi epsilon_0) [q_2 1 / norm(va(r) - va(r)_2)] = 1 / (4 uppi epsilon) [q_1 / norm(va(r) - va(r)_1) + q_2 / norm(va(r) - va(r)_2)].
$
By repetition of said process across the span of all point charges,
$
  sum_(k = 1)^n W_k = sum_(k = 1)^n q_k phi_(k-1)(va(r)_k) = sum_(k=1)^n q_k 1 / (4 uppi epsilon_0)[sum_(j = 1)^(k-1) q_j / norm(va(r)_k - va(r)_j)] = 1 / (4 uppi epsilon_0) sum_(k = 1)^n sum_(j = 1)^(k - 1) (q_k q_j) / norm(va(r)_k - va(r)_j).
$
The right hand side enumerates through
