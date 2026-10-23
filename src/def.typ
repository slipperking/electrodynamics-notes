#let gradp = $bold(nabla)'$
#let divp = $bold(nabla)'dot.c$
#let curlp = $bold(nabla)'times$
#let laplacianp = $nabla'^2$

#import "@preview/physica:0.9.8": va as _va, vb, vu
#let va(..args) = _va(vb(..args))
