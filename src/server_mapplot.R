map_plot <- function(input) {
  renderPlot({
    ggplot() +
      geom_sf(
        data = ireland, size = .02, colour = "black",
        aes(fill = covid_14days_per_100k, geometry = geometry)
      ) +
      theme_void() +
      theme(legend.position = "bottom") +
      guides(
        fill = guide_colourbar(
          "Cases in last 14 days per 100,000 people",
          title.position = "top",
          barwidth = 15, barheight = 0.8
        )
      ) +
      scale_fill_viridis_c(guide = "colourbar")
  })
}
  