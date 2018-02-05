#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(pixels)
library(jsonlite)
library(httr)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Connect Tensorflow Demo"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("url", label = "URL: ", value = "http://localhost:3939/content/2/predict")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h4("Draw some pixels"),
      shiny_pixels_output("pixels"),
      h3(textOutput("result")),
      actionButton("send", "Send"),
      actionButton("clear", "Clear")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$pixels <- shiny_render_pixels(show_pixels())
  observeEvent(input$send, {
    output$result <- renderText({
      url <- input$url
      pixels <- input$pixels
      req <- POST(url, body = toJSON(list(
        instances = list(
          list(pixels)
        )
      )))
      res <- content(req, type = "application/json")
      resarr <- unlist(res$predictions[[1]][[1]])
      paste("That looks like a", (0:9)[resarr == max(resarr)], "to me")
    })
  })
  observeEvent(input$clear, {
    output$pixels <- shiny_render_pixels(show_pixels())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

