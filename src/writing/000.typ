#import "../_lib.typ": *

#let info = (
  path: "000",
  date: datetime(year: 2025, month: 11, day: 6),
  title: "Site Status",
  tags: ("typst", "site", "not-for-reading"),
)

#show: writing-format.with(info)

This page keeps track of how my site handles various Typst constructs.
See #link("/writing/001.html")[001] for more information.

=== Layout

TODO

=== Images

TODO, but they work.

=== Link replacements

- Github, Gitlab, or Codeberg Repositories: https://github.com/typst/typst/, https://gitlab.com/pcoves/theta, https://codeberg.org/akida/mathyml
- Github or Codeberg Commits: https://github.com/typst/typst/commit/16de17a1b3c9b14646b468e54639f7829c24de60
- Github or Codeberg PRs: https://github.com/typst/typst/pull/7206
- Github or Codeberg Issues: https://github.com/kokic/kodama/issues/71

=== Code

```zig
pub fn main() !void {
  @import("std").debug.println("Hello, Typst!");
}
```

=== Footnotes

While Typst `footnote` do not work with a custom HTML root as of now, this behavior is fairly simple#fwd-ref(1)....

#html.aside[#rev-ref(1) ... to recreate.]

=== Equations

While the development version of the Typst compiler does not have support for equation exporting, #link("https://github.com/typst/typst/pull/7206")[\#7206] is working on the initial work in converting equations into MathML. As such, this site is currently built off that branch.

$ { x/2 in A | 1/sqrt(x) > 1 } $
$
  (sum_(k = 1)^n a_k b_k)^2
  <= (sum_(k = 1)^n a_k^2) (sum_(k = 1)^n b_k^2)
$
$
  forall A thin exists P thin forall B thin [
    B in P <==> forall C thin (C in B => C in A )
  ]
$

#html.aside[While it can't render them directly, Typst offers `html.frame` that can render any Typst content into an SVG embed. While this does ensure consistent rendering across clients, this also horribly bloats the export.]
