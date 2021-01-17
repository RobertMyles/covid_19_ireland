age_plot <- function(input) {
	suppressWarnings({
		renderPlot({
			ggplot(age, aes(
				x = date, y = hospital_cases, colour = age_group,
				group = age_group,
				text = glue("{age_group}:\n{hospital_cases}\n{date}")
				)) + 
				geom_line() +
				labs(
					x = NULL, colour = "Age Group", y = NULL,
					caption = "Data from https://covid-19.geohive.ie/, CovidStatisticsProfileHPSCIrelandOpenData."
				) +
				scale_color_brewer(palette = "Dark2")
		})
	})
}