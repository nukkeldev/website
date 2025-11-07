/// Create a foldable section of content with a title.
#let fold(title, content, open: true) = context {
  // TODO: Ideally we'd group the headings with their respective content automatically.

  if target() != "html" {
    title
    content
    return
  }

  // TODO: Because the title is in the summary, navigating to it from the outline does not open it.
  html.details(open: open, html.summary(html.span(style: "display: inline-block", title)) + content)
}

#let fwd-ref(n) = super[[#link(label("from-" + str(n)))[#n]#label("to-" + str(n))]]
#let rev-ref(n) = [[#link(label("to-" + str(n)))[#n]#label("from-" + str(n))]]

#let page-header = html.header(id: "page-header")[
  #heading(outlined: false, html.a(id: "page-title", href: "/")[nukkeldev])
  [#link("/")[index]] [#link("/#about")[about]] [#link("/#writing")[writing]]
]

#let page-footer = html.footer(id: "page-footer")[
  ---

  [#link("/")[index]] [#link("#page-title")[top]]
  -- Source: https://github.com/nukkeldev/website

  This page was rendered on #datetime.today().display().
]

/// Formatting and configuration for HTML export.
#let html-format(title, content) = context {
  // Return the content as normal if not exporting HTML.
  if target() != "html" {
    content
    return
  }

  // Add classes to elements that need to be styled.
  // NOTE: This has to be a `div` as using a `span` translated to a sibling element...
  show outline: html.div.with(class: "outline")

  // Link content replacements for various sites.
  let vcs-info = regex(
    "^https://(github\.com|gitlab\.com|codeberg\.org)/([A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+)(/(commit|pulls?|issues)/([0-9a-fA-F]+))?/?$",
  )
  show vcs-info: it => {
    let caps = it.text.match(vcs-info).captures
    let (site, user-repo, _, opt-type, opt-data) = caps

    if (site == "github.com") {
      "gh"
    } else if (site == "gitlab.com") {
      "gl"
    } else if (site == "codeberg.org") {
      "cb"
    }
    ":"
    user-repo
    if (opt-type == "commit") {
      [ [commit: #{ opt-data.slice(0, 8) }]]
    } else if (opt-type == "pull" or opt-type == "pulls") {
      [ [pr: \##opt-data]]
    } else if (opt-type == "issues") {
      [ [issue: \##opt-data]]
    }
  }

  // NOTE: This replaces the default export structure.
  show: html.html.with(lang: "en")
  html.head({
    html.meta(charset: "utf-8")
    html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
    html.link(href: "/index.css", rel: "stylesheet")
    html.title(title + " - nukkeldev")
  })
  html.body({
    page-header
    content
    page-footer
  })
}

#let writing-format(info, content) = context {
  show: html-format.with(info.title)

  heading(outlined: false, level: 2)[#info.path - #info.title]
  html.p(id: "tags", {
    info.date.display()
    " + "
    let tag-len = info.tags.len()
    if tag-len >= 1 {
      [tags: ]
      for i in range(0, tag-len) {
        emph(info.tags.at(i))
        if i < tag-len - 1 { [, ] }
      }
    }
  })
  [---]
  content
}
