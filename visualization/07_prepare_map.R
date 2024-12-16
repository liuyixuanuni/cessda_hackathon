#-------------------------------------
# Prepare for using function: plot_map 
#-------------------------------------
library(tidyverse)
library(sf) # geodata wrangling
library(giscoR) # get map of europe


# Keep the range 1:7, otherwise to NA (missing)
data <- combined_data |>
  mutate(across(all_of(education), ~ ifelse(. %in% 1:7, ., NA)))

data <- data %>% 
  group_by(cntry) %>% 
  summarise(r_mother = cor(eisced, eiscedm, use = "pairwise.complete.obs"),
            r_father = cor(eisced, eiscedf, use = "pairwise.complete.obs"))  # assuming isced is (quasi)metric.

countries <- gisco_get_nuts(
  year = "2021", epsg = "3035", resolution = "10",
  nuts_level = "0"
) %>% 
  mutate(cntry = case_when(CNTR_CODE == "EL" ~ "GR",
                           CNTR_CODE == "UK" ~ "GB",
                           TRUE ~ CNTR_CODE)) %>% 
  full_join(data) 

borders <- gisco_get_countries(epsg = "3035", year = "2024", resolution = "3") 
eu_borders <- borders %>%
  filter(CNTR_ID %in% countries$CNTR_CODE)

#-------------------------------------
# Source plot_map function
#-------------------------------------
source("visualization/05_plot_map.R")

#-------------------------------------
# Create the two plots using plot_map
#-------------------------------------
p3 <- plot_map(
  data = countries,
  borders = borders,
  eu_borders = eu_borders,
  fill_var = "r_mother",
  fill_label = "Mother-Child Correlation"
)

p4 <- plot_map(
  data = countries,
  borders = borders,
  eu_borders = eu_borders,
  fill_var = "r_father",
  fill_label = "Father-Child Correlation"
)
#-------------------------------------
# End of the code 
#-------------------------------------