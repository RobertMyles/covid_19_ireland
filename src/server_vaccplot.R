vacc_plot <- function(input) {
	suppressWarnings({
		renderPlotly({
			
			if (length(input$checkGroup) > 5) {
				countries <- input$checkGroup[1:5]
			} else {
				countries <- input$checkGroup
			}
			print(df)
			df <- df %>% 
				filter(
					location %in% countries,
					date >= "2020-12-10"
					) %>% 
				rename(`Total Vaccinations per 100` = total_vaccinations_per_hundred)
			
			g <- ggplot(df, aes(x = date, y = `Total Vaccinations per 100`, 
													colour = location, group = location,
													text = glue("{location}:\n{`Total Vaccinations per 100`}\n{date}"))) +
				geom_line() +
				theme(legend.position = "top", axis.title.y = element_blank()) +
				labs(
					x = NULL, colour = "Country",
					caption = "Note differing y-axes.\n
				Data from Our World in Data."
				) +
				scale_color_brewer(palette = "Dark2")
			
			ggplotly(g, tooltip = "text")
		})
	})
}

