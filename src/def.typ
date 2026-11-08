#import "@preview/physica:0.9.8": grad
#let gradsu(a) = $grad_#a$
#let divsu(a) = $grad_#a dot.c$
#let curlsu(a) = $grad_#a times$
#let laplaciansu(a) = $nabla_#a^2$

#let gradp = $bold(nabla)'$
#let divp = $bold(nabla)'dot.c$
#let curlp = $bold(nabla)'times$
#let laplacianp = $nabla'^2$

#let gradpsu(a) = $gradp_#a$
#let divpsu(a) = $gradp_#a dot.c$
#let curlpsu(a) = $gradp_#a times$
#let laplacianpsu(a) = $nabla'_#a^2$

#let grads = math.op(math.bold("grad"))
#let divs = math.op("div")
#let curls = math.op(math.bold("curl"))

#import "@preview/physica:0.9.8": va as _va, vb, vu
#let va(..args) = _va(vb(..args))
#import "@preview/unify:0.8.1": num, qty
#let pv = math.op("P.V.")

#let vaa(..args) = _va(_va(vb(math.sans(..args))))

#let argmin = math.limits(math.op($"arg" "min"$))
