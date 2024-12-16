#-------------------------------------
# Define the function: plot_sankey
#-------------------------------------
plot_sankey <- function(data, begin_col, end_col, labels = c(
  "less than lower secondary", 
  "lower secondary", 
  "lower tier upper secondary", 
  "upper tier upper secondary", 
  "advanced vocational sub-degree", 
  "lower tertiary education", 
  "higher tertiary education"
)) {
  
  # Filter data to exclude NAs in both the begin and end columns
  data <- data %>%
    filter(!is.na({{begin_col}}) & !is.na({{end_col}}))
  
  # Create a matrix-like data frame with counts
  data <- data %>%
    count({{begin_col}}, {{end_col}}) %>%
    pivot_wider(names_from = {{end_col}}, values_from = n, values_fill = 0) %>%
    select(-{{begin_col}}) %>%
    as.data.frame()
  
  # Check if the number of labels matches the number of rows and columns in data
  n_labels <- length(labels)
  n_rows <- nrow(data)
  n_cols <- ncol(data)
  
  if (n_labels != n_rows | n_labels != n_cols) {
    stop("The number of labels does not match the dimensions of the data matrix. 
          Number of rows: ", n_rows, ", Number of columns: ", n_cols, ", Number of labels: ", n_labels)
  }
  
  # Rename rows and columns with the provided labels
  rownames(data) <- labels
  colnames(data) <- labels
  
  # Pivot to long format
  data_long <- data %>%
    rownames_to_column() %>%
    gather(key = 'key', value = 'value', -rowname) %>%
    filter(value > 0)
  colnames(data_long) <- c("source", "target", "value")
  data_long$target <- paste(data_long$target, " ", sep = "")
  
  # Create a node data frame: it lists every entity involved in the flow
  nodes <- data.frame(name = unique(c(as.character(data_long$source), as.character(data_long$target))))
  
  # Reformat the data for networkD3 by matching real names to ids
  data_long$IDsource <- match(data_long$source, nodes$name) - 1
  data_long$IDtarget <- match(data_long$target, nodes$name) - 1
  
  # Prepare the colour scale
  ColourScal <- 'd3.scaleOrdinal().range(["#FDE725FF","#B4DE2CFF","#6DCD59FF","#35B779FF","#1F9E89FF","#26828EFF","#31688EFF"])'
  
  # Create the Sankey plot
  p1 <- sankeyNetwork(Links = data_long, Nodes = nodes,
                      Source = "IDsource", Target = "IDtarget",
                      Value = "value", NodeID = "name",
                      sinksRight = FALSE, colourScale = ColourScal, 
                      nodeWidth = 40, fontSize = 13, nodePadding = 20)
  
  # Return the plot
  return(p1)
}
#-------------------------------------
# End of the code 
#-------------------------------------