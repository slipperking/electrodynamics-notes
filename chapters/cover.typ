#import "/src/components/index.typ": docs-cover
#import "/src/source.typ" as source

#let dedication = [
  To the avower of the impertinence and presumptuosity of my selections, the saint, even in the course of my amelioration.
]

#let web-view-recommendation = [
  For the best web viewing experience, we recommend using a Mozilla-based browser such as Firefox. This will be subject to change as browsers improve their MathML support. (For instance, displayed overlines will not stretch)
]

#let faux-smallcaps(value, size: 1em, weight: "regular") = {
  for glyph in value.clusters() {
    if glyph == " " {
      h(0.3em)
    } else {
      let is-lowercase = glyph == lower(glyph) and glyph != upper(glyph)
      box(text(
        size: if is-lowercase { size * 0.72 } else { size },
        weight: weight,
      )[#upper(glyph)])
      h(0.015em)
    }
  }
}

#let web-cover(href, show-pdf: true) = {
  html.elem("section", attrs: (class: "cover"), {
    html.elem("h1", source.title)
    html.elem(
      "p",
      attrs: (class: "authors"),
      [by #source.join-oxford-commas(source.authors.map(smallcaps))],
    )
    html.elem("p", attrs: (class: "date"), source.date)
    html.elem("div", attrs: (class: "abstract"), dedication)
    html.elem("div", attrs: (class: "recommendation"), web-view-recommendation)
    if show-pdf {
      html.elem("p", attrs: (class: "download"), {
        html.elem("a", attrs: (class: "button", href: href("pdf/notes.pdf")), [View PDF])
      })
    }
  })
}

#let pdf-cover(outline-target: heading) = [
  #set document(
    title: source.title,
    author: source.join-oxford-commas(source.authors),
  )
  #set page(
    numbering: none,
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      inside: 3cm,
      outside: 2.5cm,
    ),
    background: none,
  )
  #set align(center)

  #v(1.5fr)
  #faux-smallcaps(source.title, size: 3em, weight: "bold")

  #v(0.8fr)
  #text(size: 1.2em)[by #source.join-oxford-commas(source.authors.map(smallcaps))]

  #v(1.2fr)
  #block(width: 72%)[
    #set par(justify: false, leading: 0.75em)
    #text(size: 0.9em, style: "italic")[#dedication]
  ]

  #v(1fr)
  #text(size: 0.85em)[#source.date]
  #v(1.5fr)

  #pagebreak()
  #set page(
    numbering: "1",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      inside: 3cm,
      outside: 2.5cm,
    ),
    background: none,
  )
  #set align(left)
  #show outline.entry.where(level: 1): set block(above: 0.65em)
  #show outline.entry.where(level: 1): set text(weight: "bold")
  #show outline.entry: it => context {
    let item = it.element
    let number = if item.numbering == none {
      none
    } else {
      numbering(item.numbering, ..counter(heading).at(item.location()))
    }
    let appendix = (
      type(item.numbering) == str and item.numbering.starts-with("A")
    )
    let prefix = if number == none {
      none
    } else if item.level == 1 {
      if appendix {
        [Appendix #number#h(0.35em)·]
      } else {
        [Chapter #number#h(0.35em)·]
      }
    } else {
      [#sym.section#number#h(0.35em)·]
    }

    link(
      item.location(),
      it.indented(prefix, it.inner(), gap: 0.35em),
    )
  }
  #outline(title: [Contents], target: outline-target, indent: 1.2em)
  #pagebreak()
]

#docs-cover(
  title: "Home",
  route: none,
  web-cover: web-cover,
  pdf-cover: pdf-cover,
)[]
