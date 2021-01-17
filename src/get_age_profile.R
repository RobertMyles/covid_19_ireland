
get_age_profile <- function(get = FALSE) {
	if (get) {
		base <- "https://services1.arcgis.com/eNO7HHeQ3rUcBllm/arcgis/rest/services/"
		service <- "CovidStatisticsProfileHPSCIrelandOpenData/FeatureServer/0/"
		query <- "query?where=1%3D1&outFields=*&outSR=4326&f=json"
		
		url <- glue("{base}{service}{query}")
		age <- fromJSON(url)$features$attributes %>% as_tibble()
		
		age <- age %>% 
			select(
				date = StatisticsProfileDate, median_age = Median_Age,
				HospitalisedAged5:HospitalisedAged65up
			) %>% 
			mutate(
				date = as.POSIXct(date/1000, origin = "1970-01-01")
			) %>% 
			pivot_longer(
				cols = c(HospitalisedAged5:HospitalisedAged65up),
				names_to = "age_group", values_to = "hospital_cases"
			) %>% 
			mutate(
				age_group = case_when(
					age_group %in% c(
						"HospitalisedAged5", "HospitalisedAged5to14", "HospitalisedAged15to24",
						"HospitalisedAged25to34") ~ "Under 35",
					age_group %in% c(
						"HospitalisedAged35to44", "HospitalisedAged45to54"
					) ~ "35 to 54",
					age_group == "HospitalisedAged55to64" ~ "55 to 64",
					TRUE ~ "65 and older"
				),
				age_group = fct_relevel(
					age_group, "Under 35", "35 to 54", "55 to 64", "65 and older"
				)
			) %>% 
			group_by(date, age_group) %>% 
			summarise(hospital_cases = sum(hospital_cases, na.rm = TRUE))
		write_csv(age, "data/age_profile_ireland.csv")
	} else {
		age <- read_csv("data/age_profile_ireland.csv")
	}
	age
}


