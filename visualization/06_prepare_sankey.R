#-------------------------------------
# Prepare for using function: plot_sankey 
#-------------------------------------
library(tidyverse)
library(viridis)
library(patchwork)
library(hrbrthemes)
library(circlize)
library(networkD3)

# Keep the range 1:7, otherwise to NA
data <- combined_data |>
  mutate(across(all_of(education), ~ ifelse(. %in% 1:7, ., NA))) 

#-------------------------------------
# Source plot_map function
#-------------------------------------
source("visualization/04_plot_sankey.R")

#-------------------------------------
# Create the two plots using plot_sankey
#-------------------------------------
p1 <- plot_sankey(data = data, begin_col = eiscedm, end_col = eisced)
p2 <- plot_sankey(data = data, begin_col = eiscedf, end_col = eisced)
#-------------------------------------
# End of the code 
#-------------------------------------