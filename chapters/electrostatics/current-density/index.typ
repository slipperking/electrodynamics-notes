#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Current and Current Density],
  route: "current-density",
)
The collective motion of electric charge in a time-static volume $V$ is known as _(volume) electric current_, whose properties and behavior are described by the _current density vector_ $va(J)(va(r), t)$ and its flux $I$ through a given bounded surface $S$, referred to as the _total electric current_. If the description of charges and their motion is to be modeled in analogy with fluid flow, then the current density corresponds to the volume flux density.
#definition[
  Define the _electric current density_ to be the rate at which electric charge passes through a unit area of a surface in the direction of charge motion. In other words, $va(J) dot dif va(S)$ is the amount of charge passing through the differential surface element per unit time.
]
For a given velocity field $va(v)(va(r), t)$ characterizing the motion of charges, the (volume) electric current density is also equal to
$
  va(J)(va(r), t) = rho(va(r), t) va(v)(va(r), t).
$
The surface current density is analogously
$
  va(K)(va(r),t) = sigma(va(r), t) va(v)(va(r),t).
$
The total volume current is then
$ I = integral.surf_(partial V) va(J) dot dif va(S), $
and in the case of the total surface current, the outward pointing vector normal to $partial S$ whilst lying in the plane of $S$ is given by $dif va(r) times vu(n)$, (where $vu(n)$ is normal to $S$). Then
$
  I = integral.cont_(partial S) va(K) dot (dif va(r) times vu(n)) = integral.cont_(partial S) (vu(n) times va(K)) dot dif va(r).
$
(The convention of sign dictates whether we consider current flowing out of a region or flowing into one.) Where $Q(t)$ is the amount of charge that has the boundary at time $t$, it follows immediately that
$ I = dv(Q, t) $
by the endowed definition.
