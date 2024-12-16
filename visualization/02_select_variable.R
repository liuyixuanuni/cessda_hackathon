#-------------------------------------
# Third step: choose variables 
#-------------------------------------
# ID and weight variables
id <- c(
  "essround", # ESS round
  "idno",  # Respondent's identification number
  "cntry", # Country
  "anweight"  # Analysis weight
)
# Education variables
education <- c(
  "eiscedm",  # Mother's highest level of education, ES - ISCED
  "eiscedf",  # Father's highest level of education, ES - ISCED
  "eiscedp",  # Partner's highest level of education, ES - ISCED
  "eisced"    # Highest level of education, ES - ISCED
)
# Analysis variables
variables <- c(
  id, 
  education
)
#-------------------------------------
# End of the code 
#-------------------------------------