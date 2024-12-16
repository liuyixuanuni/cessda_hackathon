#-------------------------------------
# First step: set the environment 
#-------------------------------------
# Clear all
rm(list = ls())
# Check R information 
R.home() 
# Set virtual environment 
if (!require("renv")) install.packages("renv")
renv::init()
renv::status()
# Save the environment information 
# renv::snapshot()
# Activate and Reproduce the Environment 
# renv::restore()
# Deactivate renv in a project
# renv::deactivate()
#-------------------------------------
# End of the code 
#-------------------------------------