source("src/get_icu.R")
source("src/get_vaccines.R")

path <- "https://covid.ourworldindata.org/data/owid-covid-data.csv"
df <- suppressMessages(
  suppressWarnings(
    fread(path)
    )
  )
df <- df %>% 
	as_tibble() %>% 
	select(
		date, new_deaths_smoothed_per_million, 
		new_cases_smoothed_per_million, location,
		continent, positive_rate
		) %>% 
	filter(date >= "2020-01-27") %>% 
	mutate(date = as.character(date))

icu <- get_prep_icu()
vaccines <- get_vaccines()

df <- full_join(df, icu, by = c("location", "date")) %>% 
	mutate(date = as_date(date)) %>% 
	full_join(vaccines, by = c("location", "date")) %>% 
	filter(
		continent %in% c("Europe", "North America", "South America"),
		location %in% c(
			"Brazil", "Ireland", "United Kingdom", "United States",
			"Sweden", "Spain", "France", "Germany", "Netherlands",
			"Belgium", "Denmark", "Norway", "Italy", "Germany",
			"Brazil"
		)
	) 


write_csv(df, "data/data_raw.csv")
