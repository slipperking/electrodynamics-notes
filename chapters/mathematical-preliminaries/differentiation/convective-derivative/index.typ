#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Convective Derivative],
  route: "convective-derivative",
)
In the general consideration of time-varying scalar field $phi(va(r), t)$, the change of $phi$ with respect to $t$, as observed by a stational observer at $va(r)$, is given by $pdv(phi, t)$. Then the natural extension would be to consider how $phi$ would change if the observer position also varied in time, i. e. $va(r)(t) = x(t) vu(x) + y(t) vu(y) + z(t) vu(z)$, which is answered with a simple application of the chain rule:
$
  pdv(, t) phi(va(r)(t), t) &= pdv(phi(va(r), t), x) pdv(x, t) + pdv(phi(va(r), t), x) pdv(x, t) + pdv(phi(va(r), t), z) pdv(z, t) + pdv(phi(va(r), t), t) \
  &= va(v)dot grad phi + pdv(phi, t).
$ <eq:scalar-convective-derivative>
Considering instead a time-varying vector field $va(A)(va(r), t)$, we have
$
  pdv(, t) va(A)(va(r)(t), t) = (va(v) dot grad) va(A) + pdv(va(A), t).
$ <eq:scalar-convective-derivative>
