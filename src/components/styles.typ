#import "packages.typ": *
#import "math.typ": *
#import "theorems.typ": *
#import "references.typ": *
#import "layout-limiter.typ": layout-limiter
#import "../source.typ": *

#let equation-revoke = <typst-equation-revoke>
#let text-font-mode = sys.inputs.at("text-font", default: "web")
#assert(
  text-font-mode in ("book", "web"),
  message: "text-font must be either 'book' or 'web'",
)

#let pdf-page-margin = (
  top: 2.5cm,
  bottom: 2.5cm,
  inside: 3cm,
  outside: 2.5cm,
)

#let pdf-heading-prefix(level, numbering-pattern, number) = {
  if number == none {
    none
  } else if level == 1 {
    if type(numbering-pattern) == str and numbering-pattern.starts-with("A") {
      [Appendix #number]
    } else {
      [Chapter #number]
    }
  } else {
    [#sym.section#number]
  }
}

#let pdf-heading-label(label, body) = [
  #label#(sym.space.en)·#(sym.space.en)#body
]

// Adapted from Jassiel Ovando's MIT-licensed fake-smallcaps experiment:
// https://github.com/jassielof/typst-packages/tree/main/fake-smallcaps
#let _pdf-fake-smallcaps(body, scaling: 0.75, stroke: 0.005cm) = context {
  show regex("\p{Ll}+"): it => text(
    size: scaling * 1em,
    stroke: stroke + text.fill,
    upper(it),
  )
  text(body)
}

#let _pdf-running-header() = context {
  let page-number = counter(page).get().first()
  let level-one-headings = selector(heading.where(level: 1)).within(pdf-scope-label)
  let level-two-headings = selector(heading.where(level: 2)).within(pdf-scope-label)
  let numbered-chapters = query(level-one-headings).filter(
    it => it.numbering != none,
  )
  let chapters = query(level-one-headings).filter(
    it => it.location().page() <= page-number,
  )

  let is-frontmatter = (
    numbered-chapters.len() == 0 or page-number < numbered-chapters.first().location().page()
  )

  if not is-frontmatter and chapters.len() > 0 {
    let chapter = chapters.last()
    let sections = query(level-two-headings).filter(
      it => (
        it.location().page() >= chapter.location().page() and it.location().page() <= page-number
      ),
    )
    let selected = if chapter.location().page() == page-number {
      chapter
    } else if calc.odd(page-number) and sections.len() > 0 {
      sections.last()
    } else {
      chapter
    }
    let number = if selected.numbering == none {
      none
    } else {
      numbering(selected.numbering, ..counter(heading).at(selected.location()))
    }
    let title = smallcaps(selected.body)
    let heading-line = if number == none {
      title
    } else {
      let label = pdf-heading-prefix(selected.level, selected.numbering, number)
      pdf-heading-label(label, title)
    }

    block(width: 100%)[
      #align(if calc.odd(page-number) { right } else { left })[
        #text(size: 0.78em)[#heading-line]
      ]
      #v(-0.18em)
      #line(length: 100%, stroke: (paint: black, thickness: 0.45pt))
    ]
  }
}

#let _pdf-heading(it) = context {
  let number = if it.numbering == none {
    none
  } else {
    counter(heading).display(it.numbering)
  }

  let rendered = if it.level == 1 {
    let eyebrow = pdf-heading-prefix(it.level, it.numbering, number)
    block(breakable: false)[
      #v(0.78in)
      #text(size: 1.8em, weight: "bold")[
        #if eyebrow != none {
          eyebrow
          linebreak()
        }
        #it.body
      ]
      #v(0.42in)
    ]
  } else if it.level == 2 {
    block(breakable: false)[
      #v(1.5em)
      #text(size: 1.4em, weight: "bold")[
        #if number != none [#sym.section#number#h(0.55em)]#it.body
      ]
      #v(0.8em)
    ]
  } else {
    block(breakable: false)[
      #v(1em)
      #text(size: 1.2em, weight: "bold")[
        #if number != none [#sym.section#number#h(0.55em)]#it.body
      ]
      #v(0.5em)
    ]
  }

  [#rendered#heading-reset-marker(it.level)]
}

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

  show heading: it => if mode == "pdf" {
    _pdf-heading(it)
  } else {
    [#it#heading-reset-marker(it.level)]
  }
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
    show smallcaps: it => _pdf-fake-smallcaps(it.body)
    set text(font: "Lato") if text-font-mode == "web"
    show math.equation: set text(font: "Lete Sans Math") if text-font-mode == "web"
    set page(
      paper: "a4",
      numbering: "1",
      number-align: center,
      header: _pdf-running-header(),
      margin: pdf-page-margin,
    )

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
          // math.op("\u{203E}")
          $class("diacritic", stretch(\u{00AF}))$
        })
      } else {
        it
      }
    }
    doc
  }
}
