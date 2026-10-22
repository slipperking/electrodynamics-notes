#import "styles.typ": document-styles, explicit-label, pdf-scope-label, web-scope-label
#import "theorems.typ": *
#import "/src/source.typ" as source

#let notes-title = source.title
#let authors = source.authors
#let date = source.date
#let source-url = source.source-url
#let abstract = source.abstract

#let render-mode = state("render-mode", "web")
#let html-only = sys.inputs.at("html-only", default: "false") == "true"

#let _route-tag-key = "typst-project-route"

#let _tag-data() = {
  let carrier = bibliography.title
  if carrier != auto and carrier.func() == metadata and type(carrier.value) == dictionary {
    carrier.value
  } else {
    (:)
  }
}

#let _route-context() = {
  let route = _tag-data().at(_route-tag-key, default: (:))
  if type(route) != dictionary {
    route = (:)
  }
  (
    prefix: route.at("prefix", default: ()),
    folders: route.at("folders", default: ()),
  )
}

#let _route-scope(prefix: auto, folders: auto, body) = context {
  let current = _route-context()
  let next = (
    prefix: if prefix == auto { current.prefix } else { prefix },
    folders: if folders == auto { current.folders } else { folders },
  )
  let tags = _tag-data()
  tags.insert(_route-tag-key, next)

  show label("meta:" + _route-tag-key + "-scope"): it => {
    set bibliography(title: metadata(tags))
    it.body
  }
  [#block(body)#label("meta:" + _route-tag-key + "-scope")]
}

/// Apply a route prefix to `body`. Child page folders start at this prefix.
#let route-prefix(prefix, body) = _route-scope(prefix: prefix, folders: (), body)

/// Apply an exact inherited folder path to `body`.
#let route-folders(folders, body) = _route-scope(folders: folders, body)

#let _normalize-route(route) = {
  let value = route
  if not value.starts-with("/") {
    value = "/" + value
  }
  if not value.ends-with("/") {
    value = value + "/"
  }
  value
}

#let _route-segment(route) = {
  if route == none or route == "/" or route == "" {
    none
  } else {
    assert(type(route) == str, message: "route must be a single folder name")
    assert(not route.contains("/"), message: "route must be a single folder name, not a path")
    route
  }
}

#let _section-label(segment) = if segment == none { none } else { label("sec:" + segment) }

#let _route-from-folders(folders) = {
  if folders.len() == 0 {
    "/"
  } else {
    "/" + folders.join("/") + "/"
  }
}

#let _route-id(route) = {
  let route = _normalize-route(route)
  let inner = route.slice(1, route.len() - 1)
  if inner == "" {
    "home"
  } else {
    inner.replace("/", "-")
  }
}

#let _route-path(route) = {
  let route = _normalize-route(route)
  let inner = route.slice(1, route.len() - 1)
  if inner == "" {
    "index.html"
  } else {
    inner + "/index.html"
  }
}
#let _document-path(route) = "/" + _route-path(route)

#let _route-depth(route) = {
  let route = _normalize-route(route)
  let inner = route.slice(1, route.len() - 1)
  if inner == "" {
    0
  } else {
    inner.split("/").filter(part => part != "").len()
  }
}

#let _dirs-for(path) = path.split("/").slice(0, path.split("/").len() - 1).filter(part => part != "")
#let _root-prefix(path) = range(_dirs-for(path).len()).map(_ => "../").join("")
#let _pretty-path(path) = if path == "index.html" {
  "index.html"
} else if path.ends-with("/index.html") {
  path.slice(0, path.len() - "index.html".len())
} else {
  path
}
#let _href-from(current-path, target-path) = _root-prefix(current-path) + _pretty-path(target-path)
#let _asset-href(current-path, asset-path) = _root-prefix(current-path) + asset-path

