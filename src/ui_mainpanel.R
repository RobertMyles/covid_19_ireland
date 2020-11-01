main_panel <- column(
  8,
  tabsetPanel(
    type = "tabs",
    tabPanel("Cases", plotlyOutput("mainplot", height = "100%")),
    tabPanel("Ireland Case Map", plotOutput("mapplot") %>% 
               withSpinner(color = "#F02A29", type = 8)),
    id = "tab"
  )
)
