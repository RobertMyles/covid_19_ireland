sidebar <- column(
  3,
  wellPanel(
    checkboxGroupInput("checkGroup",
      label = h4("Select Countries -- max. 5."),
      choices = sort(unique(df$location)),
      selected = "Ireland"
    )
  )
)
