#### Preamble ####
# Purpose: Collection of helper functions
# Author: Christina Wei
# Date: 8 March 2023
# Contact: christina.wei@mail.utoronto.ca
# License: MIT
# Prerequisites: none

library(tidyverse)

generate_percentage_bar_graph = function(ggplot_data, xlabel = NULL, ylabel = "Percentage of Responses", angle = NULL, hjust = NULL, vjust = NULL) {

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
