# 
# 
# df %>% 
# 	mutate(
# 		new_deaths_rescaled = scale(new_deaths_per_million) %>% as.vector() %>% 
# 			forecast::tsclean() %>% as.vector(),
# 		new_cases_rescaled = scale(new_cases_per_million) %>% as.vector() %>% 
# 			forecast::tsclean() %>% as.vector()
# 	) %>% 
# 	select(location, date, new_deaths_rescaled, new_cases_rescaled) %>% 
# 	pivot_longer(cols = c(new_cases_rescaled, new_deaths_rescaled)) %>% 
# 	filter(location %in% c("Ireland", "Spain", "United Kingdom")) %>% 
# 	ggplot(aes(x = date, colour = location, y = value)) +
# 	geom_line() +
# 	facet_wrap(~name, ncol = 1)
