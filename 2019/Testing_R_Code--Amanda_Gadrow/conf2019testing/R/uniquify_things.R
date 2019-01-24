#' Find the unique values in a vector
#'
#' @param vec Input character vector.
#' @return A character vector.
#' @export
#' @examples
#' fruit <- c("apple", "pear", "banana", "apple")
#' uniquify(fruit)

clean <- function(vec) {
  values <- strsplit(vec, "\\, |\\,|\\|")
  flat_values <- unlist(values)
  trimmed_values <- stringr::str_trim(flat_values)
  trimmed_values
}

uniquify <- function(vec) {
  # vec <- as.character(vec)
  clean_values <- clean(vec)
  unique_values <- unique(clean_values)
  unique_values
}
