#let title = "Notes on Electrodynamics"
#let authors = ("Slipper King",)
#let date = "October 21, 2026"
#let source-url = "https://github.com/slipperking/electrodynamics-notes"
#let abstract = [
  // #lorem(40)

  To the avower of the impertinence and presumptuosity of my selections, the saint, even in the course of my amelioration.
]

#let web-view-recommendation = [
  For the best web viewing experience, we recommend using a Mozilla-based browser such as Firefox. This will be subject to change as browsers improve their MathML support. (For instance, displayed overlines will not stretch)
]

#let join-oxford-commas(v) = {
  if v.len() < 2 { v.at(0, default: "") } else if v.len() == 2 { v.join(" and ") } else {
    v.slice(0, -1).join(", ") + ", and " + v.last()
  }
}

#let web-cover(href, show-pdf: true) = {
  html.elem("section", attrs: (class: "cover"), {
    html.elem("h1", title)
    html.elem("p", attrs: (class: "authors"), [by #join-oxford-commas(authors.map(smallcaps))])
    html.elem("p", attrs: (class: "date"), date)
    html.elem("div", attrs: (class: "abstract"), abstract)
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
    title: title,
    author: join-oxford-commas(authors),
  )
  #set page(background: rotate(30deg, {
    let f(n) = {
      if n <= 1 {
        $#box($script(integral)$)$
      } else {
        let prev = f(n - 1)
        $#prev _(#prev)^(#prev)$
      }
    }

    text(fill: black.transparentize(70%))[$#f(8)$]
  }))
  #align(center)[
    #v(2cm)
    #text(size: 24pt, weight: "bold")[#title]

    #text(size: 13pt)[#join-oxford-commas(authors.map(smallcaps))]

    #text(size: 11pt)[#date]

    #raw("Source: " + source-url)
  ]

  #block(inset: 10pt)[#abstract]
  #outline(target: outline-target)
  #set page(background: none)
]