#let _page-info(
  title: none,
  route: none,
  kind: "section",
  level: 1,
  heading-level: 1,
  heading-format: (number, title) => if number != none { [#number #title] } else { [#title] },
  description: none,
  label: none,
) = {
  assert(title != none, message: "docs page needs a title")
  assert(route != none, message: "docs page needs a route")
  let route = _normalize-route(route)
  (
    id: _route-id(route),
    title: title,
    route: route,
    path: _route-path(route),
    doc-path: _document-path(route),
    kind: kind,
    level: level,
    heading-level: heading-level,
    heading-format: heading-format,
    description: description,
    label: label,
  )
}

#let _heading-number(h) = {
  if h != none and h.numbering != none {
    counter(heading).display(at: h.location())
  } else {
    none
  }
}

#let _site-data() = {
  let carrier = outline.title
  if carrier != auto and carrier.func() == metadata and type(carrier.value) == dictionary {
    carrier.value
  } else {
    (:)
  }
}

#let _page-entry(page) = {
  let entries = _site-data().at("entries", default: (:))
  let entry = entries.at(page.id, default: none)
  if entry != none {
    entry
  } else {
    (
      label: (page.heading-format)(none, page.title),
      depth: calc.max(0, page.heading-level - 1),
      prev: none,
      next: none,
    )
  }
}

#let _page-label(page) = _page-entry(page).label

#let _build-site-data() = {
  let records = query(
    selector(heading).or(<page-meta>).or(<page-nav-meta>).within(web-scope-label),
  )
  let pages = ()
  let nav = (:)
  let last-heading = none

  for record in records {
    if record.func() == heading {
      last-heading = record
    } else if record.value.record == "page" {
      pages.push(record.value.page)
      last-heading = none
    } else if record.value.record == "nav" {
      let page = record.value.page
      let source-heading = if record.value.has-heading { last-heading } else { none }
      let number = _heading-number(source-heading)
      let title = if source-heading != none { source-heading.body } else { page.title }

      nav.insert(page.id, (
        label: (page.heading-format)(number, title),
        depth: if source-heading == none { 0 } else { calc.max(0, source-heading.level - 1) },
      ))
      last-heading = none
    }
  }

  let entries = (:)
  for (index, page) in pages.enumerate() {
    let page-nav = nav.at(page.id, default: none)
    if page-nav == none {
      page-nav = (
        label: (page.heading-format)(none, page.title),
        depth: calc.max(0, page.heading-level - 1),
      )
    }
    entries.insert(page.id, (
      label: page-nav.label,
      depth: page-nav.depth,
      prev: if index > 0 { pages.at(index - 1) } else { none },
      next: if index + 1 < pages.len() { pages.at(index + 1) } else { none },
    ))
  }

  (pages: pages, entries: entries)
}

#let _page-heading(page) = {
  if page.label == none {
    heading(level: page.heading-level, [#page.title])
  } else {
    explicit-label(page.label, heading(level: page.heading-level, [#page.title]))
  }
}

#let _icon(name, path) = html.elem("img", attrs: (class: "icon", src: path, alt: name))

#let _todo-description(body) = if body == none { [] } else { body }

/// Mark an open task. Set `block: false` to keep the callout inline.
#let todo(..args, block: true) = context {
  assert(args.pos().len() <= 1, message: "todo accepts at most one content argument")
  assert(type(block) == bool, message: "todo's block argument must be a boolean")
  let body = args.pos().first(default: none)
  let description = _todo-description(body)
  if render-mode.get() == "web" {
    let tag = if block { "aside" } else { "span" }
    let class = if block { "todo-callout" } else { "todo-callout todo-inline" }
    [
      #metadata((description: description)) <todo-marker>
      #html.elem(tag, attrs: (class: class, role: "note", "aria-label": "Todo"), {
        link(<sec:todo>, html.elem("em", attrs: (class: "proof-head"), [Todo.]))
        sym.space.nobreak
        html.elem("span", attrs: (class: "todo-callout-description"), description)
      })
    ]
  }
}

#let _nav-link(current, page, entry: none) = context {
  let page-entry = if entry == none { _page-entry(page) } else { entry }
  let cls = (
    "nav-item",
    if page.id == current.id { "active" } else { none },
  )
    .filter(x => x != none)
    .join(" ")

  html.elem("li", attrs: (class: cls, style: "--depth: " + str(page-entry.depth)), {
    html.elem("a", attrs: (href: _href-from(current.path, page.path)), page-entry.label)
  })
}

