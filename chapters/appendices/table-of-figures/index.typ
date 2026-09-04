#import "/lib.typ": *
#import "/src/components/styles.typ": paged-link-with-html-indicator

#show: docs-appendix.with(
  title: "Table of Figures",
  route: "table-of-figures",
)

#let figure-entry-paged(web-fig, pdf-fig) = [
  #link(
    pdf-fig.location(),
    {
      if pdf-fig.has("label") {
        strong(ref(pdf-fig.label))
      }
      [: #pdf-fig.caption.body]
      sym.wj
      sym.space.nobreak
      (
        {
          box(width: 0pt)
          box(width: 1fr, repeat[.])
        }
          * 2
      )
      sym.wj
      sym.space.nobreak
      paged-link-with-html-indicator(
        link(
          pdf-fig.location(),
          [#pdf-fig.location().page()],
        ),
        web-fig.location(),
      )
    },
  )\
]

#let figure-link-options(web-fig, pdf-fig) = {
  let pdf-fig = if pdf-fig == none { web-fig } else { pdf-fig }
  html.elem("math", attrs: (class: "typst-multi-label-list"), {
    link(pdf-fig.location(), [PDF])
    link(web-fig.location(), [HTML])
  })
}

#let figure-entry-web(web-fig, pdf-fig) = {
  let pdf-link-loc = if pdf-fig == none { web-fig.location() } else { pdf-fig.location() }
  let pdf-page = if pdf-fig == none { [?] } else { pdf-fig.location().page() }

  html.elem("p", attrs: (class: "reference-list-entry"), {
    html.elem("span", attrs: (class: "reference-list-title"), {
      html.elem("span", attrs: (class: "reference-list-figure-label"), {
        if web-fig.has("label") {
          ref(web-fig.label)
        }
        figure-link-options(web-fig, pdf-fig)
      })
      html.elem("span", attrs: (class: "reference-list-caption"), [:  #web-fig.caption.body])
      html.elem("span", attrs: (class: "reference-list-end"), [])
    })
    html.elem("span", attrs: (class: "reference-list-dots"), [])
    link(pdf-link-loc, html.elem("span", attrs: (class: "reference-list-page"), [#pdf-page]))
    figure-link-options(web-fig, pdf-fig)
  })
}

#let figure-filter(fig) = fig.kind != "thm-env" and fig.caption != none and fig.has("label")

#context {
  // Querying figures is more reliable than accumulating the contents of
  // figure-wrapper in state: a queried figure retains its label and location.
  let web-figs = query(selector(figure).within(web-doc-label)).filter(figure-filter)
  let pdf-figs = query(selector(figure).within(pdf-doc-label)).filter(figure-filter)

  if render-mode.get() == "web" {
    html.elem("div", attrs: (id: "figure-list", class: "reference-list"), {
      for i in range(web-figs.len()) {
        let web-fig = web-figs.at(i)
        let pdf-fig = pdf-figs.at(i, default: none)
        figure-entry-web(web-fig, pdf-fig)
      }
    })
  } else {
    for i in range(pdf-figs.len()) {
      let pdf-fig = pdf-figs.at(i)
      let web-fig = web-figs.at(i, default: pdf-fig)
      figure-entry-paged(web-fig, pdf-fig)
    }
  }
}
