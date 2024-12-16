#-------------------------------------
# Define the function: plot_map
#-------------------------------------
plot_map <- function(data, borders, eu_borders, fill_var, fill_label, 
                                       low_color = "darkgreen", high_color = "darkred", 
                                       na_color = "#e1e1e1", 
                                       panel_bg_color = "#97dbf2", panel_border_color = "grey10",
                                       text_color = "grey0", 
                                       border_fill_color = "#e1e1e1", border_line_color = "black") {
  ggplot(data) +
    # Background
    geom_sf(data = borders, fill = border_fill_color, color = NA) +
    geom_sf(aes(fill = .data[[fill_var]])) +  # Use .data for tidy evaluation
    geom_sf(data = eu_borders, fill = NA, color = border_line_color, linewidth = .15) +
    # Center in Europe: EPSG 3035
    coord_sf(xlim = c(2377294, 6500000), ylim = c(1413597, 5228510)) +
    scale_fill_continuous(low = low_color, high = high_color, 
                          na.value = na_color) +
    guides(fill = guide_legend(nrow = 1)) +
    theme_void() +
    theme(
      text = element_text(colour = text_color),
      panel.background = element_rect(fill = panel_bg_color),
      panel.border = element_rect(fill = NA, color = panel_border_color),
      plot.title = element_text(hjust = 0.5, vjust = -1, size = 12),
      plot.subtitle = element_text(
        hjust = 0.5, vjust = -2, face = "bold",
        margin = margin(b = 10, t = 5), size = 12
      ),
      plot.caption = element_text(
        size = 8, hjust = 0.5, margin =
          margin(b = 2, t = 13)
      ),
      legend.text = element_text(size = 7),
      legend.title = element_text(size = 7),
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.text.position = "bottom",
      legend.title.position = "top",
      legend.key.height = rel(0.5),
      legend.key.width = unit(.1, "npc")
    ) +
    # Annotate and labels
    labs(fill = fill_label)
}
#-------------------------------------
# End of the code 
#-------------------------------------