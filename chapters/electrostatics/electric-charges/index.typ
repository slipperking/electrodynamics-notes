
#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Electric Charges],
  route: "electric-charges",
)
Electric phenomena rise arise from a property known as _electric charge_. Charged objects are observed to exert forces on each other, which comprise attractive and repulsive forces. This motivated the formulation of a charge, denoted by $q in RR$. By observation, all free charges are _quantized_, implying all particles observed to have a charge equal to an integer multiple of the elementary electron charge
$ e = #qty("1.602176634e-19", "C") $
Despite this fundamental discreteness of charge, the historical developments of electromagnetic theory utilized the definition of a continuous charge per unit volume, or _volume charge density_ $rho(va(r))$ (here we omit the modern formulation of particles of fractional charge). In an infinitesimal volume $dif V$, the charge contained therein is thence $dif Q = rho(va(r)) dif V$. Then the total charge $Q$ in a volume $V$ is given by
$
  Q = integral.triple_V rho(va(r)) dif V.
$
Oftentimes it is convenient to consider charge distributions on surfaces. In this case we entertain the definition of a charge per unit area (in the surface), or _surface charge density_ $sigma(va(r))$. Therefore, the charge contained in an infinitesimal surface element $dif S$ is $sigma(va(r)) dif S$ and the total charge in the surface is given by
$
  Q = integral.double_S sigma(va(r)) dif S.
$
When a charge is distributed in a one dimensional filament, the notion of a _linear charge density_ $lambda(va(r))$ exists, in which case
$
  Q = integral_C lambda(va(r)) dif s.
$
In many hypothetical discussions, it is of greater simplicity to consider charges concentrated at singular points, known as _point charges_. The charge density of $n$ point charges $q_1,...,q_1$ at $va(r)_1,...,va(r)_n$ respectively is then given by
$
  rho(va(r)) = sum_(k = 1)^n q_k delta(va(r) - va(r)_k).
$
The utilization of the Dirac $delta$ here is natural, as we have
$
  Q = integral.triple_V sum_(k = 1)^n q_k delta(va(r) - va(r)_k) dif V = sum_(k=1)^n q_k.
$
