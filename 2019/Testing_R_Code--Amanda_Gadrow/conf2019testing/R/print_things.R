#' Functions that return hello given a language.
#' @param language Character value.
#' @return A character value representing the word for "Hello" in the language.
#' @export
#' @examples
#' hello("maori")
#' goodbye("Maine")

hello <- function(language) {
  switch(language,
    "english" = "Hello",
    "spanish" = "Hola",
    "french" = "Bonjour",
    "maori" = "Koa",
    "developer" = "Hello, world!",
    "Maine" = "Hihowahya?"
  )
}

goodbye <- function(language) {
  switch(language,
     "english" = "Goodbye",
     "spanish" = "Adios",
     "french" = "Au revoir",
     "maori" = "Mihi",
     "Maine" = "Ayuh, bye!"
  )
}
