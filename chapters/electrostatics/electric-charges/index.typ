
#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Electric Charges],
  route: "electric-charges",
)
Electric phenomena arise from a property known as _electric charge_. Charged objects are observed to exert forces on each other, which comprise attractive and repulsive forces. This motivated the formulation of a charge, denoted by $q in RR$. By observation, all free charges are _quantized_, implying all particles observed to have a charge equal to an integer multiple of the elementary electron charge
$ e = #qty("1.602176634e-19", "C") $
Despite this fundamental discreteness of charge, the historical developments of electromagnetic theory utilized the definition of a continuous charge per unit volume, or _volume charge density_ $rho(va(r))$ (here we omit the modern formulation of particles of fractional charge). In an infinitesimal volume $dif V$, the charge contained therein is thence $dif Q = rho(va(r)) dif V$. Then the total charge $Q$ in a volume $V$ is given by
$
  Q = integral.triple_V rho(va(r)) dif V.
$ <eq:enclosed-volume-charge>
Oftentimes it is convenient to consider charge distributions on surfaces. In this case we entertain the definition of a charge per unit area (in the surface), or _surface charge density_ $sigma(va(r))$. Therefore, the charge contained in an infinitesimal surface element $dif S$ is $sigma(va(r)) dif S$ and the total charge in the surface is given by
$
  Q = integral.double_S sigma(va(r)) dif S.
$
It is possible to derive an expression for the volume charge density for a given surface charge density. For this we write
#etarget(<eq:surface-charge-density-as-volume>)[$
  rho(va(r)) = integral.double_S sigma(va(r)') delta^3(va(r) - va(r)') dif S', #tag[#math-markup(link-wrap: true)[(#sym.ast.op)]]
$]
which can be interpreted, by virtue of some generalized heuristic "filtering property," to yield a product between a $sigma$ value and some one-dimensional variant of the Dirac delta.
#let surf-vol = math-markup(link-wrap: true)[#eref(<eq:surface-charge-density-as-volume>)[(#sym.ast.op)]]
#proof(collapsed: true)[of #surf-vol][
  The essence of our methodology here is to prove that the hypothesized relationship can be used to derive the equivalence of the expressions of the enclosed charge $Q$.

  Defining $rho$ as in #surf-vol,
  $
    Q_rho & = integral.triple_(RR^3) integral.double_S sigma(va(r)') delta^3(va(r) - va(r)') dif S' dif V \
          & = integral.double_S sigma(va(r)') integral.triple_(RR^3)delta^3(va(r) - va(r)') dif V dif S' \
          & = integral.double_S sigma(va(r)') dif S' = Q_sigma. qedhere
  $
]
When a charge is distributed in a one dimensional filament, the notion of a _linear charge density_ $lambda(va(r))$ exists, in which case
$
  Q = integral_C lambda(va(r)) dif s.
$
Similar to the above, we have
$
  rho(va(r)) = integral_C lambda(va(r)') delta^3(va(r) - va(r)') dif s.
$
#proof(collapsed: true)[of the line-volume charge density relationship][
  Let $Q_rho$ be the enclosed charge as calculated in @eq:enclosed-volume-charge and let $Q_lambda$ be the enclosed charge as calculated by the line integral. Then
  $
    Q_rho & = integral.triple_(RR^3) integral_C lambda(va(r)') delta^3(va(r) - va(r)') dif s' dif V \
          & = integral_C lambda(va(r)') integral.triple_(RR^3) delta^3(va(r) - va(r)') dif V dif s' \
          & = integral_C lambda(va(r)') dif s = Q_lambda. qedhere
  $
]
In many hypothetical discussions, it is of greater simplicity to consider charges concentrated at singular points, known as _point charges_. The charge density of $n$ point charges $q_1,...,q_n$ at $va(r)_1,...,va(r)_n$ respectively is then given by
$
  rho(va(r)) = sum_(k = 1)^n q_k delta(va(r) - va(r)_k).
$ <eq:electric-point-charges-charge-density>
The utilization of the Dirac $delta$ here follows naturally, as we have
$
  Q = integral.triple_V sum_(k = 1)^n q_k delta(va(r) - va(r)_k) dif V = sum_(k=1)^n q_k.
$
