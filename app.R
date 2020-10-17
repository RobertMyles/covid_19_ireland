source("src/main.R")
theme_set(theme_minimal())

ui <- fluidPage(
  titlePanel("New Cases & Deaths, Covid-19"),
  p("For selected countries. Cases shown are per million people."),
  div(
    span("Data comes from "),
    a("Our World in Data", href = "https://ourworldindata.org/"),
    span(", specifically "),
    a("here", href = "https://covid.ourworldindata.org/data/owid-covid-data.csv"),
    span(", and from the "),
    a("European Centre for Disease Prevention and Control.",
      href = "https://www.ecdc.europa.eu/en/publications-data/download-data-hospital-and-icu-admission-rates-and-current-occupancy-covid-19"
    )
  ),
  div(
  	span(
  		"Note the differing y-axes on the plots. ICU admissions data is weekly and so has been interpolated 
  	to a daily count using the "),
  	a("forecast package.", href = "https://github.com/robjhyndman/forecast"
  	)
  )
  ,
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      width = 3,
      checkboxGroupInput("checkGroup",
        label = h4("Select Countries -- max. 5."),
        choices = sort(unique(df$location)),
        selected = "Ireland"
      ),
    ),
    mainPanel = mainPanel(
      plotlyOutput("mainplot", height = "600px")
    )
  )
)

server <- function(input, output, session) {
  output$mainplot <- renderPlotly({
    # check
    if (length(input$checkGroup) > 5) {
      countries <- input$checkGroup[1:5]
    } else {
      countries <- input$checkGroup
    }
    # filter
    df <- df %>%
      filter(location %in% countries) %>%
      pivot_longer(
        cols = c(
          new_deaths_smoothed_per_million,
          new_cases_smoothed_per_million,
          icu_admissions_per_million
        ),
        names_to = "metric", values_to = "values"
      ) %>% 
    	mutate(
    		metric = factor(
    			metric, 
    			levels = c(
    				"new_cases_smoothed_per_million",
    				"new_deaths_smoothed_per_million",
    				"icu_admissions_per_million"
    				))
    	)

    # plot
    g <- ggplot(df, aes(
      x = date, y = values,
      colour = location, group = location
    )) +
      geom_line() +
      theme(
        legend.position = "top",
        axis.title.y = element_blank()
      ) +
      labs(
        x = NULL, colour = "Country",
        caption = "Note differing y-axes.\n
				Data from Our World in Data & The European Centre for Disease Prevention and Control."
      ) +
      scale_color_brewer(palette = "Dark2") +
      facet_wrap(~metric,
        ncol = 1, scales = "free_y",
        labeller = nice
      )

    ggplotly(g, tooltip = c("group", "y"))
  })
}

shinyApp(ui = ui, server = server)
