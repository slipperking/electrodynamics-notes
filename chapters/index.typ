#import "/lib.typ": *
#set heading(numbering: none)
#route-prefix.update(())
#route-folders.update(())
#thm-counter.thm-counters.update((:))
#thm-state.thm-stored.update(())
#context {
  let render-mode = render-mode.get()
  typst-stored-figures.update(stored-figures => {
    stored-figures.insert(render-mode, ())
    stored-figures
  })
}

#include "cover.typ"
#set heading(numbering: "1.1")
#counter(heading).update(0)



// #include "test/index.typ"

#context if render-mode.get() == "pdf" {
  pagebreak()
}

#set heading(numbering: "A.1")
#counter(heading).update(0)
#route-prefix.update(("appendices",))
#include "appendices/index.typ"

#docs-backmatter(title: [Bibliography], route: "bibliography")[
  #context bibliography("/references.bib", full: true, group: state("render-mode").get())
]
