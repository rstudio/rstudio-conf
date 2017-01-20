#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$histogram <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    col <- input$col
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = col, border = 'white')
    
  })
  
  output$xyplot <- renderPlot({
    plot(faithful)
  })
  
})
