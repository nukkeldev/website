#import "_lib.typ": fold, html-format

// -- Content -- //

#show: html-format.with("Home")

This is my personal website / portfolio written in #link("https://github.com/typst/typst")[Typst] and minimal CSS.
I publish writings on programming, maths, etc. of varying lengths here.

#outline(title: none)

#fold[== About Me <about>][
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

  #fold(open: false)[=== Background <background>][
    I developed an interest in programming early 2017 and since then have been mostly self-taught.
    Going through my old emails and other sources, I believe the timeline was approximately as follows:
    - In 2017, I created a #link("https://scratch.mit.edu/")[Scratch] account and made several projects.
    - In 2018, I started to learn JavaScript, C\# with #link("https://unity.com/")[Unity], Java, and joined my first #link("https://www.firstinspires.org/programs/ftc/")[FTC] team.
    - In 2019, I started to play more with hardware (i.e. #link("https://www.arduino.cc/")[Arduinos]), started learning Python, made my first (now deleted) Github account, and joined another FTC team after moving.
    - In 2020, I focused mostly on projects in Java, with some Web development.
    - In 2021, I started to have an interest in compilers, operating systems, and embedded (despite being horribly underskilled of course), joined my first FRC team, started learning TypeScript and "modern" SPA frameworks, and had my first exposure to Linux.
    - In 2022, started moving towards C/C++, experimented with shader programming, became programming lead for my FRC team, Rust became my primary language, and rebranded to my current Github.
    - In 2023, besides robotics, I focused on graphics programming with #link("https://wgpu.rs/")[wgpu] (see #link("https://github.com/nukkeldev/parametrics")[nukkeldev/parametrics]) and CPU raytracing (see #link("https://github.com/nukkeldev/rtftwatfwir")[nukkeldev/rtftwatfwir]), and continued to pursue previous interests to various lesser degrees.
    - In 2024, I spent most of my time on robotics, continued experimenting with Rust, lots of parsing (see #link("https://github.com/nukkeldev/wpilog-parser")[nukkeldev/wpilog-parser]), P2P over DNS, etc.
    - In 2025, I swapped to Zig as my main language, wrote #link("https://github.com/nukkeldev/zpp")[nukkeldev/zpp] to transpile C++ headers to work with Zig's FFI, wrote a rendering engine #link("https://github.com/nukkeldev/garden")[nukkeldev/garden], and a RISC-V S-mode kernel for hardware introspection #link("https://github.com/nukkeldev/rvhw")[rvhw]. While all three of the aforementioned projects do work in some capacity, I don't believe any are mature enough for them to be considered v0.1+.

    Much of my early work, and even some recent work, was lost due to hardware changes/failures.
    While I'd like to have more to show for my close to a decade of programming, being able to design software with a focus on performance regardless of language, alongside my immense exposure of ways to create software, is what I value most.
  ]
]

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
