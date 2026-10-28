#let title = "Notes on Electrodynamics"
#let authors = ("Slipper King",)
#let date = "October 21, 2026"
#let source-url = "https://github.com/slipperking/electrodynamics-notes"

#let join-oxford-commas(v) = {
  if v.len() < 2 { v.at(0, default: "") } else if v.len() == 2 { v.join(" and ") } else {
    v.slice(0, -1).join(", ") + ", and " + v.last()
  }
}
