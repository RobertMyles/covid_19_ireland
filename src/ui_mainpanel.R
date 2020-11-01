main_panel <- column(
  8,
  plotlyOutput("mainplot", height = "100%")
  # tabsetPanel(
  #   type = "tabs",
  #   tabPanel("Cases", ),
  #   tabPanel("Ireland Case Map", plotOutput("mapplot") %>% 
  #              withSpinner(color = "#F02A29", type = 8)),
  #   id = "tab"
  # )
)
