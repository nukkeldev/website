#import "_lib.typ": fold, html-format

// -- Content -- //

#show: html-format.with("Home")

This is my personal website / portfolio written in #link("https://github.com/typst/typst")[Typst] and minimal CSS.
I publish writings on programming, maths, etc. of varying lengths here.

#outline(title: none)

== About Me <about>

I am an 18-year-old first-year university student from the U.S. pursing a bachelor's in computer engineering.

My primary interests are in:
- Programming: #link("https://ziglang.org/")[Zig], Compilers, RISC-V Kernels, Graphics Programming, #link("https://lean-lang.org/")[LEAN4]\*, Audio Synthesis\*
- Mathematics: Calculus, Formal Logic, Set Theory, Graph Rewriting\*
- Typesetting: #link("https://github.com/typst/typst")[Typst]
- Robotics: #link("https://urc.marssociety.org/")[URC], ex-#link("https://www.firstinspires.org/programs/frc/")[FRC]
- Music: Listening, Playing\*
- Writing

\* Topics I intend to learn.

You can find me in the following places:
- Github: #link("https://github.com/nukkeldev")
- Email: #link("mailto:nukkel.dev@gmail.com")
- LinkedIn: #link("https://www.linkedin.com/in/ethfw/")

== Writing <writing>

Below you can find all writings I have published:
#{
  // NOTE: GO HERE TO PUBLISH!
  let published = (
    "001",
    "000",
  )
  list(
    ..published
      .sorted(by: (a, b) => a > b)
      .map(title => {
        let path = "writing/" + title + ".typ"
        import path as w
        link("/writing/" + w.info.path + ".html", [
          #w.info.path - #w.info.title #{
            let tag-len = w.info.tags.len()
            if tag-len >= 1 {
              [\[tags: ]
              for i in range(0, tag-len) {
                emph(w.info.tags.at(i))
                if i < tag-len - 1 { [, ] }
              }
              [\]]
            }
          }
        ])
      }),
  )
}