#let _global-nav(current) = context {
  let site-data = _site-data()
  let pages = site-data.at("pages", default: ())
  let entries = site-data.at("entries", default: (:))
  html.elem("nav", attrs: (class: "global-nav", "aria-label": "Site navigation"), {
    html.elem("ul", {
      for page in pages {
        _nav-link(current, page, entry: entries.at(page.id, default: none))
      }
    })
  })
}

#let theorem-heading(thm) = {
  theorem-toc-entry(thm)
}

#let _local-toc() = {
  html.elem("nav", attrs: (class: "local-toc", "aria-label": "On this page"), {
    html.elem("h2", [On This Page])
    html.elem("ul", attrs: ("data-local-toc-list": "true"), [])
  })
}

#let _prev-next(current) = context {
  if sys.inputs.at("debug-build", default: none) == "true" {
    return
  }
  let entry = _page-entry(current)
  let prev = entry.prev
  let next = entry.next

  html.elem("nav", attrs: (class: "page-nav", "aria-label": "Previous and next pages"), {
    if prev != none {
      html.elem("a", attrs: (class: "page-nav-card nav-prev", href: _href-from(current.path, prev.path)), {
        html.elem("span", attrs: (class: "page-nav-arrow"), [←])
        html.elem("span", attrs: (class: "page-nav-kicker"), [Previous])
        html.elem("span", attrs: (class: "page-nav-title"), _page-label(prev))
      })
    } else {
      html.elem("span", attrs: (class: "page-nav-spacer"))
    }
    if next != none {
      html.elem("a", attrs: (class: "page-nav-card nav-next", href: _href-from(current.path, next.path)), {
        html.elem("span", attrs: (class: "page-nav-kicker"), [Next])
        html.elem("span", attrs: (class: "page-nav-title"), _page-label(next))
        html.elem("span", attrs: (class: "page-nav-arrow"), [→])
      })
    } else {
      html.elem("span", attrs: (class: "page-nav-spacer"))
    }
  })
}

#let _topbar(current) = html.elem("header", attrs: (class: "topbar"), {
  html.elem("div", attrs: (class: "topbar-left"), {
    html.elem("button", attrs: (class: "icon-button sidebar-toggle", id: "sidebar-toggle-left", "aria-label": "Menu"), {
      _icon("Menu", _asset-href(current.path, "assets/menu.svg"))
    })
    html.elem("a", attrs: (class: "topbar-title", href: _href-from(current.path, "index.html")), notes-title)
  })
  html.elem(
    "form",
    attrs: (
      class: "topbar-search",
      "data-search-form": "true",
      role: "search",
      action: _href-from(current.path, "search/index.html"),
      method: "get",
    ),
    {
      html.elem("input", attrs: (
        class: "search-input",
        type: "search",
        name: "q",
        placeholder: "Search...",
        autocomplete: "off",
        "aria-label": "Search the site",
      ))
      html.elem("button", attrs: (class: "search-submit icon-button", type: "submit", "aria-label": "Search"), {
        _icon("Search", _asset-href(current.path, "assets/search.svg"))
      })
    },
  )
  html.elem("div", attrs: (class: "topbar-right"), {
    html.elem("button", attrs: (class: "icon-button theme-toggle", "aria-label": "Toggle theme"), {
      _icon("Theme", _asset-href(current.path, "assets/theme.svg"))
    })
    html.elem(
      "button",
      attrs: (class: "icon-button print-button", type: "button", "aria-label": "Print page", title: "Print"),
      {
        _icon("Print", _asset-href(current.path, "assets/print.svg"))
      },
    )
    if not html-only {
      html.elem(
        "a",
        attrs: (
          class: "icon-button export-pdf-link",
          href: _href-from(current.path, "pdf/notes.pdf"),
          "aria-label": "Export PDF",
          title: "Export PDF",
        ),
        {
          _icon("Export PDF", _asset-href(current.path, "assets/download.svg"))
        },
      )
    }
    html.elem("a", attrs: (class: "icon-button github-link", href: source-url, "aria-label": "GitHub source"), {
      _icon("GitHub", _asset-href(current.path, "assets/github.svg"))
    })
    html.elem(
      "button",
      attrs: (class: "icon-button sidebar-toggle", id: "sidebar-toggle-right", "aria-label": "Page contents"),
      {
        _icon("Contents", _asset-href(current.path, "assets/toc.svg"))
      },
    )
  })
})

