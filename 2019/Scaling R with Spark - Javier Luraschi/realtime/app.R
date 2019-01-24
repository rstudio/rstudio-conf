library(shiny)
library(wordcloud)
library(dplyr)

image_labeler <- function(df) {
  googleAuthR::gar_auth_service(
    scope = "https://www.googleapis.com/auth/cloud-platform",
    json_file = "cloudml.json")
  
  RoogleVision::getGoogleVisionResponse(
    df$image, download = FALSE)$description
}

ui <- fluidPage(
  titlePanel("Realtime Twitter Data with Spark and R"),
  mainPanel(
    plotOutput("aggregatePlot"),
    plotOutput("labelsPlot")
  )
)

server <- function(input, output) {
  twitterStream <- stream_read_kafka(
    sc,
    options = list(
      kafka.bootstrap.servers = "localhost:9092",
      subscribe = "tweets")) %>%
    transmute(value = as.character(value))
  
  twitterWords <- twitterStream %>%
    transmute(text = get_json_object(
      value, "$[0].text")) %>%
    filter(nchar(text) > 4) %>%
    ft_tokenizer("text", "split") %>%
    ft_stop_words_remover("split", "words") %>%
    transmute(word = explode(words)) %>%
    group_by(word) %>%
    summarize(total = n()) %>%
    reactiveSpark(intervalMillis = 5000)
  
  twitterLabels <- twitterStream %>%
    transmute(image = get_json_object(
      value, "$[0].media_url[0]")) %>%
    filter(nchar(image) > 5) %>%
    sdf_repartition(partitions = 10) %>%
    spark_apply(
      image_labeler,
      columns = list(label = "character")) %>%
    reactiveSpark(intervalMillis = 5000)
  
  output$aggregatePlot <- renderPlot({
    data <- twitterWords()
    wordcloud(
      data$word, data$total, scale = c(4,0.5),
      min.freq = 1, max.words = 30,
      colors = brewer.pal(8, "Dark2"))
  })
  
  output$labelsPlot <- renderPlot({
    data <- twitterLabels() %>%
      group_by(label) %>%
      summarize(total = n())
    
    wordcloud(
      data$label, data$total, scale = c(4,0.5),
      min.freq = 1, max.words = 30,
      colors = brewer.pal(8, "Dark2"))
  })
}

shinyApp(ui = ui, server = server)