# Data watcher
#
# This will watch `data` for changes and plot it.
library(later)

data <- NULL
last_value <- NULL

plot_watch <- function() {
  if (!is.null(data) && !identical(data, last_value)) {
    plot(data$x, data$y)
    last_value <<- data
  }
  later(plot_watch, 0.25)
}

# Kick off the watcher
plot_watch()
