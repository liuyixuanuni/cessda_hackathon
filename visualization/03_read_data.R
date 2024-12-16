#-------------------------------------
# Fourth step: load and combine data 
#-------------------------------------
library(haven)
library(tidyverse)
# Initialize an empty list to store datasets
data_list <- lapply(data_filenames, function(file_name) {
  cat("Reading file:", file_name, "\n")
  
  # Read and filter the dataset
  read_dta(file.path(directory_data, file_name)) |>
    select(any_of(variables))
})

# Combine datasets into a single dataframe
combined_data <- bind_rows(data_list) 

# Remove all the labels
combined_data <- combined_data |>
    zap_label() |>
    zap_labels() |>
    zap_formats()
    
# Show message after combining the data
cat("\n\n\nData loading and combining finished.\n\n")
#-------------------------------------
# End of the code 
#-------------------------------------