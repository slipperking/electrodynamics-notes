#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Electric Multipoles"),
  children: {
    include "electric-dipole/index.typ"
    include "electric-quadrupole/index.typ"
    include "legendre-polynomials/index.typ"
    include "spherical-azimuthal-multipoles/index.typ"
  },
)
It is often the case that a localized charge distribution---bounded within a sphere of radius $R$ centered at $va(r)_0$---is of such complexity insofar that standard methods of study make the study thereof rather convoluted through traditional means. Suitably, practical applications demand the consequent use of necessitated approximations to specified degrees of precision.

This is also the precise problem that Taylor approximations aim to solve. Perhaps more accurately can the foreshadowed approximation be more analogous to the principal parts of Laurent expansions of a holomorphic function. They both are, in disparate manners, pole expansions; in the complex case,
$
  1 / (z - z') = 1 / ((z - a) - (z' - a)) = sum_(n = 0)^oo (z' - a)^n / (z - a)^(n + 1).
$
Denote by $va(s) = va(r) - va(r)_0$ the separation vector from the center $va(r)_0$ to the field point $va(r)$ and likewise $va(s)' = va(r)' - va(r)_0$. The Coulomb integral then gives the electric potential
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) integral.triple_(s' < R) rho(va(r)') / norm(va(s) - va(s)') dif^3 r'.
$
In lieu of the complex expansion above, we observe $hfrc(1 / norm(va(s) - va(s)'))$ for $s' > R$:
$
  1 / norm(va(s) - va(s)') = ee^(-va(s)' dot grad) 1 / s = sum_(n = 0)^oo 1 / n! (-va(s)' dot grad)^n 1 / s,
$ <eq:electric-multipole-expansion-kernel>
within the Coulomb integral. Thus, substitution thereof yields
$
  phi(va(r)) &= 1 / (4 uppi epsilon_0) integral.triple_(s' < R) rho(va(r)') sum_(n = 0)^oo 1 / n! (-va(s)' dot grad)^n 1 / s dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo 1 / n! integral.triple_(s' < R) rho(va(r)') (-va(s)' dot grad)^n 1 / s dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo 1 / n! integral.triple_(s' < R) rho(va(r)') (-s'_i partial_i)^n 1 / s dif^3 r'\
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo (-1)^n / n! integral.triple_(s' < R) rho(va(r)') (product_(j = 1)^n s'_i_j partial_i_j) 1 / s dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo (-1)^n / n! (integral.triple_(s' < R) rho(va(r)') product_(j = 1)^n s'_i_j dif^3 r') (product_(j = 1)^n partial_i_j) 1 / s,
$
wherein the intermediate steps are justified iff the expansion converges, notably when $s' < s$, which is entailed by the condition $s > R$.

Allow us the closer examination of a handful of individual terms
$
  phi(va(r)) & = 1 / (4 uppi epsilon_0) [integral.triple_(s' < R) rho(va(r)') dif^3 r' 1/s - integral.triple_(s' < R) rho(va(r)') s'_i_1 dif^3 r' partial_i_1 1 / s \
    &wide wide + 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i_1 s'_i_2 dif^3 r' partial_i_1 partial_i_2 1 / s + dots.c] \
  & = 1 / (4 uppi epsilon_0) [Q/s - (integral.triple_(s' < R) rho(va(r)') va(s)' dif^3 r') dot grad 1 / s \
    &wide wide + 1 / 2 integral.triple_(s' < R) rho(va(r)') va(s)' times.o va(s)' dif^3 r' : grad times.o grad 1 / s \
    &wide wide - 1 / 6 integral.triple_(s' < R) rho(va(r)') va(s)'^(times.o 3) dif^3 r' colon.tri.op grad^(times.o 3) 1 / s + dots.c], \
  & = 1 / (4 uppi epsilon_0) [Q - va(p) dot grad + /* 1 / 2  */vaa(Q) : grad^(times.o 2) - /* 1 / 6  */vb(O) colon.tri.op grad^(times.o 3) + dots.c + (-1)^n vb(C)^((n)) limits(dot)^n grad^(times.o n) + dots.c] 1 / s,
$ <eq:electric-multipole-expansion>
wherein the following definitions are utilized
#definition[
  The _electric monopole moment_ is simply the total charge
  $
    Q = integral.triple_(s' < R) rho(va(r)') dif^3 r'
  $
]
#definition(restate: true)[
  The _electric dipole moment_ is the vector given by
  $
    va(p) = integral.triple_(s' < R) rho(va(r)') va(s)' dif^3 r'
  $
] <def:electric-dipole-moment>

#definition(restate: true)[
  The _(primitive) electric quadrupole moment_ is the dyadic tensor given by
  $
    vaa(Q) = 1 / 2 integral.triple_(s' < R) rho(va(r)') va(s)' times.o va(s)' dif^3 r'
  $
] <def:electric-quadrupole-moment>
#definition[
  The _(primitive) electric octupole moment_ is the triadic tensor given by
  $
    vb(C)^((3)) = vaaa(O) = 1 / 6 integral.triple_(s' < R) rho(va(r)') va(s)'^(times.o 3) dif^3 r'
  $
]
#definition[
  The _(primitive) electric moment of order $n$_ is the $n$-adic tensor given by
  $
    vb(C)^((n)) = 1 / n! integral.triple_(s' < R) rho(va(r)') va(s)'^(times.o n) dif^3 r'
  $
]
It often transpires that we restrict our consideration to not beyond the quadrupole moment. The naming of higher-order terms is given by powers of two accordingly (beyond the octupole we have the _hexadecapole_, or the $16$-pole; and further, _dotriacontapole_, or the $32$-pole, et cetera).

If $rho$ is a spherically symmetric volume charge density distribution in ${s' <= R}$, the corresponding multipole expansion leaves but the monopole term, which is the precise potential for a point charge.
