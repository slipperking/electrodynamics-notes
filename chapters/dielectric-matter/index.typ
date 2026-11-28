#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Dielectric Matter"),
  children: {
    include "polarization/index.typ"
    include "fields-produced-by-polarized-matter/index.typ"
  },
)
A _dielectric_ (or _insulator_) describes a medium which does not completely screen an external macroscopic electric field $va(E)_"ext"$ from its interior.

A dielectric---similar to the conducting case---subject to the influence of such an external field, will rearrange its charge distribution in such a way that a field $va(E)_"self"$ is produced, but insofar as
$
  va(E)_"tot" = va(E)_"ext" + va(E)_"self" = 0.
$ <eq:dielectric-total-field-decomposition>
The chemical bonding effects give rise to local maxima and minima in the potential landscape that inhibit the electron wavefunctions from propagating.