#let _cover-content(current) = source.web-cover(
  path => _href-from(current.path, path),
  show-pdf: not html-only,
)

#let _pdf-cover() = source.pdf-cover(outline-target: selector(heading).within(pdf-scope-label))

#let _pdf-document(path: none) = context {
  let body = [
    #[
      #render-mode.update("pdf")
      #show: document-styles.with(mode: "pdf", todo: todo)
      #include "/chapters/index.typ"
    ] #pdf-scope-label
  ]

  if path == none {
    body
  } else {
    document(path, format: "pdf", title: notes-title)[#body]
  }
}

#let _html-page(page, body) = {
  let page-label = _page-label(page)
  [
    #metadata((record: "page", page: page)) <page-meta>
    #document(page.doc-path, title: [#page-label | #notes-title])[
      #show: document-styles.with(mode: "web", todo: todo)
      #counter(math.equation).update(0)
      #thm-counter.thm-counters.update((:))
      #html.elem("link", attrs: (rel: "stylesheet", href: _asset-href(page.path, "assets/site.css")))
      #html.elem("link", attrs: (rel: "stylesheet", href: _asset-href(page.path, "assets/search.css")))
      #_topbar(page)
      #html.elem("div", attrs: (class: "layout"))[
        #html.elem("aside", attrs: (class: "sidebar-left"))[
          #_global-nav(page)
        ]
        #html.elem("main", attrs: (class: "content", id: "main"))[
          #if page.kind != "cover" {
            html.elem("h1", attrs: (class: "page-title"), page-label)
          }
          #body
          #_prev-next(page)
        ]
        #html.elem("aside", attrs: (class: "sidebar-right"))[
          #_local-toc()
        ]
      ]
      #html.elem("div", attrs: (class: "sidebar-backdrop", id: "sidebar-backdrop"))
      #html.elem("script", attrs: (src: _asset-href(page.path, "assets/site.js")), [])
      #html.elem("script", attrs: (src: _asset-href(page.path, "assets/search.js")), [])
    ]
    #label("doc-" + page.id)
  ]
}

#let _standalone-page(page, main-class: none, extra-scripts: (), body) = {
  let main-classes = ("content", main-class).filter(value => value != none).join(" ")

  document(page.doc-path, title: [#page.title | #notes-title])[
    #show: document-styles.with(mode: "web", todo: todo)
    #html.elem("link", attrs: (rel: "stylesheet", href: _asset-href(page.path, "assets/site.css")))
    #html.elem("link", attrs: (rel: "stylesheet", href: _asset-href(page.path, "assets/search.css")))
    #_topbar(page)
    #html.elem("div", attrs: (class: "layout"))[
      #html.elem("aside", attrs: (class: "sidebar-left"))[
        #_global-nav(page)
      ]
      #html.elem("main", attrs: (class: main-classes, id: "main"))[
        #body
      ]
      #html.elem("aside", attrs: (class: "sidebar-right"))[
        #_local-toc()
      ]
    ]
    #html.elem("div", attrs: (class: "sidebar-backdrop", id: "sidebar-backdrop"))
    #for script-path in extra-scripts {
      html.elem("script", attrs: (src: _asset-href(page.path, script-path)), [])
    }
    #html.elem("script", attrs: (src: _asset-href(page.path, "assets/site.js")), [])
    #html.elem("script", attrs: (src: _asset-href(page.path, "assets/search.js")), [])
  ]
}

