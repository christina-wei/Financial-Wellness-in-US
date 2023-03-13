#### Preamble ####
# Purpose: Collection of helper functions
# Author: Christina Wei
# Date: 8 March 2023
# Contact: christina.wei@mail.utoronto.ca
# License: MIT
# Prerequisites: none

library(tidyverse)

# Generate percentage graph
generate_percentage_bar_graph = function(ggplot_data, xlabel = NULL, ylabel = "Percentage of Responses", angle = NULL, hjust = NULL, vjust = NULL) {

  # Reference code from https://sebastiansauer.github.io/percentage_plot_ggplot2_V2/
  ggplot_data + 
  geom_bar(aes(y = (..count..) / sum(..count..))) +
  scale_y_continuous(labels=scales::percent) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = angle, hjust = hjust, vjust = vjust)) + #rotate x-axis & smaller font
  labs (
      x = xlabel,
      y = ylabel
    )
}

# Generate heatmap
generate_heatmap = function(ggplot_data, xlabel = NULL, ylabel = NULL, position = NULL, angle = 45, hjust = 1, vjust = 1) {
  
  ggplot_data + 
  geom_tile() + 
  scale_fill_gradient2(low="white", high="darkblue", guide="colorbar") +
  theme(axis.text.x = element_text(angle = angle, vjust = vjust, hjust = hjust)) +
  theme(legend.position = position) + 
  labs (
    x = xlabel,
    y = ylabel,
  )
}

# Generate comparative bar graph
generate_compare_bar_graph = function(ggplot_data, xlabel = NULL, ylabel = NULL, fill_label = NULL, angle = NULL, hjust = NULL, vjust = NULL, nrow = NULL) {

  ggplot_data +
  geom_bar(stat="identity", position="dodge") +
  scale_y_continuous(labels=scales::percent) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = angle, vjust = vjust, hjust = hjust)) +  
  theme(legend.position="bottom") + 
  guides(fill=guide_legend(nrow=nrow, byrow=TRUE)) +
  labs(
    x = xlabel,
    y = ylabel,
    fill = fill_label
  )
}

# Generate time series graph with linear regression
generate_time_series_graph = function(ggplot_data, xlabel = NULL, ylabel = NULL, color_label = NULL, position = "bottom", nrow = 2) {
  
  ggplot_data +
  geom_smooth(method=lm, se=FALSE) + 
  geom_line() +
  scale_y_continuous(labels=scales::percent) +
  theme_minimal() + 
  theme(legend.position = position) + 
  guides(color=guide_legend(nrow=nrow, byrow=TRUE)) + #reference: https://datavizpyr.com/fold-legend-into-two-rows-in-ggplot2/
  labs(
    x = xlabel,
    y = ylabel,
    color = color_label
  )
}
