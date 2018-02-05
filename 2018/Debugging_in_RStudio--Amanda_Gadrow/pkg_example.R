library(uniquify)

test_uniquify <- function() {
  planets <- read.csv2("planets.csv", stringsAsFactors = FALSE)
  unique_climate <- uniquify::uniquify_vec(planets$climate)
  unique_climate
}
