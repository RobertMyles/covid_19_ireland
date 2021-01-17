source("src/libs.R")
source("src/utils.R")
source("src/get_ireland.R")
source("src/get_age_profile.R")

today <- now()
checktime <- file.mtime("data/data_raw.csv")
checkval <- as.double(difftime(today, checktime, units = "days"))

if (is.na(checktime)) {
	message("No data -- pulling from GH.")
  source("src/get_data.R")
	ireland <- get_ireland(get = TRUE)
	age <- get_age_profile(get = TRUE)
} else if (checkval > 3) {
	message("Data outdated -- pulling fresh from GH")
  source("src/get_data.R")
	ireland <- get_ireland(get = TRUE)
	age <- get_age_profile()
} else {
	message("No need to update data.")
  df <- fread("data/data_raw.csv") %>% as_tibble()
  ireland <- get_ireland()
  age <- get_age_profile()
}
st_crs(ireland) <- st_crs(3857)
