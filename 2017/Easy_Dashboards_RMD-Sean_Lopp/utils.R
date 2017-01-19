

#' Map Weather Descritption to Icon
#'
#' @param desc A weather description from the weather underground API
#'
#' @return An icon code with a corresponding ion weather icon
mapDescIcon <- function(desc){
  desc
  desc = sub(pattern = "Light", replacement = "", desc, fixed = TRUE)
  desc = sub(pattern = "Heavy", replacement = "", desc, fixed = TRUE)
  curIcon = "ion-android-sunny"
  if (grepl(pattern = "*Snow*|*Ice*", x = desc))
    curIcon = "ion-ios-snowy"
  if (grepl(pattern = "*Rain*|*Drizzle*|*Hail*", x = desc))
    curIcon = "ion-ios-rainy-outline"
  if (grepl(pattern = "*Cloud*|*Overcast*|*Fog*", x= desc))
    curIcon = "ion-ios-cloud-outline"
  curIcon
}


#' Map Temperature to Icon
#'
#' @param tmp Temperature in F
#'
#' @return A font-awesome thermometer icon filled based on the temp
mapTempIcon <- function(tmp){
  tempIcon = "fa-thermometer-half"
  if(tmp < 15)
    tempIcon = "fa-thermometer-empty"
  if(tmp > 30 )
    tempIcon = "fa-thermometer-full"
  tempIcon
}

#' Know Ski Areas
#' Function serves as a storage location for known Ski Areas
#' A "known" ski area includes:
#'  - resorts: name used in the app
#'  - ids: id mapping the name to a SnoCountry resort code
#'  - weather_underground: lat/lon of the resort used for weather calls and mapping
#' @return
#' @export
getKnownAreas <- function(){
  data.frame(
    resorts = c("Abasin", 
                "Breckenridge",
                "Copper",
                "Eldora",
                "Keystone",
                "Loveland",
                "Purgatory"),
    ids = c(303001,
            303007,
            303009,
            303011,
            303014,
            303015,
            303017),
    weather_underground = c("39.6423,-105.8717",
                            "39.4817,-106.0384",
                            "39.5014,-106.1516",
                            "39.9372,-105.5827",
                            "39.5589,-105.9106",
                            "39.6800,-105.8979",
                            "37.6269,-107.8360"
                            ),
    stringsAsFactors = FALSE
  )
}


# Helper functions to parse the KnownArea dataframe

returnAreaID <- function(area_name) {
 areas <- getKnownAreas()
 areas[which(areas$resorts==area_name),2]
}

returnAreaLatLon <- function(area_name){
  areas <- getKnownAreas()
  areas[which(areas$resorts==area_name),3]
  
}


#' Get SnoCountry Data
#' Queries the snocountry API to get the daily report for the resort
#' @param area_name resort name
#'
#' @return list containing daily resort information such as snow totals & open runs
getAreaData <- function(area_name){
  id <- returnAreaID(area_name)
  base_url <- "http://feeds.snocountry.net/conditions.php?apiKey=SnoCountry.example"
  results <- fromJSON(paste0(base_url, "&ids=", id))
  if(results$totalItems != 1)
    stop("Error accessing Snocountry API")
  results$items
}

#' Get Weather Underground Weather Data
#' gets the current weather by querying Weather Underground
#' @param area_name 
#'
#' @return
getCurrentWeather <- function(area_name){
  loc <- returnAreaLatLon(area_name)
  # TODO: Hide API key!
  base_url <- "http://api.wunderground.com/api/****YOUR_API_KEY*****/conditions/q/"
  results <- fromJSON(paste0(base_url, loc, ".json"))
  while(is.null(results$current_observation)){
    results <- fromJSON(paste0(base_url, loc, ".json"))
  }
  results$current_observation 
}

#' flexdashboard Gauge with %
#'
#' @param data Data frame with column percent
#' @param rowId Which row of the dataframe should this gauge show?
#' @param label Label used under value
#'
#' @return Gauge element to be used
createPercentGauge <- function(percent, label) {
  gauge(percent,
        min = 0, 
        max = 100,
        symbol = "%", 
        label = label,
        gaugeSectors(success = c(80,100),
                     danger = c(0,80), 
                     colors = c("#2c62ba","warning","#f4a34b")))
}
