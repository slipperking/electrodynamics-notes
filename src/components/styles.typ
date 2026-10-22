#import "packages.typ": *
#import "math.typ": *
#import "theorems.typ": *
#import "references.typ": *
#import "layout-limiter.typ": layout-limiter
#import "../source.typ": *

#let equation-revoke = <typst-equation-revoke>

#let document-styles(doc, mode: "pdf", todo: none) = {
  show: layout-limiter.with(max-iterations: 15)
  show ref: it => show-reference(it, mode, todo: todo)
  show math.equation: it => {
    let label = it.fields().at("label", default: none)
    if label != none and label != equation-revoke {
      math.equation(block: true, numbering: scoped-equation-numbering, it)
    } else {
      it
    }
  }

  show: thm-rules.with(qed-symbol: qed-symbol, mode: mode)
  let enum-numbering = (..it) => {
    counter("typst-enum").update(it.pos())
    numbering("1.1.", ..it)
  }

  // adds referenceable enumerations.
  // note that the method used to increment enumerations through the numbering will only work with pdfs, htmls don't call the function. Hence they are separately handled.
  set enum(numbering: enum-numbering, full: true)

  set par(justify: true)

  show heading: it => [#it#heading-reset-marker(it.level)]
  set figure(numbering: (n, ..) => {
    numbering("1.1", counter(heading).get().first(), n)
  })
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }

  if mode == "pdf" {
    set page(numbering: "1", margin: 1.75in)

    set figure(placement: alignment.top)
    show figure.caption: it => context [
      *#it.supplement~#it.counter.display()#it.separator*#it.body
    ]
    doc
  } else if mode == "web" {
    set document(author: authors)

    show math.equation: it => {
      if it.block and it.numbering != none {
        let number = counter(math.equation).display(it.numbering)
        [$ it.body tag(number) $ #equation-revoke]
      } else {
        it
      }
    }

    show enum.where(start: auto): it => context {
      if target() != "html" { return it }

      counter("typst-enum").update(0)

      let items = it
        .children
        .enumerate()
        .map(((i, item)) => {
          let n = if item.number == auto { i + 1 } else { item.number }
          enum.item(item.number, [#counter("typst-enum").update((n,))#item.body])
        })

      set enum(start: 1)
      enum(..items)
    }
    show math.equation.where(block: true): it => context {
      // prevent double wrapping with previous numbering show rule.
      // also, in figures, html will be paged, so no div.
      if (
        it.numbering == none and target() != "paged" and it.fields().at("label", default: none) != equation-revoke
      ) {
        html.elem("div", attrs: (class: "display-math"), it)
      } else { it }
    }
    show figure.where(kind: "thm-env"): it => it.body

    // overline needs a temporary alternative
    show math.overline: it => context {
      if target() != "paged" {
        html.elem("mover", attrs: (accent: "true"), {
          html.elem("mrow", it.body)
          math.op("\u{203E}")
        })
      } else {
        it
      }
    }
    doc
  }
}
