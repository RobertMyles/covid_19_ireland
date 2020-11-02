get_excess_mortality <- function() {
	excess <- read_csv("https://raw.githubusercontent.com/Financial-Times/coronavirus-excess-mortality-data/master/data/ft_excess_deaths.csv") %>% 
		group_by(country, date) %>% 
		summarise(
			deaths = sum(expected_deaths),
			expected = sum(expected_deaths),
			excess_deaths = sum(excess_deaths)
			)
	
	
	# Ireland Covid deaths
	url <- "https://www.cso.ie/en/media/csoie/releasespublications/documents/br/measuringmortalityusingpublicdatasources/2020/BR-MPDSTBL1.xlsx"
	tmp <- tempfile(fileext = ".xlsx")
	GET(url = url, write_disk(tmp))
	c_names <- c("time", "f", "m", "total", "fp", "mp")
	excess_ire <- read_excel(tmp, skip = 1, col_names = c_names)
	unlink(tmp)
	excess_ire %>% 
		select(time, total) %>% 
		filter(!str_detect(time, "Total|is correct")) %>% 
		mutate(
			yr = str_extract(time, "[0-9]{4}"),
			mon = str_extract(time, "[A-Za-z]* ") %>% str_trim(),
			mnth = case_when(
				mon == "October" ~ "10",
				mon == "November" ~ "11",
				mon == "December" ~ "12",
				mon == "January" ~ "01",
				mon == "February" ~ "02",
				mon == "March" ~ "03",
				mon == "April" ~ "04",
				mon == "May" ~ "05",
				mon == "June" ~ "06",
				mon == "July" ~ "07",
				mon == "August" ~ "08",
				mon == "September" ~ "09"
			),
			date = glue("{yr}-{mnth}-01") %>% as_date()
		) %>% 
		select(date, total)
	
}