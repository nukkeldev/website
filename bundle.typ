#show title: html.div.with(class: "title")

#asset("styles.css", read("styles.css"))
#asset("favicon.ico", read("favicon.ico", encoding: none))

#let head = {
  html.head[
    #html.link(rel: "stylesheet", href: "/styles.css")
  ]
  link(<home>)[home]
}

#document("index.html", title: [ethan])[
  #head
  #title[ethan]

  #html.span(id: "hidden-til-link", link(<til>)[click here])

  = about me

  - I am an 19-year-old university student in the US studying Mathematics.
  - Prior to university, programming (most recently with #link("https://ziglang.org/")[Zig]) and robotics (#link("https://www.firstinspires.org/programs/frc/")[FRC]) were my primary interests for several years.
  - I really enjoy music (mostly abrassive and experimental).
  - I love #link("https://typst.app")[Typst] (this website is made with it).
  - Contact: #link("mailto:nukkel.dev@gmail.com")[nukkel.dev\@gmail.com]

  = pages

  - #link(<math-progress>)[math progress]
  - #link(<reading>)[reading]

] <home>

#for (file, expanded, lbl) in (("til.html", false, <til>), ("til-expanded.html", true, <til-expanded>)) {
  [
    #document(file, title: [things i like], {
      head
      title[things i like]

      link(<til-expanded>)[expand all]
      [ ]
      link(<til>)[collapse all]

      let data = (
        "Bands": (
          "Alternative Rock/Metal": ("Deftones", "Muse", "Greg Puciato"),
          "Blackgaze": ("Agriculture", "Deafheaven", "To Be Gentle"),
          "Black Metal": ("A Forest of Stars", "Blut aus Nord", "Scimitar"),
          "Brutal Death Metal": ("Cryptopsy",),
          "Deathcore": ("Bring Me The Horizon", "Disembodied Tyrant", "Orphan", "Rev3rent"),
          "Doomgaze": ("The Angelic Process",),
          "Dream Pop": ("Love Spells",),
          "Indie Rock": ("Basht.", "Fontaines D.C.", "Ghinzu", "Neutral Milk Hotel", "Raised by Swans", "Unwound"),
          "Electro-Industrial": ("Street Sects", "Alice Glass", "HEALTH"),
          "Experimental/Noise Rock": (
            "Chat Pile",
            "Oxbow",
            "Shearling",
            "Mamaleek",
            "Xiu Xiu",
            "Swans",
            "Prostitute",
            "Ciśnienie",
            "Sprain",
          ),
          "Gothic Rock": ("Crippling Alcoholism", "She Wants Revenge"),
          "Mathcore": ("The Dillinger Escape Plan",),
          "Post Hardcore": (
            "Static Dress",
            "Dance Gavin Dance",
            "The Number Twelve Looks Like You",
            "Fear Before the March of Flames",
          ),
          "Post Punk": ("Have a Nice Life", "Maruja"),
          "Post Rock": ("April Rain", "No Clear Mind"),
          "Progressive Metal": ("Karnivool",),
          "Screamo": ("Infant Island", "Portrayal of Guilt", "Gillian Carter"),
          "Slam": ("Big Chef", "Snuffed On Sight"),
          "Sludge Metal": ("Isis", "The Body", "Thou"),
          "Singer-Songwriter": ("Flower Face", "Nicole Dollanganger"),
          "Slowcore": ("Giles Corey", "From Your Balcony", "Low", "Cigarettes After Sex"),
          "Symphonic Metal": ("Fleshgod Apocalypse", "Septicflesh"),
          "Technical Death metal": ("Vitriol",),
          "Thall": ("Mirar",),
        ),
        "Programming": (
          "Languages": (
            "Typst|https://typst.app",
            "Zig|https://ziglang.org",
            "Rust|https://rust-lang.org/",
            "C",
          ),
          "Open-Source Software": ("Linux|https://kernel.org/",),
          "Closed-Source Software :(": (
            "Wolfram Mathematica|https://www.wolfram.com/mathematica/",
          ),
        ),
        "Essayists": (
          "Horses|https://www.youtube.com/@HorsesOnYT",
        ),
        "Games": (
          "(Modded) Minecraft",
          "Trackmania 2020",
          "Trackmania Nations Forever",
        ),
      )

      let render(d) = {
        let out = []
        let len = 0
        if type(d) == array {
          out = list(..d.map(e => {
            let p = e.split("|")
            if p.len() == 1 {
              [#p.at(0)]
            } else {
              link(p.at(1), p.at(0))
            }
          }))
          len = d.len()
        } else {
          for (k, v) in d {
            out += html.details(open: expanded, {
              let (o, l) = render(v)
              len += l
              html.summary[#k \[#l\]]
              if type(v) != array {
                html.div(class: "subitem", o)
              } else {
                o
              }
            })
          }
        }
        return (out, len)
      }

      let (out, _) = render(data)
      [#out]
    }) #lbl
  ]
}

#document("math-progress.html", title: [math progress])[
  #head
  #title()

  - High School
    - AP Calculus AB: 5
    - AP Calculus BC: 5
    - AP Statistics: 5
  - Winter 2025
    - Calculus 3 (Series): 4.0
  - Spring 2026
    - (Ordinary) Differential Equations: 4.0
    - Linear Algebra: 4.0
  - Summer 2026 \[\*\]
    - Multivariable Calculus
    - Introduction to Mathematical Reasoning (Proofs)
  - Autumn 2026
    - Introduction to Statistical Inference
    - Numerical Analysis I
  - Winter 2026
    - Introduction to Professional Mathematics
    - Real Analysis
  - Spring 2027
    - Abstract Algebra
    - Topology
  - Summer 2027
    - TBD
  - Autumn 2027
    - Linear Programming
    - History of Mathematics
  - Winter 2027
    - Complex Analysis
    - Numerical Analysis II
  - Spring 2028
    - TBD

] <math-progress>


#document("reading.html", title: [reading])[
  #head
  #title()

  - #link("https://richardhammack.github.io/BookOfProof/")[Book Of Proof]
  - American Prometheus: The Triumph and Tragedy of J. Robert Oppenheimer
  - Have a Nice Life "Deathconsciousness" Book

  // = to read

  // = read
] <reading>
