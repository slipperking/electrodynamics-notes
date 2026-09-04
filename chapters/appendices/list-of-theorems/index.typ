#import "/lib.typ": *
#import "/src/components/web.typ": theorem-heading
#import "/src/components/styles.typ": paged-link-with-html-indicator

#show: docs-appendix.with(
  title: "List of Theorems",
  route: "list-of-theorems",
)

#let theorem-entry-paged(web-thm, pdf-thm) = [
  #link(
    pdf-thm.loc,
    {
      theorem-heading(pdf-thm)
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
          pdf-thm.loc,
          [#pdf-thm.loc.page()],
        ),
        web-thm.loc,
      )
    },
  )\
]

#let theorem-entry-web(web-thm, pdf-thm) = {
  let pdf-link-loc = if pdf-thm == none { web-thm.loc } else { pdf-thm.loc }
  let pdf-page = if pdf-thm == none { [?] } else { pdf-thm.loc.page() }

  html.elem("p", attrs: (class: "reference-list-entry"), {
    link(web-thm.loc, html.elem("span", attrs: (class: "reference-list-title"), {
      theorem-heading(web-thm)
      html.elem("span", attrs: (class: "reference-list-end"), [])
    }))
    html.elem("span", attrs: (class: "reference-list-dots"), [])
    link(pdf-link-loc, html.elem("span", attrs: (class: "reference-list-page"), [#pdf-page]))
  })
}

#let theorem-filter(thm) = {
  thm.supplement != "Proof" and thm.supplement != "Solution" and thm.supplement != "Remark"
}

#context {
  let web-thms = query(selector(<meta:thm-env-counter>).within(web-doc-label))
    .map(marker => marker.value)
    .filter(theorem-filter)
  let pdf-thms = query(selector(<meta:thm-env-counter>).within(pdf-doc-label))
    .map(marker => marker.value)
    .filter(theorem-filter)

  if render-mode.get() == "web" {
    html.elem("div", attrs: (id: "reference-list", class: "reference-list"), {
      for i in range(web-thms.len()) {
        let web-thm = web-thms.at(i)
        let pdf-thm = pdf-thms.at(i, default: none)
        theorem-entry-web(web-thm, pdf-thm)
      }
    })
  } else {
    for i in range(web-thms.len()) {
      let web-thm = web-thms.at(i)
      let pdf-thm = pdf-thms.at(i, default: none)
      theorem-entry-paged(web-thm, pdf-thm)
    }
  }
}
