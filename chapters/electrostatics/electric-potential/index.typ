#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Electric Potential"),
)
In the electrostatic case, the electric field $va(E)$ is irrotational by @eq:gauss-law. Then Stokes' Theorem (@thm:stokes) implies that for any arbitrary surface $S$,
$
  0 = integral.double_S curl va(E) dot dif va(S) = integral.cont_(partial S) va(E) dot dif va(l);
$
equivalently, the line integral of the electric field is path-independent and therefore gives rise to a well-defined function
$
  V(va(r)) = -integral^va(r) va(E)(va(r)') dot dif va(l)',
$ <eq:electric-potential>
where we integrate from a predefined reference point---the choice thereof is of little importance and different choices thereof result in functions differing by a constant, which disappear as we typically restrict our consideration and interests to the difference between values attained by $V$.

#definition[Electric Potential][
  @eq:electric-potential is known as the _electric potential_. For two points $va(a), va(b)$, the expression
  $ V(va(b)) - V(va(a)) $
  is referred to as the _potential difference_ between $va(a)$ and $va(b)$.
]
Thence the potential difference is given by
$
  -integral_(va(a))^va(b) va(E) dot dif va(l) = V(va(b)) - V(va(a)) = integral_va(a)^va(b) grad V dot dif va(l) ==> integral_(va(a))^va(b) (va(E) + grad V) dot dif va(l) = 0
$
by the Gradient Theorem (@thm:gradient), whence
$
  va(E) = -grad V
$ <eq:gradient-of-electric-potential>
by the arbitrariness of $va(a),va(b)$, for indeed if some $va(r)$ satisfied $va(E)(va(r)) + grad V (va(r))!= 0$, then letting $ vu(u) = (va(E)(va(r)) + grad V(va(r))) / norm(va(E)(va(r)) + grad V(va(r))), $ the integral from $va(r)$ to $va(r) + vu(u) epsilon$ of $(va(E) + grad V) dot dif va(l)'$ would be asymptotically equal to $norm(va(E)(va(r)) + grad V(va(r))) epsilon != 0$ as $epsilon -> 0$, thereby insinuating a contradiction.

Using the identity $laplacian = op(bold("div")) op(bold("grad"))$, Gauss' Law (@thm:gauss-law) entails that
#theorem[Poisson's equation][
  $
    laplacian V = -div va(E) = -rho / epsilon_0,
  $
]
and in regions free of charge,
$
  laplacian V = 0,
$
i.e. $V$ is harmonic.

At times, it becomes incumbent to resolve the fundamental ambiguity---the reference point wherefrom the integral in @eq:electric-potential starts. The electric potential itself comprises no real physical significance, so for any given point a relocation of the starting point may be performed, as with the definition of potential energies in mechanics. There is a correspondence between its behavior and the characterization of altitude; wherein the reference point is commonly taken to be sea level. The only pertaining quantity wherein we are interested is the altitude difference between two points.

However, it does transpire that there is a heuristically "natural" spot to define our reference point, and that is the point which is infinitely far from charge---the motivation hereof presupposes that $V(va(r)_0) = 0$, where $va(r)_0$ is the chosen reference point. That is, we are integrating from the $oo$ point itself:
$
  V(va(r)) = -integral_(oo)^va(r) va(E)(va(r)') dot dif va(l)'.
$ <eq:electric-potential-oo>
In a great number of previous examples a notion of an unbounded, infinite, and expansive charge distribution was entertained, whereupon the potential itself diverges everywhere and this convention fails---the resolution is hence to choose any other point as $va(r)_0$ and make explicit of such fact---although, in all practical cases no such charge distribution can continue indefinitely and such a convention poses no issue.

#example[
  A hollow sphere of radius $R$ carries a uniform surface charge $sigma = Q / (4 uppi R^2)$. Find the electric potential $V$, such that $V(oo) = 0$.
] <ex:spherical-shell-electric-potential>
#solution[to @ex:spherical-shell-electric-potential][
  Assuming the sphere to be centered at the origin, the electric field for $va(r)$ outside the sphere ($r > R$) is given by the Spherical Shell Theorem (@thm:spherical-shell) to be
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) Q / r^2 vu(r).
  $
  The electric potential, given by @eq:electric-potential-oo, is then
  $
    V(va(r)) &= -Q / (4 uppi epsilon_0) integral_oo^va(r) vu(r)' / r'^2 dot dif va(l)' = Q / (4 uppi epsilon_0) integral_oo^va(r) grad' 1 / r' dot dif va(l)' = 1 / (4 uppi epsilon_0) Q / r
  $
  by the Gradient Theorem (@thm:gradient). Moreover, $va(E)$ vanishes inside the sphere ($r < R$), so for all points therein, $grad V = 0$, entailing the constancy of $V$. As $V$ attains the same values in $jinterior(S)$ as on $S$, the latter whereof are given by
  $
    V(va(r)) = lim_(va(r)' -> S \
    va(r)' in jexterior S) V(va(r)') = 1 / (4 uppi epsilon_0) Q / R. qedhere
  $
]
Previously we have defined $V$ in terms of $va(E)$. However the vector expression of $va(E)$ itself tends to transpire as cumbersome to compute. It will transpire that---as shall we aver---that the computation of $va(E)$ is generally much simpler by presupposing a suitable expression for $V$ and the subsequent application of the gradient.

For a given volume charge density distribution $rho(va(r))$,
$
  V(va(r)) &= -integral_oo^va(r) integral.triple (rho(va(r)') dif V') / norm(va(r)'' - va(r)')^3 (va(r)'' - va(r)') dot dif va(l)'' \
  &= - integral.triple rho(va(r)') integral_oo^va(r) (va(r)'' - va(r)') / norm(va(r)'' - va(r)')^3 dot dif va(l)'' dif V' \
  &= integral.triple rho(va(r)') integral_oo^va(r) grad 1 / norm(va(r)'' - va(r)') dot dif va(l)'' dif V'
$
whereby the Gradient Theorem (@thm:gradient) implies
#theorem[
  $
    V(va(r)) = integral.triple rho(va(r)') evaluated(1 / norm(va(r)'' - va(r)'))_oo^va(r) dif V' = integral.triple rho(va(r)') / norm(va(r) - va(r)') dif V'.
  $ <thm:electric-potential-integral>
]
It is necessary to observe that this representation implicitly assumes that the reference point is at $oo$, as it was assumed in our derivation. Thus, @thm:electric-potential-integral may prove to be inapplicable in the hypothetical situations of an infinite charge density distribution; the divergence of the integral would necessitate a revision of the reference point.
#example[
]
