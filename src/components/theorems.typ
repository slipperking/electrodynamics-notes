#import "ctheorems/lib.typ": *

#let _is-web-render() = state("render-mode").get() == "web"
#let qed-symbol = $square$

#let _plain-text(value) = {
  if value == none { "" } else if type(value) == str { value } else if (
    type(value) == int or type(value) == float or type(value) == decimal
  ) { str(value) } else if type(value) == content {
    let fields = value.fields()
    if fields.keys().contains("text") { fields.text } else if fields.keys().contains("children") {
      fields.children.map(_plain-text).join("")
    } else if fields.keys().contains("body") { _plain-text(fields.body) } else if fields.keys().contains("child") {
      _plain-text(fields.child)
    } else if value.func() == [ ].func() { " " } else { "" }
  } else { str(value) }
}

#let _slug(value) = lower(_plain-text(value)).replace(" ", "-").replace(".", "-").replace("(", "").replace(")", "")

#let _html-thm-fmt(head, css-class, numbered: true) = thm => {
  let title = if numbered and thm.number != none { [#head #thm.number] } else { [#head] }
  title = (thm.title-fmt)(title)
  let id = if numbered and thm.number != none { "thm-" + _slug(head) + "-" + _slug(thm.number) } else { none }
  let attrs = (class: "thm-box " + css-class)
  if id != none { attrs.insert("id", id) }

  html.elem("div", attrs: attrs, {
    html.elem("p", attrs: (class: "thm-head"), {
      title
      if thm.name != none [ #(thm.name-fmt)(thm.name)]
      [.]
    })
    thm.body
  })
}

#let _html-proof-like-fmt(head, css-class, collapsible: false, expanded: false) = thm => {
  let title = (thm.title-fmt)([#head])
  if thm.name != none { title += [ #(thm.name-fmt)(thm.name)] }
  if collapsible {
    let classes = if css-class == "thm-proof" { "thm-proof" } else { "thm-proof " + css-class }
    let attrs = (class: classes)
    if expanded { attrs.insert("open", "") }
    html.elem("details", attrs: attrs, {
      html.elem("summary", attrs: (class: "proof-head solution-head"), [#title.])
      proof-body-fmt(thm.body)
    })
  } else {
    html.elem("div", attrs: (class: "thm-proof"), {
      html.elem("p", attrs: (class: "proof-head"), [#title.])
      proof-body-fmt(thm.body)
    })
  }
}

#let _thm-name-fmt = x => smallcaps[(#x)]
#let _definition-name-fmt = x => [(#x)]
#let _remark-name-fmt = name => emph([(#name)])

#let thm-fmt = thm-fmt-block.with(
  body-fmt: emph,
  separator: [*.* ],
)

#let thm-def-fmt = thm-fmt-block.with(
  body-fmt: x => x,
  separator: [*.* ],
)

#let thm-rem-fmt = thm-fmt-block.with(
  body-fmt: x => x,
  separator: [. ],
)

#let proof-pdf-fmt = thm-fmt-block.with(
  body-fmt: proof-body-fmt,
  separator: [. ],
)

#let _wrap(
  head,
  css-class,
  pdf-fmt,
  title-fmt,
  name-fmt,
  numbered: true,
  ..opts,
) = {
  thm.with(
    supplement: head,
    ..opts,
    title-fmt: title-fmt,
    name-fmt: name-fmt,
    fmt: thm => context {
      if _is-web-render() {
        _html-thm-fmt(head, css-class, numbered: numbered)(thm)
      } else {
        pdf-fmt(thm)
      }
    },
  )
}

#let _wrap-proof(head, css-class, pdf-fmt, title-fmt, name-fmt, collapsible: false, expanded: false) = {
  thm.with(
    supplement: head,
    numbering: none,
    title-fmt: title-fmt,
    name-fmt: name-fmt,
    fmt: thm => context {
      if _is-web-render() {
        _html-proof-like-fmt(head, css-class, collapsible: collapsible, expanded: expanded)(thm)
      } else {
        pdf-fmt(thm)
      }
    },
  )
}

#let theorem = _wrap("Theorem", "thm-theorem", thm-fmt, strong, _thm-name-fmt, counter: "Theorem")
#let proposition = _wrap("Proposition", "thm-proposition", thm-fmt, strong, _thm-name-fmt, counter: "Theorem")
#let lemma = _wrap("Lemma", "thm-lemma", thm-fmt, strong, _thm-name-fmt, counter: "Theorem")
#let conjecture = _wrap("Conjecture", "thm-conjecture", thm-fmt, strong, _thm-name-fmt, counter: "Theorem")
#let corollary = _wrap(
  "Corollary",
  "thm-corollary",
  thm-fmt,
  strong,
  _thm-name-fmt,
  counter: "Sub-Theorem",
  base: "Theorem",
)

#let definition = _wrap("Definition", "thm-definition", thm-def-fmt, strong, _definition-name-fmt, counter: "Theorem")
#let example = _wrap("Example", "thm-example", thm-def-fmt, strong, _definition-name-fmt, counter: "Theorem")
#let problem = _wrap("Problem", "thm-problem", thm-def-fmt, strong, _definition-name-fmt, counter: "Problem")

#let remark = _wrap("Remark", "thm-remark", thm-rem-fmt, emph, _remark-name-fmt, numbered: false, numbering: none)
#let claim = _wrap("Claim", "thm-claim", thm-rem-fmt, emph, _remark-name-fmt, numbered: false, numbering: none)

#let proof = _wrap-proof("Proof", "thm-proof", proof-pdf-fmt, emph, emph, collapsible: true, expanded: true)
#let solution = _wrap-proof("Solution", "thm-solution", proof-pdf-fmt, emph, emph, collapsible: true)

#let theorem-toc-entry(thm) = {
  let head = [#thm.supplement]
  if thm.number != none { head += [ #thm.number] }
  head = (thm.title-fmt)(head)
  if thm.name != none { head += [ #(thm.name-fmt)(thm.name)] }
  head
}
