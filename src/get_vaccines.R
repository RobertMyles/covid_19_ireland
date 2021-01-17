get_vaccines <- function() {
	df <- fread(
		"https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv"
		) %>% 
		as_tibble() %>%
		select(location, date, total_vaccinations_per_hundred) %>% 
		filter(
			location %in% c(
				"Brazil", "Ireland", "United Kingdom", "United States",
				"Sweden", "Spain", "France", "Germany", "Netherlands",
				"Belgium", "Denmark", "Norway", "Italy", "Germany",
				"Brazil"
			)
		) %>% 
		mutate(
			date = as_date(date),
			total_vaccinations_per_hundred = na.interp(total_vaccinations_per_hundred)
			)
	df
}