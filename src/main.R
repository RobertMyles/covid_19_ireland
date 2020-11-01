source("src/libs.R")
source("src/utils.R")
source("src/get_ireland.R")

today <- now()
checktime <- file.mtime("data/data_raw.csv")
checkval <- as.double(difftime(today, checktime, units = "days"))

if (is.na(checktime)) {
	message("No data -- pulling from GH.")
  source("src/get_data.R")
	ireland <- get_ireland(get = TRUE)
} else if (checkval > 3) {
	message("Data outdated -- pulling fresh from GH")
  source("src/get_data.R")
	ireland <- get_ireland(get = TRUE)
} else {
	message("No need to update data.")
  df <- read_csv("data/data_raw.csv", col_types = cols())
  ireland <- get_ireland()
}
