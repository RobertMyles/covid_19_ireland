
get_prep_icu <- function() {
	# get file
	url <- "https://www.ecdc.europa.eu/sites/default/files/documents/hosp_icu_all_data_2020-10-15.xlsx"
	tmp <- tempfile(fileext = ".xlsx")
	GET(url = url, write_disk(tmp))
	icu <- read_excel(tmp)
	unlink(tmp)
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
			icu_admissions_per_million = round(icu_admissions_per_million, 3)
			)
	
	return(icu)
}