#let _search-page() = {
  let page = (
    id: "search",
    title: "Search",
    route: "/search/",
    path: "search/index.html",
    doc-path: "/search/index.html",
    kind: "search",
    level: 1,
    heading-level: 1,
    description: none,
  )

  _standalone-page(page, main-class: "search-page", extra-scripts: ("assets/search-index.js",))[
    #html.elem("h1", attrs: (class: "page-title"), [Search])
    #html.elem("p", attrs: (class: "search-warning"), [
      Search functionality is still experimental.
    ])
    #html.elem("p", attrs: (class: "search-summary", id: "search-summary"), [
      Enter a word or phrase to search the notes.
    ])
    #html.elem("section", attrs: (class: "search-results", id: "search-results", "aria-live": "polite"))[
      #html.elem("div", attrs: (class: "search-empty"), [Search results will appear here.])
    ]
  ]
}

#let _todo-page() = context {
  let page = (
    id: "todo",
    title: "Todos",
    route: "/todo/",
    path: "todo/index.html",
    doc-path: "/todo/index.html",
    kind: "todo",
    level: 1,
    heading-level: 1,
    description: none,
  )
  let todos = query(selector(<todo-marker>).within(web-scope-label))

  _standalone-page(page, main-class: "todo-page")[
    #html.elem("h1", attrs: (class: "page-title"), [Todos]) <sec:todo>
    #if todos.len() == 0 {
      html.elem("p", attrs: (class: "todo-empty"), [No todos are currently marked.])
    } else {
      html.elem(
        "p",
        attrs: (class: "todo-summary"),
        [#todos.len() open #if todos.len() == 1 { [todo] } else { [todos] }.],
      )
      html.elem("ol", attrs: (class: "todo-list"), {
        for item in todos {
          html.elem("li", attrs: (class: "todo-list-item"), {
            link(item.location(), html.elem("em", attrs: (class: "proof-head"), [Todo.]))
            sym.space.nobreak
            html.elem("span", attrs: (class: "todo-list-description"), item.value.description)
          })
        }
      })
    }
  ]
}

#let _not-found-page() = {
  let page = (
    id: "not-found",
    title: "Page Not Found",
    route: "/page-not-found/",
    path: "page-not-found/index.html",
    doc-path: "/page-not-found/index.html",
    kind: "not-found",
    level: 1,
    heading-level: 1,
    description: none,
  )

  _standalone-page(page, main-class: "not-found")[
    #html.elem("h1", attrs: (class: "page-title"), [Page Not Found])
    #html.elem("p", attrs: (class: "not-found-copy"), [
      This page is not part of the current build.
    ])
    #html.elem("div", attrs: (class: "not-found-actions"))[
      #html.elem("a", attrs: (class: "button", href: _href-from(page.path, "index.html")), [Home])
      #html.elem(
        "button",
        attrs: (
          class: "button button-secondary",
          type: "button",
          onclick: "if (history.length > 1) history.back(); else location.href = 'index.html';",
        ),
        [Back],
      )
    ]
  ]
}

#let _redirect-404-page() = {
  let target = "https://slipperking.github.io/complex-analysis/page-not-found"

  document("/404.html", title: "Redirecting…")[
    #show: document-styles.with(mode: "web")
    #html.elem("meta", attrs: ("http-equiv": "refresh", content: "0; url=" + target))
    #html.elem("meta", attrs: (name: "robots", content: "noindex"))
    #html.elem("link", attrs: (rel: "canonical", href: target))
    #html.elem("main", attrs: (class: "content not-found", id: "main"))[
      #html.elem("h1", attrs: (class: "page-title"), [Redirecting…])
      #html.elem("p", attrs: (class: "not-found-copy"), [
        This page has moved to
        #html.elem("a", attrs: (href: target), [ the new not-found page ])
        .
      ])
    ]
  ]
}

