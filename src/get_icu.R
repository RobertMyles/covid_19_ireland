
get_prep_icu <- function() {
	# get file
	url <- "https://opendata.ecdc.europa.eu/covid19/hospitalicuadmissionrates/csv/data.csv"
	icu <- fread(url) %>% as_tibble()
	# prep
	icu <- icu %>% 
		filter(
			!is.na(year_week),
			indicator == "Weekly new ICU admissions per 100k"
			) %>% 
		mutate(
			date2 = paste0(year_week, "-1") %>% 
				ISOweek2date(),
			icu_admissions_per_million = value/10
		) %>% 
		select(location = country, date = date2, icu_admissions_per_million) %>% 
		filter(date >= "2020-01-27") %>% 
		group_by(location) %>% 
		complete(date = seq.Date(min(date), max(date), by = "day")) %>% 
		mutate(
			icu_admissions_per_million = na.interp(icu_admissions_per_million),
			icu_admissions_per_million = round(icu_admissions_per_million, 3),
			date = as.character(date)
			)
	
	return(icu)
}




