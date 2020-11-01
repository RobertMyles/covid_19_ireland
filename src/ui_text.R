
title_panel <- titlePanel("New Cases & Deaths, Covid-19")

intro_div <- div(
	p("For selected countries. Cases shown are per million people."),
	div(
		span("Data comes from "),
		a("Our World in Data", href = "https://ourworldindata.org/"),
		span(", specifically "),
		a("here", href = "https://covid.ourworldindata.org/data/owid-covid-data.csv"),
		span(", and from the "),
		a("European Centre for Disease Prevention and Control.",
			href = "https://www.ecdc.europa.eu/en/publications-data/download-data-hospital-and-icu-admission-rates-and-current-occupancy-covid-19"
		)
	),
	div(
		span(
			"Note the differing y-axes on the plots. ICU admissions data is weekly and so has been interpolated 
  	to a daily count using the "
		),
		a("forecast package.", href = "https://github.com/robjhyndman/forecast"),
		span("For code, see "),
		a("here.", href = "https://github.com/robertmyles/covid_19_ireland")
	)#,
	# div("Warning: map may take some time to render.")
)