#let _docs-page(
  title: none,
  route: auto,
  kind: "section",
  level: 1,
  heading-format: (number, title) => if number != none { [#number #title] } else { [#title] },
  description: none,
  cover: false,
  heading: true,
  children: none,
  label: auto,
  body,
) = {
  assert(type(heading-format) == function, message: "heading-format must be a function")
  assert(route != auto, message: "docs page needs a route")
  context {
    let route-context = _route-context()
    let segment = _route-segment(route)
    let page-label = if label == auto { _section-label(segment) } else { label }
    let folders = if segment == none {
      route-context.folders
    } else {
      route-context.folders + (segment,)
    }
    let route = _route-from-folders(route-context.prefix + folders)
    let page = _page-info(
      title: title,
      route: route,
      kind: kind,
      level: level,
      heading-level: level,
      heading-format: heading-format,
      description: description,
      label: page-label,
    )

    let page-content = if target() == "bundle" and render-mode.get() == "web" {
      let page-body = if cover {
        [
          #metadata((record: "nav", page: page, has-heading: false)) <page-nav-meta>
          #_cover-content(page)
        ]
      } else if heading {
        [
          #html.elem("div", attrs: (class: "page-source-heading"), _page-heading(page))
          #metadata((record: "nav", page: page, has-heading: true)) <page-nav-meta>
          #body
        ]
      } else {
        [
          #metadata((record: "nav", page: page, has-heading: false)) <page-nav-meta>
          #body
        ]
      }
      _html-page(page, page-body)
    } else if cover {
      _pdf-cover()
    } else {
      if heading {
        _page-heading(page)
      }
      body
    }

    page-content
    if children != none {
      route-folders(folders, children)
    }
    if render-mode.get() == "pdf" and level == 1 {
      std.pagebreak()
    }
  }
}

#let _plain-heading-format(number, title) = if number != none { [#number #title] } else { [#title] }
#let _chapter-heading-format(number, title) = if number != none { [Chapter #number: #title] } else { [#title] }
#let _section-heading-format(number, title) = if number != none { [#sym.section#number #title] } else { [#title] }
#let _appendix-heading-format(number, title) = if number != none { [Appendix #number: #title] } else { [#title] }

#let docs-cover(..args) = _docs-page(
  kind: "cover",
  level: 0,
  cover: true,
  heading-format: _plain-heading-format,
  ..args,
)
#let docs-frontmatter(..args) = _docs-page(kind: "frontmatter", level: 1, heading-format: _plain-heading-format, ..args)
#let docs-chapter(..args) = _docs-page(kind: "chapter", level: 1, heading-format: _chapter-heading-format, ..args)
#let docs-subchapter(..args) = _docs-page(kind: "subchapter", level: 2, heading-format: _section-heading-format, ..args)
#let docs-subsubchapter(..args) = _docs-page(
  kind: "subsubchapter",
  level: 3,
  heading-format: _section-heading-format,
  ..args,
)
#let docs-appendix(..args) = _docs-page(kind: "appendix", level: 1, heading-format: _appendix-heading-format, ..args)
#let docs-backmatter(..args) = _docs-page(
  kind: "backmatter",
  level: 1,
  heading: false,
  heading-format: _plain-heading-format,
  ..args,
)

#let notes() = context {
  if target() == "bundle" {
    include "/src/assets/index.typ"
    if not html-only {
      _pdf-document(path: "pdf/notes.pdf")
    }

    render-mode.update("web")
    context [
      #{
        // Store ordered pages and random-access navigation data from one query.
        set outline(title: metadata(_build-site-data()))
        include "/chapters/index.typ"
        _search-page()
        _todo-page()
        _not-found-page()
        _redirect-404-page()
      } #web-scope-label
    ]
  } else {
    _pdf-document()
  }
}
