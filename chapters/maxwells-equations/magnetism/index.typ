#import "/lib.typ": *
#show: docs-subchapter.with(..dargs("Magnetism"))
In 1600, William Gilbert correctly concluded that Earth behaves as a large permanent magnet. In the 1750s, John Michell showed that the force between the two ends of a rod-like permanent magnet behaves according to an inverse-square law. Upon further confirmation of these results, Poisson introduced a theory of magnetism involving an analogous magnetic equivalent of electric charge and force.

It was later found in 1820 that a current-carrying wire produces effects comparable to a permanent magnet. Further experiments were conducted, and notably, Ampère gave the force on a closed loop $L$ carrying a current $I$ due to $N$ other loops $L_k$ carrying respective currents $I_k$ to be
#theorem[Ampère Force Law][
  $
    va(F) &= -mu_0 / (4 uppi) integral.cont_L I dif va(ell) dot [sum_(k = 1)^N integral.cont_L_k I_k dif va(ell)_k times.o (va(r) - va(r)_k) / norm(va(r) - va(r)_k)^3] \ &= -mu_0 / (4 uppi) sum_(k = 1)^N integral.cont_L integral.cont_L_k I_k I (va(r) - va(r)_k) / norm(va(r) - va(r)_k)^3 dif va(ell)_k dot dif va(ell),
  $ <eq:magnetostatics-ampere-force>
]
wherein the factor $mu_0 / (4 uppi)$ is due to the choice of SI units, and
$ mu_0 = #qty("1.256637061e-6", "N / A^2") $ is the _vacuum permeability_. In 1820, Biot and Savart determined
#theorem[Biot--Savart Law][
  $
    va(B)(va(r)) = mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L_k I_k dif va(ell)_k times (va(r) - va(r)_k) / norm(va(r) - va(r)_k)^3
  $ <eq:biot-savart-law>
] <thm:biot-savart-law>
to be the _magnetic field_, whereby @eq:magnetostatics-ampere-force is simply
$
  va(F) = integral.cont_L I dif va(ell) times va(B)(va(r)).
$ <eq:line-magnetostatic-force>
#proof(collapsed: true)[of the consistency of @eq:line-magnetostatic-force][
  We appeal to a simple substitution yielding
  $
    integral.cont_L I &dif va(ell) times va(B)(va(r)) = integral.cont_L I dif va(ell) times [mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L_k I_k dif va(ell)_k times (va(r) - va(r)_k) / norm(va(r) - va(r)_k)^3] \
    &= mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L integral.cont_L_k I I_k dif va(ell) times (dif va(ell)_k times (va(r) - va(r)_k) / norm(va(r) - va(r)_k)^3) \
    &= mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L integral.cont_L_k I I_k [dif va(ell)_k (dif va(ell) dot (va(s)_k) / s_k^3) - (va(s)_k) / s_k^3 (dif va(ell) dot dif va(ell)_k)] \
    &= mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L_k [integral.cont_L I I_k (va(s)_k) / s_k^3 dot dif va(ell)] dif va(ell)_k - integral.cont_L I integral.cont_L_k I_k (va(s)_k) / s_k^3 (dif va(ell) dot dif va(ell)_k) \
    &= -mu_0 / (4 uppi) [sum_(k=1)^N integral.cont_L_k (integral.cont_L I I_k grad 1 / s_k dot dif va(ell)) dif va(ell)_k + integral.cont_L integral.cont_L_k I I_k (va(s)_k) / s_k^3 (dif va(ell) dot dif va(ell)_k)]\
    \
    &= -mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L integral.cont_L_k I I_k (va(s)_k) / s_k^3 (dif va(ell) dot dif va(ell)_k)
  $
  by the Gradient Theorem (@thm:gradient).
]
One can also correctly guess that the field $va(B)$ satisfies the principle of superposition. The representation in @eq:biot-savart-law can be thought to be the sum of the magnetic fields due to each individual Ampèrian loop.
It is imperative to impose the aforesaid condition in utilizing the previous results.

The current $I$, which can be thought to be the one-dimensional analogue of the discussed cases in @sec:current-density, is the amount of charge per unit time passing any specified point in the wire, which we shall consider to be an approximation of a three-dimensional tubular wire with line element $dif va(ell)_k$, where at a specified point $va(r)_k$ with cross section $S_va(r)_k$ we must have
$
  I_k dif va(ell)_k = integral.double_S va(J)_k (va(r)'_k) dot dif va(S)'_k dif va(ell)_k
$
Since the cross-sectional element $dif va(S)'_k$ points in the same direction as $dif va(ell)_k$ and as $va(J)$ assuming the absence of transverse currents,
$
  I_k dif va(ell)_k = integral.double_S va(J)_k dif S'_k dif ell_k = integral.double_S va(J)_k [dif^3 r'_k],
$
whence this three-dimensional generalization transforms the Biot--Savart representation to the consequent space _definition_ of the magnetic field:
$
  va(B)(va(r)) &= mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L_k I_k dif va(ell)_k times (va(r) - va(r)_k) / norm(va(r) - va(r)_k)^3 \
  &= mu_0 / (4 uppi) sum_(k=1)^N integral.cont_L_k integral.double_S va(J)_k (va(r)'_k) dif^3 r'_k times (va(r) - va(r)_k) / norm(va(r) - va(r)_k)^3 \
  &= mu_0 / (4 uppi) integral.triple va(J) (va(r)') times (va(r) - va(r)') / norm(va(r) - va(r)')^3 dif^3 r'.
$
The term _magnetostatics_ supplements the _steady-current_ condition $div va(J) = 0$, by introducing
$
  pdv(va(E), t) = pdv(va(B), t) = pdv(rho, t) = pdv(va(J), t) = 0.
$ <eq:magnetostatics-condition>
Furtherances in experimental development, equating the described phenomena with the behavior of permanent magnets, gave rise to
$
  div va(B) = 0 wide "and" wide curl va(B) = mu_0 va(J).
$
There is no universally agreed upon name given to the first equation. It is, as we shall thus describe, often referred to as _Gauss' Law for Magnetism_, the validity whereof holds even outside the magnetostatic case. The second equation, which is valid solely in the magnetostatic case, is referred to as _Ampère's Law_. Suitable modifications are necessitated to generalize beyond the magnetostatic case.
