source("src/main.R")
theme_set(theme_minimal())

ui <- fluidPage(
	titlePanel("New Cases & Deaths, Covid-19"),
	p("For selected countries. Cases shown are per million people."),
	sidebarLayout(
		sidebarPanel = sidebarPanel(
			width = 3,
			checkboxGroupInput("checkGroup", label = h4("Select Countries -- max. 5."), 
												 choices = sort(unique(df$location)),
												 selected = c("Sweden", "Ireland", "Belgium",
												 						 "Spain", "France", "United Kingdom")),
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
					new_cases_smoothed_per_million
					), 
				names_to = "metric", values_to = "values"
			)
		
		# plot
		g <- ggplot(df, aes(
			x = date, y = values,
			colour = location, group = location
			)) +
			geom_line() +
			theme(legend.position = "none") +
			theme(axis.title.y = element_blank()) +
			labs(x = NULL) +
			facet_wrap(~metric, ncol = 1, scales = "free_y",
								 labeller = nice)
		
		ggplotly(g, tooltip = c("group", "y"))
	})
	
}

shinyApp(ui = ui, server = server)