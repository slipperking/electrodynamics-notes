#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Convective Derivative],
  route: "convective-derivative",
)
In the general consideration of time-varying scalar field $phi(va(r), t)$, the change of $phi$ with respect to $t$, as observed by a stationary observer at $va(r)$, is given by $pdv(phi, t)$. Then the natural extension would be to consider the way in which $phi$ would change if the observer position also varied in time, i.e. $va(r)(t) = x(t) vu(x) + y(t) vu(y) + z(t) vu(z)$. The answer thereof is answered with a simple application of the chain rule:
$
  dv(, t) phi(va(r)(t), t) &= pdv(phi(va(r), t), x) pdv(x, t) + pdv(phi(va(r), t), x) pdv(x, t) + pdv(phi(va(r), t), z) pdv(z, t) + pdv(phi(va(r), t), t) \
  &= va(v)dot grad phi + pdv(phi, t).
$ <eq:scalar-convective-derivative>
Considering in lieu thereof a time-varying vector field $va(A)(va(r), t)$, we have
$
  dv(, t) va(A)(va(r)(t), t) = (va(v) dot grad) va(A) + pdv(va(A), t).
$ <eq:scalar-convective-derivative>
The representations above, distinctly denoted by $dv(, t)$, are known as the _convective derivative_ or the _total derivative_.
