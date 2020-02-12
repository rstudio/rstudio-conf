if (!exists("data", .GlobalEnv)) {
  .GlobalEnv$data <- data.frame(x = runif(20), y = runif(20))
}

shinyApp(
  ui = fluidPage(
    actionButton("randomize", "Randomize"),
    plotOutput("plot")
  ),
  server = function(input, output) {
    last_value <- reactiveVal(NULL)

    observeEvent(input$randomize, {
      data <<- data.frame(x = runif(20), y = runif(20))
    })

    observe({
      invalidateLater(250)
      if (!identical(data, last_value())) {
        last_value(data)
      }
    })

    output$plot <- renderPlot({
      df <- last_value()
      plot(df$x, df$y)
    })
  }
)

