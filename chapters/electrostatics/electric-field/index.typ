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
  $ <eq:electric-field>
  known as the _electric field_. For a surface or line charge distribution, this is
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral.double (sigma(va(r)') dif S') / norm(va(r) - va(r)')^3 (va(r) - va(r)'),\ va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral (lambda(va(r)') dif s') / norm(va(r) - va(r)')^3 (va(r) - va(r)').
  $ <eq:electric-field-surface-line>
]
Then Coulomb's Law states
$
  va(F) = q va(E).
$ <eq:coulombs-law-electric-field>
Moreover, this definition also well demonstrates the _principle of superposition_, which states that for a source charge density distribution, the electric field thereby can be calculated by the sum of the electric fields of each of the constituent summative pieces.

The abstraction as represented by the transition from @eq:coulombs-law to @eq:coulombs-law-electric-field demonstrates an important conceptual shift between force acting between charges at a large distance and a force determined by a local value of a single value, the electric field. It is likely entirely possible to develop the entirety of classical electrodynamics through the lens of action-at-a-distance, although doing so would likely prove to be cumbersome.

Subsequently,
#theorem[Gauss' Law][
  For electrostatics,
  $ div va(E) = rho / epsilon_0 quad "and" quad curl va(E) = 0. $
] <thm:gauss-law>
#proof[
  Recall from @todo that
  $
    // using dirac delta identities and gradient identities
    (va(r) - va(r)') / norm(va(r) - va(r)')^3 = - grad 1 / norm(va(r) - va(r)') quad "and" quad laplacian 1 / (norm(va(r) - va(r)')) = - 4 uppi delta(va(r) - va(r)'),
  $
  whence @eq:electric-field can be rewritten to yield
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral.triple_V (rho(va(r)') dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)') = -1 / (4 uppi epsilon_0) integral.triple_V grad rho(va(r)') 1 / norm(va(r) - va(r)') dif V'.\
    curl va(E)(va(r)) = -1 / (4 uppi epsilon_0) integral.triple_V curl grad rho(va(r)') 1 / norm(va(r) - va(r)') dif V' = 0,
  $
  proving the first identity, and
  $
    div va(E)(va(r)) & = -1 / (4 uppi epsilon_0) integral.triple_V div grad rho(va(r)') 1 / norm(va(r) - va(r)') dif V' \
    & = -1 / (4 uppi epsilon_0) integral.triple_V laplacian rho(va(r)') 1 / norm(va(r) - va(r)') dif V' \
    & = -1 / (4 uppi epsilon_0) integral.triple_V rho(va(r)') [-4 uppi delta(va(r) - va(r)')] dif V' = (rho(va(r))) / (epsilon_0). qedhere
  $
]
Gauss' Law (@thm:gauss-law) is the first of the four _Maxwell's equations_. We shall eventually see that the first equation $div va(E) = rho / epsilon_0$ will hold not only for electrostatics but for any general situation, as with all Maxwell's equations.
#figure-wrapper[
  #figure(
    canvas(
      //
    ),
    caption: [],
  )
]
#example[
  Find the electric field a distance $z$ above the midpoint of a straight line segment of length $L$ carrying a uniform charge density $lambda$.
] <ex:electric-field-at-point-for-uniformly-charged-line>
#solution[to @ex:electric-field-at-point-for-uniformly-charged-line][
  By @eq:electric-field-surface-line,
  $
    va(E)(z vu(z)) = 1 / (4 uppi epsilon_0) integral_(-L / 2)^(L / 2) (lambda dif x) / norm(z vu(z) - x vu(x))^3 (z vu(z) - x vu(x)) = lambda / (4 uppi epsilon_0) integral_(-L / 2)^(L / 2) (z vu(z) - x vu(x)) / (x^2 + z^2)^(3/2) dx.
  $
  The $x$-component of the above integrand vanishes by symmetry. Therefore, with $x = z tan theta$,
  $
    va(E)(z vu(z)) &= (z vu(z))/ (4 uppi epsilon_0) lambda integral_(-L / 2)^(L / 2) dx / (x^2 + z^2)^(3/2) = (z vu(z))/ (4 uppi epsilon_0) lambda integral (dif (z tan theta)) / (z^2 (tan theta^2 + 1))^(3/2) \
    & = vu(z)/ (4 uppi epsilon_0 z) lambda integral (sec^2 theta dif theta) / (sec^3 theta) = vu(z)/ (4 uppi epsilon_0 z) lambda evaluated(sin theta)_(x = -L / 2)^(x = L / 2) \ & = vu(z)/ (4 uppi epsilon_0 z) lambda evaluated(x / sqrt(x^2 + z^2))_(-L / 2)^(L / 2) = 1 / (4 uppi epsilon_0 z) (L lambda vu(z)) / sqrt(L^2 + z^2). qedhere
  $
]

Notably, in consideration of a wire of infinite length, then the electric field evaluated at a point a distance $z > 0$ away is given by
$
  va(E)(va(r)) = lim_(L -> oo) 1 / (4 uppi epsilon_0 z) (L lambda vu(z)) / sqrt(L^2 + z^2) = (lambda vu(z)) / (4 uppi epsilon_0 z).
$
At a long distance ($z >> L$),
$
  va(E)(va(r)) = 1 / (4 uppi epsilon_0 z) (L lambda vu(z)) / sqrt(L^2 + z^2) approx 1 / (4 uppi epsilon_0 z) (L lambda vu(z)) / z = (L lambda vu(z)) / (4 uppi epsilon_0 z^2),
$
which is the precise electric field generated by a stationary source point charge $L lambda$; which validates the intuition that at long distances, the configuration of electric bodies may be approximated with a singular point charge.
