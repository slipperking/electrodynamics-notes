#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Conservation of Charge],
  route: "conservation-of-charge",
)
The current stance and knowledge of physicists collectively accord to the principle that electric charge is absolutely conserved. Whilst quantum processes are known to create and destroy the elementary particles, the various tests instantiated to demonstrate this property, by observation of electron decay, yield that if such a decay exists, the mean time would exceed $10^24$ years.

Hence, for a time-static volume $V$, the sole perceived way in which the enclosed charge $Q$ may vary with time is if charges move in and out of the region. With $Q_"enc" (t)$ denoting the enclosed charge,
$
  I = -dv(Q_"enc", t),
$
where $I$ is the total surface current through $partial V$. The appendage of a sign represents the fact that a negative change in enclosed entails charges flowing out, giving a positive flux and current. Expressing
$
  I = integral.surf_(partial V) va(J) dot dif va(S) = integral.triple_V div va(J) dif V,
$
we have
$
  integral.triple_V div va(J) dif V = -dv(, t) integral.triple_V rho dif V = -integral.triple_V pdv(rho, t) dif V,\
  integral.triple_V (div va(J) + pdv(rho, t)) dif V = 0.
$ <eq:charge-continuity-equation-triple-integral>
If at any point $va(r)'$ the integrand is nonzero (without loss of generality assume positivity), then on a neighborhood $V_(va(r)')$ thereof,
$
  integral.triple_V_(va(r)') (div va(J) + pdv(rho, t)) dif V > 0,
$
which contradicts the condition set forth by @eq:charge-continuity-equation-triple-integral; the arbitariness of $V$ entails that the equation holds for $V = V_(va(r)')$ as well. Thus,
$
  div va(J) + pdv(rho, t) = 0,
$
known as the _continuity equation_.
