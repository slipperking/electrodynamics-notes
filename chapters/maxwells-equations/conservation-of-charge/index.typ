#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Conservation of Charge],
  route: "conservation-of-charge",
)
The current stance and knowledge of physicists collectively accord to the principle that electric charge is absolutely conserved. Whilst quantum processes are known to create and destroy the elementary particles, the various tests instantiated to demonstrate this property, by observation of electron decay, yield that if such a decay exists, the mean time would exceed $10^24$ years.

Hence, for a time-static volume $V$, the sole perceived way wherein the enclosed charge $Q$ may vary with time is if charges move in and out of the region. With $Q_"enc" (t)$ denoting the enclosed charge,
$
  I = -dv(Q_"enc", t),
$
where $I$ is the total surface current through $partial V$. The appendage of a sign represents the fact that a negative change in enclosed entails charges flowing out, giving a positive flux and current. Expressing
$
  I = integral.surf_(partial V) va(J) dot dif va(S) = integral.triple_V div va(J) dif^3 r,
$
we have
$
  integral.triple_V div va(J) dif^3 r = -dv(, t) integral.triple_V rho dif^3 r = -integral.triple_V pdv(rho, t) dif^3 r,\
  integral.triple_V (div va(J) + pdv(rho, t)) dif^3 r = 0.
$ <eq:charge-continuity-equation-triple-integral>
If at any point $va(r)'$ the integrand is nonzero (without loss of generality assume positivity), then on a neighborhood $V_(va(r)')$ thereof,
$
  integral.triple_V_(va(r)') (div va(J) + pdv(rho, t)) dif^3 r > 0,
$
which contradicts the condition set forth by @eq:charge-continuity-equation-triple-integral; the arbitariness of $V$ entails that the equation holds for $V = V_(va(r)')$ as well. Thus,
$
  div va(J) + pdv(rho, t) = 0,
$
known as the _continuity equation_.

Our proof above implicitly utilized a weak assumption of continuity of the integrand. Therefore, in the following example we demonstrate its continued validity for the case of point charges:
#example[
  Let $n$ point charges $q_k$ ($1 <= k <= n$) follow trajectories $va(r)_k (t)$. Then the time-varying charge density is simply a time-dependent generalization of @eq:electric-point-charges-charge-density:
  $ rho(va(r), t) = sum_(k = 1)^n q_k delta(va(r) - va(r)_k (t)). $
  By the chain rule,
  $
    pdv(rho, t) &= sum_(k = 1)^n q_k pdv(, t) delta(va(r) - va(r)_k (t)) = sum_(k = 1)^n q_k grad_(va(r)_k) delta(va(r) - va(r)_k) dot va(v)_k \
    & = -sum_(k = 1)^n q_k grad_(va(r)) delta(va(r) - va(r)_k) dot va(v)_k \
    & = -div sum_(k = 1)^n q_k delta(va(r) - va(r)_k) va(v)_k + sum_(k = 1)^n q_k delta(va(r) - va(r)_k) div va(v)_k \
    & = -div sum_(k = 1)^n q_k delta(va(r) - va(r)_k) va(v)_k
  $ <eq:continuity-equation-point-charges>
  (since the charge velocities are functions of $t$ only). The current density of any charge distribution is given by
  $
    va(J)(va(r)) = rho(va(r)) va(v)(va(r)) = sum_(k = 1)^n q_k delta(va(r) - va(r)_k (t)) va(v)(va(r)) = sum_(k = 1)^n q_k delta(va(r) - va(r)_k (t)) va(v)_k/* _k */,
  $
  where the last equality is obtained from the fact that for all $va(r)$ not coinciding with the point charges, $sum delta = 0$; and for $va(r)$ coinciding with point charges, $va(v)(va(r)) = va(v)_k$. Therefore, @eq:continuity-equation-point-charges is equivalent to
  $
    pdv(rho, t) = sum_(k = 1)^n q_k pdv(, t) delta(va(r) - va(r)_k (t)) = -div sum_(k = 1)^n q_k delta(va(r) - va(r)_k) va(v)_k = -div va(J)(va(r)),
  $
  which is consistent with the continuity equation.
]
