#' Remove all all-NA columns from a dataframe
remove_na <- function(x) {
	Filter(function(y) !all(is.na(y)), x)
}

# pretty facet labels
nice <- as_labeller(
	c(new_cases_smoothed_per_million = "Cases Per Million", 
		new_deaths_smoothed_per_million = "Deaths Per Million")
)