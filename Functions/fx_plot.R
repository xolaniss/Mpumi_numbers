fx_plot <-
function (data, plotname = " ", 
          variables_color = 12, 
          scale = "free", 
          ncol = NULL) {
  ggplot(
    pivot_longer(data,-Date, names_to = "Series", values_to = "Value"),
    aes(x = Date, y = Value, col = Series)
  ) +
    geom_line() +
    facet_wrap (. ~ Series, scale = scale, ncol = ncol) +
    theme_bw() +
    theme(
      legend.position = "none",
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    theme(
      text = element_text(size = 8),
      strip.background = element_rect(colour = "white", fill = "white"),
      axis.text.x = element_text(angle = 90),
      axis.title = element_text(size = 7),
      plot.tag = element_text(size = 8)
    ) +
    labs(x = "", y = plotname) +
    scale_color_manual(values = pnw_palette("Winter", variables_color))
}


pivot <- function(data){
  result <- 
  pivot_longer(data,-Date, names_to = "Series", values_to = "Value") 
  result
}

fx_recode_plot <-
  function (data, plotname = " ", variables_color = 12) {
    ggplot(
      data,
      aes(x = Date, y = Value, col = Series)
    ) +
      geom_line() +
      facet_wrap (. ~ Series, scale = "free", labeller = label_parsed) +
      theme_bw() +
      theme(
        legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()
      ) +
      theme(
        text = element_text(size = 8),
        strip.background = element_rect(colour = "white", fill = "white"),
        axis.text.x = element_text(angle = 90),
        axis.title = element_text(size = 8),
        plot.tag = element_text(size = 8)
      ) +
      labs(x = "", y = plotname) +
      scale_color_manual(values = pnw_palette("Winter", variables_color))
  }

fx_nopivot_plot <-
  function (data, plotname = " ", variables_color = 12, scale = "free", ncol = 3) {
    ggplot(
      data = data,
      aes(x = Date, y = Value, color = Series)
    ) +
      geom_line() +
      facet_wrap (. ~ Series, scale = scale, ncol = ncol) +
      theme_bw() +
      theme(
        legend.position = "none",
        legend.key.height= unit(0.5, 'cm'),
        legend.key.width= unit(0.5, 'cm'),
        legend.text = element_text(size=6),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()
      ) +
      theme(
        text = element_text(size = 8),
        strip.background = element_rect(colour = "white", fill = "white"),
        axis.text.x = element_text(angle = 90),
        axis.title = element_text(size = 5),
        plot.tag = element_text(size = 8)
      ) +
      labs(x = "", y = plotname) +
      scale_color_manual(name = "", values = pnw_palette("Winter", variables_color))
  }
