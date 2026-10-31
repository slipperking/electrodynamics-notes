#let gradp = $bold(nabla)'$
#let divp = $bold(nabla)'dot.c$
#let curlp = $bold(nabla)'times$
#let laplacianp = $nabla'^2$

#let grads = math.op(math.bold("grad"))
#let divs = math.op("div")
#let curls = math.op(math.bold("curl"))

#import "@preview/physica:0.9.8": va as _va, vb, vu
#let va(..args) = _va(vb(..args))
#import "@preview/unify:0.8.1": num, qty
#let pv = math.op("P.V.")
