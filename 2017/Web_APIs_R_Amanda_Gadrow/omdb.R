library(httr)
library(jsonlite)
library(xml2)
library(magrittr)

# Get a JSON response
clue_json <- GET("http://www.omdbapi.com/?t=clue&r=json")
stop_for_status(clue_json)  # convert HTTP errors to R errors
names(clue_json)
clue_json$status_code
clue_json$headers$`content-type`

# Parse with httr
json_text_content <- content(clue_json, as = "text")
json_text_content
json_parsed_content <- content(clue_json, as = "parsed")
json_parsed_content
names(json_parsed_content)
json_parsed_content$Plot

# Parse with jsonlite
clue <- json_text_content %>% 
  fromJSON
clue$Plot

# ------------------------------

# Get an XML response
clue_XML <- GET("http://www.omdbapi.com/?t=clue&r=xml")
stop_for_status(clue_XML)
clue_XML$headers$`content-type`

# Parse with httr
xml_text_content <- content(clue_XML, as = "text")
xml_text_content
xml_parsed_content <- content(clue_XML, as = "parsed")
xml_parsed_content

# Parse with xml2
xml_text_content %>%
  read_xml %>%
  xml_find_first("movie") %>%
  xml_attr("plot")
