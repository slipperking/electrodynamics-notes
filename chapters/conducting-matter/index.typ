#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Conducting Matter"),
  children: include "electrostatic-induction/index.typ",
)

A _perfect conductor_ describes the macroscopic model for real conducting matter wherein the enclosed charge and electric field within the interior volume $V$ vanish:
$
  va(E)(va(r)) = 0 = rho(va(r)) wide forall va(r) in V,
$ <eq:electric-conductor-vanish-criteria>
giving implication to the fact that all excess charge must accumulate on the boundary surface, macroscopically given by a surface charge distribution $sigma(va(r)_S)$.

A natural example hereof is a conducting sphere with a total charge $Q$ and radius $R$. In the absence of external electric fields, the Spherical Shell Theorem (@thm:spherical-shell) implies $sigma = Q / (4 uppi R^2)$ and the adherence to @eq:electric-conductor-vanish-criteria.
