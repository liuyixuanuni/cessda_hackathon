#-------------------------------------
# Prepare two plots in jpeg
#-------------------------------------

# Tracing Educational Pathways in Europe: Transmission from Mothers and Fathers
p1 <- p1 %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.fontFamily = 'Arial, sans-serif';
    }
  ")

p2 <- p2 %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.fontFamily = 'Arial, sans-serif';
    }
  ")

# Title and note styling
title_combined <- htmltools::tags$h2(
  "European Parent-to-child Educational Pathways", 
  style = "text-align:center; font-weight:bold; font-size:24px; color: #000000; margin-bottom:20px; font-family: 'Arial', sans-serif;"
)

note_combined <- htmltools::tags$p(
  htmltools::tags$span("Panel A (top): ", style = "font-weight: bold; font-size:16px; color: #000000;"),
  htmltools::tags$span("Mother (left) to child (right). ", style = "font-size:16px; color: #000000;"),
  htmltools::tags$br(),
  htmltools::tags$span("Panel B (bottom): ", style = "font-weight: bold; font-size:16px; color: #000000;"),
  htmltools::tags$span("Father (left) to child (right). ", style = "font-size:16px; color: #000000;"),
  htmltools::tags$br(),
  htmltools::tags$span("Data source: ", style = "font-weight: bold; font-size:14px; color: #000000;"),
  htmltools::tags$span("European Social Survey (ESS) round 4-11.", style = "font-size:14px; color: #000000;"),
  style = "text-align:center; font-style:italic; margin-top:10px; font-family: 'Arial', sans-serif;"
)

# Create the combined_plot for the two plots (p1 on top, p2 on bottom)
combined_plot <- htmltools::tagList(
  title_combined, 
  note_combined, 
  htmltools::tags$div(
    style = "display: flex; flex-direction: column; justify-content: center; align-items: center;",
    htmltools::tags$div(style = "width: 80%; margin-bottom: 20px;", p1),
    htmltools::tags$div(style = "width: 80%;", p2)
  )
)

# Save the combined HTML layout
htmltools::save_html(combined_plot, file = "combined_plot.html")

# Convert the HTML to a PDF using Chrome
pagedown::chrome_print("combined_plot.html", output = "combined_plot.pdf")

# Convert PDF to JPG
pdftools::pdf_convert("combined_plot.pdf", dpi = 600, format = "jpeg")

#-------------------------------------------------------------------------------

# Mapping Intergenerational Transmission of Educational (dis)advantage across Europe

ggsave("p3_plot.png", plot = p3, width = 12, height = 10, dpi = 600)
ggsave("p4_plot.png", plot = p4, width = 12, height = 10, dpi = 600)

# Title and note styling
title_combined <- htmltools::tags$h2(
  "Mapping Intergenerational Transmission of Educational (dis)advantage across Europe", 
  style = "text-align:center; font-weight:bold; font-size:24px; color: #000000; margin-bottom:20px; font-family: 'Arial', sans-serif;"
)

note_combined <- htmltools::tags$p(
  htmltools::tags$span("Panel A (top): ", style = "font-weight: bold; font-size:16px; color: #000000;"),
  htmltools::tags$span("Mother-Child Correlation. ", style = "font-size:16px; color: #000000;"),
  htmltools::tags$br(),
  htmltools::tags$span("Panel B (bottom): ", style = "font-weight: bold; font-size:16px; color: #000000;"),
  htmltools::tags$span("Father-Child Correlation. ", style = "font-size:16px; color: #000000;"),
  htmltools::tags$br(),
  htmltools::tags$span("Data source: ", style = "font-weight: bold; font-size:14px; color: #000000;"),
  htmltools::tags$span("European Social Survey (ESS) round 4-11.", style = "font-size:14px; color: #000000;"),
  style = "text-align:center; font-style:italic; margin-top:10px; font-family: 'Arial', sans-serif;"
)

# Create combined_plot2 for the two plots (p3 on top, p4 on bottom)
combined_plot2 <- htmltools::tagList(
  title_combined, 
  note_combined, 
  htmltools::tags$div(
    style = "display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;",  # Add text-align center to center the content
    htmltools::tags$div(
      style = "width: 80%; margin-bottom: 20px;", 
      htmltools::tags$img(src = "p3_plot.png", width = "80%")  
    ),
    htmltools::tags$div(
      style = "width: 80%;", 
      htmltools::tags$img(src = "p4_plot.png", width = "80%")  
    )
  )
)

# Save combined layout as an HTML file
htmltools::save_html(combined_plot2, file = "combined_plot2.html")

# Convert HTML to PDF using Chrome
pagedown::chrome_print("combined_plot2.html", output = "combined_plot2.pdf")

# Convert PDF to JPG with 600 DPI for high quality
pdftools::pdf_convert("combined_plot2.pdf", dpi = 600, format = "jpeg")
#-------------------------------------
# End of the code 
#-------------------------------------
