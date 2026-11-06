#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Electrostatics"),
  children: {
    include "electric-potential/index.typ"
    include "work-and-energy/index.typ"
    include "electric-stress-tensor/index.typ"
  },
)

Maxwell's Equations (reproduced in @thm:gauss-law) in a vacuum give the following conditions for a time-independent charge density distribution $rho(va(r))$:
$
  curl va(E) = 0, wide wide div va(E) = rho / epsilon_0.
$
For two disjoint electric bodies carrying charge distributions $rho_1, rho_2$, the force of the electric field $va(E)_2$ of $rho_2$ upon the charge distribution $rho_1$ is given by
$
  va(F) = integral.triple rho_1 (va(r)) va(E)_2 dif^3 r,
$ <eq:electric-distribution-force>
likewise the torque thereof about $va(r)_0$ assumes the form of
$
  va(N) = integral.triple va(s) times (rho_1 (va(r)) va(E)_2 (va(r))) dif^3 r, wide "where" quad va(s) = va(r) - va(r)_0.
$ <eq:electric-distribution-torque>
We note here that it is sufficient to relax---in both equations---$va(E)_2$ to simply $va(E)$, the electric field due to both charge distributions. This is due to the observation that no distribution may exert force nor torque upon itself. Indeed, observation of the self-force gives that
$
  va(F)_"self" &= integral.triple rho_1 va(E)_1 dif^3 r = 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 (va(r) - va(r)') dif^3 r' dif^3 r \
  &= 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(r) dif^3 r' dif^3 r - (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(r)' dif^3 r' dif^3 r \
  &= 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(r) dif^3 r' dif^3 r - (rho_1 (va(r)') rho_1 (va(r))) / norm(va(r)' - va(r))^3 va(r) dif^3 r dif^3 r' = 0 ,
$ <eq:electric-distribution-force-self-vanish>
and similarly the self-torque satisfies
$
  va(N)_"self" &= integral.triple va(s) times (rho_1 (va(r)) va(E)_1 (va(r))) dif^3 r = 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(s) times (va(r) - va(r)') dif^3 r' dif^3 r \
  &= 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(s) times (va(s) - va(s)') dif^3 r' dif^3 r \
  &= 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(s)' times va(s) dif^3 r' dif^3 r \
  &= 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(s) times va(s)' dif^3 r' dif^3 r wide #[(by switching $r$ and $r'$)] \
  2 va(N)_"self" &=1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(s)' times va(s) dif^3 r' dif^3 r \
  &wide ""+ 1 / (4 uppi epsilon_0) integral.triple integral.triple (rho_1 (va(r)) rho_1 (va(r)')) / norm(va(r) - va(r)')^3 va(s) times va(s)' dif^3 r' dif^3 r = 0.
$ <eq:electric-distribution-torque-self-vanish>

