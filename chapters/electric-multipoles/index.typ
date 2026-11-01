#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Electric Multipoles"),
)
It is often the case that a localized (bounded within a sphere of radius $R$) charge distribution is of such complexity insofar that standard methods of study make the study thereof rather convoluted through traditional means. Suitably, practical applications demand the consequent use of necessitated approximations to specified degrees of precision.

This is also the precise problem that Taylor approximations aim to solve. Perhaps more accurately can the foreshadowed approximation be more analogous to the principal parts of Laurent expansions of a holomorphic function. They both are, in disparate manners, pole expansions, but in lieu of the expansion
$
  1 / (z - z') = sum_(n = 0)^oo z'^n / z^(n + 1),
$
we use the following expansion:
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
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo (-1)^n / n! integral.triple_(r' < R) rho(va(r)') product_(j = 1)^n r'_i_j partial_i_j 1 / r dif^3 r' \
  & = 1 / (4 uppi epsilon_0) sum_(n = 0)^oo (-1)^n / n!integral.triple_(r' < R) rho(va(r)') product_(j = 1)^n r'_i_j dif^3 r' (product_(j = 1)^n partial_i_j) 1 / r
$
