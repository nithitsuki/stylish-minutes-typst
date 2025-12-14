#let dark-mocha-theme = (
  primary: rgb("#C39E88"),
  primary-fg: rgb("#2d2521"),
  secondary: rgb("#8A655A"),
  secondary-fg: rgb("#F1F0E5"),
  background: rgb("#2d2521"),
  foreground: rgb("#F1F0E5"),
)

#let light-orange-theme = (
  primary: rgb("#c96442"),
  primary-fg: rgb("#ffffff"),
  secondary: rgb("#e9e6dc"),
  secondary-fg: rgb("#535146"),
  background: rgb("#f5f3ef"),
  foreground: rgb("#35302a"),
)

#let black-white-theme = (
  primary: rgb("#000000"),
  primary-fg: rgb("#ffffff"),
  secondary: rgb("#ffffff"),
  secondary-fg: rgb("#000000"),
  background: rgb("#ffffff"),
  foreground: rgb("#000000"),
)

#let theme-state = state("minutes-theme", light-orange-theme)

#let stylish-minutes(
  title,
  date: datetime.today(),
  theme: light-orange-theme,
  location: "",
  next-date: "",
  content,
) = context {
  theme-state.update(theme)
  // section above the table
  set text(
    fill: theme.primary,
    font: "SF Pro Display",
    size: 1.25em,
  )
  set page(
    numbering: none,
    margin: (top: 3em, left: 3em, right: 3em, bottom: 3em),
    fill: theme.background,
    footer: context {
      let theme = theme-state.get()

      set text(fill: theme.foreground, size: 0.9em)

      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        inset: (x: 0pt, y: 0pt),

        if location != "" {
          text("Location:  ")
          box(
            fill: theme.secondary,
            outset: (x: 2pt, y: 0.25em),
            inset: (x: 0em),
            text(fill: theme.secondary-fg, location),
          )
        },

        counter(page).display("1/1", both: true),

        if next-date != "" {
          text("Next Meeting:  ")
          box(
            fill: theme.secondary,
            outset: (x: 2pt, y: 0.25em),
            inset: (x: 0em),
            text(fill: theme.secondary-fg, next-date.display()),
          )
        },
      )
    },
  )
  text("Minutes", size: 4em, weight: "bold", fill: theme.primary, stroke: 0.002em)
  h(1fr)
  box(rect(fill: theme.secondary, text(date.display(), size: 1.55em,fill: theme.secondary-fg)))

  v(0em)
  text("Meeting title: ", size: 1.55em)
  text(title, size: 1.5em)


  set text(
    fill: theme.foreground,
  )

  content

  //footer
}

#let get-theme() = context {
  theme-state.get()
}
// table grid for meeting content
#let meeting-grid(
  items: (), // Expects a list of arrays: ( ("Title", [Content]), ("Title", [Content]) )
) = context {
  let theme = theme-state.get()
  set table(
    stroke: 1pt + theme.primary,
    inset: 1em,
  )

  // Internal helper to style headers consistently
  let header-cell(content) = table.cell(fill: theme.secondary)[
    #set text(fill: theme.secondary-fg, weight: "bold", size: 1.15em)
    #content
  ]

  table(
    columns: (1fr, 1fr),
    ..items
      .chunks(2)
      .map(pair => {
        let left = pair.first()
        // If there is no right item (odd number of items), use an empty placeholder
        let right = pair.at(1, default: ("", []))

        return (
          header-cell(left.at(0)),
          header-cell(right.at(0)),
          left.at(1),
          right.at(1),
        )
      })
      .flatten()
  )
}

// Use this inside the grid content to generate that nested look
#let progress-list(items: ()) = context {
  let theme = theme-state.get()
  set text(fill: theme.foreground)
  //inset to remove padding from the table cell
  box(width: 100%, inset: -1em, table(
    columns: (auto, 1fr),
    stroke: 1pt + theme.primary,
    inset: 1em,
    align: (x, y) => if x == 0 { left + horizon } else { left },
    ..items.flatten()
  ))
}
