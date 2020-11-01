get_ireland <- function(get = FALSE) {
	if (get) {
		url <- "https://services-eu1.arcgis.com/z6bHNio59iTqqSUY/arcgis/rest/services/"
		page <- "COVID19_14_Day_Incidence_Rate_per_100k_LEA/FeatureServer/0/"
		query <- "query?where=1%3D1&outFields=ENGLISH,COUNTY,GUID,Pop2016,C19_P14_T,P14_100k,P14_100k_T,Ire_IncP14,EventDate&outSR=4326&f=json"
		
		ire <- fromJSON(glue("{url}{page}{query}"))
		lea <- st_read("data/lea-shp") %>% 
			as_tibble() %>% 
			select(ENGLISH, COUNTY, geometry) %>% 
			st_as_sf()
		ireland <- ire$features$attributes %>% 
			as_tibble() %>% 
			full_join(lea, by = c("ENGLISH", "COUNTY")) %>% 
			select(name = ENGLISH, county = COUNTY, 
						 covid_14days_per_100k = P14_100k, 
						 EventDate, geometry) %>% 
			mutate(
				date = as.POSIXct(EventDate/1000, origin = "1970-01-01"),
				name = str_remove(name, "\\)"),
				name = str_remove(name, "\\("),
				name = str_remove(name, "[0-9]"),
				name = str_trim(name),
				name = stringi::stri_trans_general(name, "Latin-ASCII"),
				name = str_to_title(name)
			) %>% 
			relocate(date) %>%
			select(-EventDate) %>% 
			st_as_sf()
		saveRDS(ireland, "data/ireland.RDS")
	} else {
		ireland <- readRDS("data/ireland.RDS")
	}
	ireland
}
