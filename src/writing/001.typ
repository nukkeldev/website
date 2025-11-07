#import "../_lib.typ": *

#let info = (
  path: "001",
  date: datetime(year: 2025, month: 11, day: 6),
  title: "Developing This Site In Typst",
  tags: ("typst", "site"),
)

#show: writing-format.with(info)

This brief article goes over my rewrite of this website using #link("https://typst.app/")[Typst] and bash.

#outline(title: none)

=== Goals

This is the second iteration of this site. Initially, it was written with #link("https://zine-ssg.io/")[zine] which, while it wasn't bad to work with, wasn't built for my use-case and constrained what I wanted to do too much.

Upon considering a rewrite, I'd been using #link("https://typst.app/")[Typst] to typeset my math and physics notes for a couple of years and seeing it had (_very_) experimental HTML support, I felt it'd be good to try my luck with.

As I had a bit of free-time, I decided to establish some goals/constraints on my rewrite:
+ As close to "pure" Typst as possible.
  + Unfortunately, as Typst is only able to produce a single output file, we still need another program to trigger the compilation calls, but a bash script seems sufficient for that.
+ Full control over all parts of the output.
  + Typst's html support allows for both typed and raw access to HTML elements.
  + If we specify our own `<html></html>`, we overwrite the default which allows us to write the `<head>`.
  + If the HTML exporter does not support a specific Typst feature (i.e. graphics, equations, etc.), we are able to fallback on `html.frame` to embed the content rendered as SVG.
+ Capable of rendering mathematics client-side.
  + This is primarily for performance reasons.
    Rendering all of the equations to SVGs server-side would be the most ideal scenario as there wouldn't be any ambiguity in their rendering across platforms.
    Unfortunately, the 10s of kilobytes per equation is quite discouraging and leaves it only to be used when absolutely necessary.
  + As of https://github.com/typst/typst/commit/16de17a1b3c9b14646b468e54639f7829c24de60, Typst's HTML exporter does not support anything related to mathematics as stated above. Luckily, https://github.com/typst/typst/pull/7206 is working on an initial implementation of getting MathML working in the exporter and it works well.
  + Alteratively, https://codeberg.org/akida/mathyml/ is a package to render equations into MathML in pure Typst. Both seem similar feature-wise so I'd prefer to not use another external dependency.
+ Common header/footer, frontmatter-like article abstractions, etc.
  + Easy to implement with `import`ing and modules.
+ Should be rendered consistently across browsers and platforms.
  + This is out-of-scope for Typst and falls more into CSS styling and fonts, of which Typst allows me to easily work with.

After some brief searching, I found a couple of existing Typst static-site generators (see https://github.com/Glomzzz/typsite, https://github.com/kokic/kodama, https://github.com/kawayww/tola-ssg, https://gitlab.com/pcoves/theta)#fwd-ref(1). But rather than use them, I decided to have more fun and write one myself (the results of which you are looking at).

I accomplished all of the above goals to a reasonable degree within \~three days. Below I detail the basic architecture as well as some points I found interesting.

=== Overview

I dislike over-complexity, as everyone should, though I have my fair share of it.
In evaluating the above goals, I wanted to use as minimal of a "stack" as possible: Typst + bash.

==== Templates

I have a fairly concise shared library `_lib.typ` wherein I define the "templates" for the pages.
For the writings, such as this one, the templating function `writing-format` (which in turn uses `html-format`) consumes a dictionary for details on the document (which also allows for a _mostly_ automatic writing listing on index).

For instance, for this article the setup is as follows:
#{
  let this = read("001.typ")
  raw(lang: "typ", block: true, this.split("\n").slice(0, 10).join("\n"))
}
The above code-block is dynamically read from the source files during compilation, which I find quite cool. Of course, that means that as the source changes, de-sync may occur, but in this case, as it is the top of the document, it's rarely going to change (except when I modify the `info` format or contents)#fwd-ref(2).

For the `index.typ`, I directly use the parent template `html-format` which sets up the entire HTML structure.
#{
  let this = read("../_lib.typ")
  ```typ
  #let html-format(title, content) = context {
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
  ```
}
#html.aside[Unfortunately, I elected not to dynamically read this one as it is much more prone to changing.]

==== Cool Features

While rewriting, I found (either on my own, from other codebases, or from the forum) a few cool features with the current HTML exporter implementation that I didn't find officially documented elsewhere.
- When a Typst element is labeled _and_ directly referenced (i.e. with a `link`), the output is `id'd` to that label.
  - All headings, if an `outline` is present, are given `id`s in the form `loc-#` if a label isn't attached (the outline properly links to the custom labels if they are present).
- As hinted at in the goals, without explictly defining an `<html>` structure for the document, we are given a basic one. Unfortunately, when using a custom HTML root, some features (i.e. `footnote`) are disabled.

#fold[==== Collapsible Sections][
  While I was able to make sections collapsible by wrapping them with `html.detail`, I first tried to do it with just `show` rules, but wasn't able to do it quickly so I will come back to it later.
  This should be possible with just `show` rules with some sort of "_query heading, query next heading of the same level, query content in between, fin_" but I find that rather abusive of `show` rules (heading #sym.arrow heading + content).
  Instead, it would be easier (and preferable) to do this in `html-format` by iterating over the `content.children`, but I have yet to implement that.
]

==== Link Replacements

One thing we can do with `show` rules (+ regex) though, is replacing the content of links.

When preferable I'd rather not have to type out the full `#link("...")[...]` for links that are for common things (i.e. github repos, commits, etc.) To do this, I used AI for the one of the few good uses: _writing regex_.

```regex
^https://(github\.com|gitlab\.com|codeberg\.org)/([A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+)(/(commit|pulls?|issues)/([0-9a-fA-F]+))?/?$
```

That beauty matches repositories, commits, pull requests, and issues from Github, Gitlab, and Codeberg. I can match it once in the `show` rule and again in the body to get the capture groups to format the links as you saw above when I first mentioned equation rendering.

=== Conclusion

Overall, this rewrite has been quite fun so far (considering it's been three days) and I'll definitely keep refining and adding more features to this. There is still quite a bit of work to do on the styling; I hate CSS.

---

#html.aside[#rev-ref(1) I have not used any of the listed projects nor am familiar with their developers.]
#html.aside[#rev-ref(2) I love commas.]
