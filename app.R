source("src/main.R")
source("src/ui_components.R")
source("src/server_components.R")

theme_set(theme_minimal())

ui <- fillPage(
  title_panel,
  intro_div,
  fluidRow(
    sidebar,
    main_panel
  )
)

server <- function(input, output, session) {
  output$activeTab <- reactive(return(input$tab))
  outputOptions(output, 'activeTab', suspendWhenHidden = FALSE)
  output$mainplot <- main_plot(input)
  output$mapplot <- map_plot(input)
}

shinyApp(ui = ui, server = server)
