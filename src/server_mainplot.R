main_plot <- function(input) {
	suppressWarnings({
		renderPlotly({
			
			if (length(input$checkGroup) > 5) {
				countries <- input$checkGroup[1:5]
			} else {
				countries <- input$checkGroup
			}
			
			df <- df %>%
				filter(location %in% countries) %>%
				pivot_longer(
					cols = c(
						new_deaths_smoothed_per_million,
						new_cases_smoothed_per_million,
						icu_admissions_per_million # ,
						# positive_rate
					),
					names_to = "metric", values_to = "values"
				) %>%
				mutate(
					metric = factor(
						metric,
						levels = c(
							"new_cases_smoothed_per_million",
							"new_deaths_smoothed_per_million",
							"icu_admissions_per_million" # ,
							# "positive_rate"
						)
					)
				)
			
			g <- ggplot(df, aes(x = date, y = values, colour = location, group = location,
													text = glue("{location}:\n{values}\n{date}"))) +
				geom_line() +
				theme(legend.position = "top", axis.title.y = element_blank()) +
				labs(
					x = NULL, colour = "Country",
					caption = "Note differing y-axes.\n
				Data from Our World in Data & The European Centre for Disease Prevention and Control."
				) +
				scale_color_brewer(palette = "Dark2") +
				facet_wrap(~metric,ncol = 1, scales = "free_y", labeller = nice)
			
			ggplotly(g, tooltip = "text")
		})
	})
}

	