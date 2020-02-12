# ====================================
# Event-driven programming
# ====================================
# Modifying `data` causes plot to redraw
# (First run `source('plot_watch.R')` )

data <- data.frame(x = 1:20, y = 1:20)

data$x <- data$x^2

data$y <- data$y^2

data <- data.frame(x = 1:20, y = 1:20)



# ====================================
# Basic demo of `later`
# ====================================
library(later)
done <- FALSE
later(
  function() {
    message("Hello world!")
    done <<- TRUE
  },
  delay = 5
)
while (!done) {
  run_now()
}


# ====================================
# Basic demo of `later`
# ====================================
# The later event loop runs even without `run_now`, whenever R is idle.

later(
  function() { message("Hello world!") },
  delay = 5
)


# ====================================
# WebSocket client
# ====================================
# (First run `source('ws_reverser.R')`)

library(websocket)
ws <- websocket::WebSocket$new("ws://127.0.0.1:4000/")

ws$onMessage(function(event) {
  message('Received: "', event$data, '"\n', sep = "")
})

ws$send("Hello, world!")


# ====================================
# Basic webserver with httpuv
# ====================================

library(httpuv)
s <- startServer("127.0.0.1", 5000,
  list(
    call = function(req) {
      body <- paste0("<h2>Time: ", Sys.time(),
        "<br>Path requested: ", req$PATH_INFO, "</h2>")

      list(
        status = 200L,
        headers = list('Content-Type' = 'text/html'),
        body = body
      )
    }
  )
)

browseURL("http://localhost:5000/")

# ====================================
# Web REPL demo
# ====================================
# First run `source('web_repl.R')`

browseURL("http://localhost:7000/")

# ====================================
# Shiny app
# ====================================
# The web REPL works even when this app is running. Also, this app watches
# `data`, so you can modify `data` from the web REPL and this app will update
# the plot.

shiny::runApp('shiny', port = 8000)

# ====================================
# Chromote demo
# ====================================
# First need to install chromote
# remotes::install_github('rstudio/chromote')
# This can be run in the web REPL at the same time that the Shiny app is running.

library(chromote)
b <- ChromoteSession$new(height = 600, width = 600)
b$Page$navigate("http://localhost:8000", wait_ = F)
b$screenshot(show=T, wait_ = F)
b$view()
