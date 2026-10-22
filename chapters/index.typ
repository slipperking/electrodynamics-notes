#import "/lib.typ": *
#set heading(numbering: none)
#thm-counter.thm-counters.update((:))

#include "cover.typ"
#set heading(numbering: "1.1")
#counter(heading).update(0)

// #include "test/index.typ"

#include "mathematical-preliminaries/index.typ"
#include "electrostatics/index.typ"

#context if render-mode.get() == "pdf" {
  pagebreak()
}

#set heading(numbering: "A.1")
#counter(heading).update(0)
#route-prefix(("appendices",))[
  #include "appendices/index.typ"

  #docs-backmatter(title: [Bibliography], route: "bibliography")[
    #set bibliography(title: auto)
    #context bibliography("/references.bib", full: true, group: state("render-mode").get())
  ]
]
