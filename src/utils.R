#' Remove all all-NA columns from a dataframe
remove_na <- function(x) {
	Filter(function(y) !all(is.na(y)), x)
}

# pretty facet labels
nice <- as_labeller(
	c(
		new_cases_smoothed_per_million = "Cases Per Million", 
		new_deaths_smoothed_per_million = "Deaths Per Million",
		icu_admissions_per_million = "ICU Admissions Per Million",
		positive_rate = "Positive Rate"
	)
)

# detect mobile
# https://g3rv4.com/2017/08/shiny-detect-mobile-browsers
mobileDetect <- function(inputId, value = 0) {
	tagList(
		singleton(tags$head(tags$script(src = "js/mobile.js"))),
		tags$input(id = inputId,
							 class = "mobile-element",
							 type = "hidden")
	)
}