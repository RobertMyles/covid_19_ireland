main_panel_desktop <- column(
  8,
  tabsetPanel(
    type = "tabs",
    tabPanel("Cases", plotlyOutput("mainplot", height = "100%")),
    tabPanel("Vaccinations", plotlyOutput("vaccplot", height = "100%")),
    tabPanel("Ireland Case Map", plotOutput("mapplot") %>%
               withSpinner(color = "#F02A29", type = 8)),
    tabPanel(
      "Irish Cases by Age Group", plotOutput("ageplot")
    ),
    id = "tab"
  )
)
main_panel_mobile <- column(
  8,
  plotlyOutput("mainplot", height = "300px"),
  plotlyOutput("vaccplot", height = "300px")
)
