#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Quadrupole Force and Torque"),
)
#let ef = $va(E)_"ext"$
We may replicate the method employed in @sec:dipole-force-and-torque in determination of the dipole force and torque. One can directly verify this in considering a localized $rho$ where
$ integral.triple rho (va(r)') dif^3 r' = 0, wide integral.triple rho(va(r)') va(r)' dif^3 r' = 0, $
in an electric field #ef approximable by up to quadratic terms at large distances. Thus,
$
  va(F)_"ext" & = integral.triple_(s' < R) rho(va(r)') ef(va(r)') dif^3 r' \
  &= integral.triple_(s' < R) rho(va(r)') [ef(va(r)) + (va(xi) dot grad) ef(va(r)) + 1 / 2 va(xi)^(times.o 2) : grad^(times.o 2) ef(va(r))] dif^3 r' \
  &= ef(va(r)) integral.triple_(s' < R) rho(va(r)') dif^3 r' + integral.triple_(s' < R) rho(va(r)') (va(s)' - va(s)) dif^3 r' dot grad times.o ef(va(r)) \
  &wide""+ 1 / 2 integral.triple rho(va(r)') (va(s)' - va(s))^(times.o 2) dif^3 r' : grad^(times.o 2) ef(va(r)) \
  &= ef(va(r)) Q + (va(p) - va(s) Q) dot grad times.o ef(va(r)) \
  &quad""+ [vaa(Q) + 1/2 (Q va(s)^(times.o 2) - va(p) times.o va(s) - va(s) times.o va(p))] : grad^(times.o 2) ef(va(r)) \
  &= vaa(Q) : grad^(times.o 2) ef(va(r)).
$
and where $va(N)$ is about $va(r)_0$,
$
  va(N) & = integral.triple va(s)' times rho(va(r)') ef(va(r)') dif^3 r' \
  & = va(s) times integral.triple rho(va(r)') ef(va(r)') dif^3 r' + integral.triple va(xi) times rho(va(r)') ef(va(r)') dif^3 r' \
  & = va(s) times va(F)_"ext" + integral.triple (va(s)' - va(s)) rho(va(r)') dif^3 r' times ef(va(r)) \
  &quad + integral.triple va(s)' rho(va(r)') times (va(s)' dot grad) ef(va(r)) dif^3 r' + integral.triple va(s) rho(va(r)') times (va(s) dot grad) ef(va(r)) dif^3 r' \
  &wide - integral.triple va(s)' rho(va(r)') times (va(s) dot grad) ef(va(r)) dif^3 r' - integral.triple va(s) rho(va(r)') times (va(s)' dot grad) ef(va(r)) dif^3 r' \
  &wide quad"" + 1/2 integral.triple va(xi) rho(va(r)') times (va(xi)^(times.o 2) : grad^(times.o 2))ef(va(r)) dif^3 r' \
  &= va(s) times va(F)_"ext" + (va(p) - va(s) Q) times ef(va(r)) \
  &quad""+ epsilon_(i j k) vu(e)_i integral.triple rho s'_j s'_l partial_l E_("ext", k) dif^3 r' + va(s) Q times (va(s) dot grad) ef(va(r)) - va(p) times (va(s) dot grad) ef(va(r)) - va(s) times (va(p) dot grad) ef(va(r)) + Order(xi^3) \
  &= va(s) times va(F)_"ext" + 2 epsilon_(i j k) vu(e)_i Q_(j l) partial_l E_("ext", k) + Order(xi^3) \
  &= va(s) times va(F)_"ext" + 2 epsilon_(i j k) vu(e)_i (vu(e)_j dot vaa(Q)) dot grad E_("ext", k) + Order(xi^3) \
  &= va(s) times va(F)_"ext" + 2 vu(e)_j [(vu(e)_j dot vaa(Q)) dot grad] times ef(va(r)) + Order(xi^3) \
  &= va(s) times va(F)_"ext" + 2 vaa(I) dot (vaa(Q) dot grad) times ef(va(r)) + Order(xi^3) \
  &= va(s) times va(F)_"ext" + 2 (vaa(Q) dot grad) times ef(va(r)) + Order(xi^3)
$
