#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Electric Multipoles"),
)
It is often the case that a localized (bounded within a sphere of radius $R$) charge distribution is of such complexity insofar that standard methods of study make the study thereof rather convoluted through traditional means. Suitably, practical applications demand the consequent use of necessitated approximations to specified degrees of precision.

This is also the precise problem that Taylor approximations aim to solve. Perhaps more accurately can the foreshadowed approximation be more analogous to the principal parts of Laurent expansions of a holomorphic function. They both are, in disparate manners, pole expansions, but in lieu of the expansion
$
  1 / (z - z') = sum_(n = 0)^oo z'^n / z^(n + 1),
$
we use the following expansion
$
  1 / norm(va(r) - va(r)') = ee^(-va(r)' dot grad) 1 / r = sum_(n = 0)^oo 1 / n! (-va(r)' dot grad)^n 1 / r
$
within the Coulomb integral
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) integral.triple_(r' < R) rho(va(r)') / norm(va(r) - va(r)') dif^3 r'.
$
Thus, substitution thereof yields
$
  phi(va(r)) &= 1 / (4 uppi epsilon_0) integral.triple_(r' < R) rho(va(r)') sum_(n = 0)^oo 1 / n! (-va(r)' dot grad)^n 1 / r dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo 1 / n! integral.triple_(r' < R) rho(va(r)') (-va(r)' dot grad)^n 1 / r dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo 1 / n! integral.triple_(r' < R) rho(va(r)') (-r'_i partial_i)^n 1 / r dif^3 r'\
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo (-1)^n / n! integral.triple_(r' < R) rho(va(r)') (product_(j = 1)^n r'_i_j partial_i_j) 1 / r dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo (-1)^n / n! (integral.triple_(r' < R) rho(va(r)') product_(j = 1)^n r'_i_j dif^3 r') (product_(j = 1)^n partial_i_j) 1 / r,
$
wherein the intermediate steps are justified iff the expansion converges, notably when $r' < r$, which is entailed by the condition $r > R$.

Allow us the closer examination of a handful of individual terms
$
  phi(va(r)) & = 1 / (4 uppi epsilon_0) [integral.triple_(r' < R) rho(va(r)') dif^3 r' - integral.triple_(r' < R) rho(va(r)') r'_i_1 dif^3 r' partial_i_1 1 / r \
    &wide wide""+ 1 / 2 integral.triple_(r' < R) rho(va(r)') r'_i_1 r'_i_2 dif^3 r' partial_i_1 partial_i_2 1 / r + dots.c] \
  & = 1 / (4 uppi epsilon_0) [Q - (integral.triple_(r' < R) rho(va(r)') va(r)' dif^3 r') dot grad 1 / r \
    &wide wide""+ 1 / 2 integral.triple_(r' < R) rho(va(r)') r'_i_1 r'_i_2 vu(e)_i_1 times.o vu(e)_i_2 dif^3 r' : partial_i_1 partial_i_2 vu(e)_i_1 times.o vu(e)_i_2 1 / r + dots.c] \
  & = 1 / (4 uppi epsilon_0) [Q - (integral.triple_(r' < R) rho(va(r)') va(r)' dif^3 r') dot grad 1 / r \
    &wide wide""+ 1 / 2 integral.triple_(r' < R) rho(va(r)') va(r)' times.o va(r)' dif^3 r' : grad times.o grad 1 / r \
    &wide wide quad"" - 1 / 6 integral.triple_(r' < R) rho(va(r)') va(r)'^(times.o 3) dif^3 r' colon.tri.op grad^(times.o 3) 1 / r + dots.c],
$
wherein the follow definitions are utilized
#definition[
  The _electric monopole moment_ is simply the total charge
  $
    Q = integral.triple_(r' < R) rho(va(r)') dif^3 r'
  $
]
#definition[
  The _electric dipole moment_ is the vector given by
  $
    va(p) = integral.triple_(r' < R) rho(va(r)') va(r)' dif^3 r'
  $
]

#definition[
  The _electric quadruple moment_ is the dyadic tensor given by
  $
    vaa(Q) = integral.triple_(r' < R) rho(va(r)') va(r)' times.o va(r)' dif^3 r'
  $
]
