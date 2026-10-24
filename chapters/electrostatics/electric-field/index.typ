#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [The Electric Field],
  route: "electric-field",
)
Experimental work nearing the end of the 18th century established that in the case of approximated point charges, the force on a stationary (time-static) _test charge_ $q$ at $va(r)$ due to $n$ stationary _source_ point charges $q_k$ at $va(r)_k$ follows the inverse-square law. The formulation thereof is given by _Coulomb's Law_, for the case of a vacuum:
#theorem[Coulomb's Law][
  //
  $ va(F) = 1 / (4 uppi epsilon_0) sum_(k=1)^n (q q_k) / norm(va(r) - va(r)_k)^3 (va(r) - va(r)_k). $ <eq:coulombs-law>
] <thm:coulombs-law>
The coefficient $1 / (4 uppi epsilon_0) = #qty("8.9875517923e9", "N * m / C^2")$ is also known as _Coulomb's constant_ and reflects our choice of units. In certain mediums, the constant $epsilon_0$ is replaced by a more general $epsilon$ which more accurely reflects the given medium (c.f. @todo).

There exists a generalization of @thm:coulombs-law which does not depend on the necessitated use of point source charges nor the explicity of the test charge $q$.
#definition[Electric Field][
  For a time-static source charge density distribution $rho(va(r))$, define
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral.triple (dif Q') / norm(va(r) - va(r)')^3 (va(r) - va(r)') = 1 / (4 uppi epsilon_0) integral.triple (rho(va(r)') dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)'),
  $
  known as the _electric field_.
]
Then Coulomb's Law states
$
  va(F) = q va(E).
$ <eq:coulombs-law-electric-field>
Moreover, this definition also well demonstrates the _principle of superposition_, which states that for a source charge density distribution, the electric field thereby can be calculated by the sum of the electric fields of each of the constituent summative pieces.

The abstraction as represented by the transition from @eq:coulombs-law to @eq:coulombs-law-electric-field demonstrates an important conceptual shift between force acting between charges at a large distance and a force determined by a local value of a single value, the electric field. It is likely entirely possible to develop the entirety of classical electrodynamics through the lens of action-at-a-distance, although doing so would likely prove to be cumbersome.

Subsequently,
#theorem[
  For electrostatics,
  $ div va(E) = rho / epsilon_0 quad "and" quad curl va(E) = 0. $
]
#proof[
  Write
  $// using dirac delta identities and gradient identities
  $
]
