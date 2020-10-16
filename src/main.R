source("src/libs.R")
source("src/utils.R")

today <- now()
checktime <- file.mtime("data/data_raw.csv")
checkval <- as.double(difftime(today, checktime, units = "days"))

if (is.na(checktime)) {
	message("No data -- pulling from GH.")
  source("src/get_data.R")
} else if (checkval > 3) {
	message("Data outdated -- pulling fresh from GH")
  source("src/get_data.R")
} else {
	message("No need to update data.")
  df <- read_csv("data/data_raw.csv",
  							 col_types = cols())
}

df <- df %>% 
	filter(
		continent %in% c("Europe", "North America"),
		!location %in% c(
			"Bonaire Sint Eustatius and Saba", "Antigua and Barbuda",
			"British Virgin Islands", "Anguilla", "Aruba", "Belize",
			"Cayman Islands", "Curacao", "Saint Vincent and the Grenadines",
			"Sint Maarten (Dutch part)", "Turks and Caicos Islands",
			"United States Virgin Islands"
										 )
		)