source("src/main.R")
source("src/ui_components.R")
source("src/server_components.R")

theme_set(theme_minimal())

ui <- fluidPage(
  mobileDetect('isMobile'),
  title_panel,
  intro_div,
  fluidRow(
    sidebar,
    tags$div(id = 'plot') 
  )
)

server <- function(input, output, session) {
  inserted <- c()
  observeEvent(input$isMobile, {
    if (input$isMobile) {
      insertUI(
        selector = '#plot',
        ui = tags$div(
          main_panel_mobile
          )
      )
    } else {
      insertUI(
        selector = '#plot', 
        ui = tags$div(main_panel_desktop)
      )
    }
  })
  
  output$activeTab <- reactive(return(input$tab))
  outputOptions(output, 'activeTab', suspendWhenHidden = FALSE)
  output$mainplot <- main_plot(input)
  output$mapplot <- map_plot(input)
}

shinyApp(ui = ui, server = server)
