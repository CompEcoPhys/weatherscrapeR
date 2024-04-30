#' Station Lookup
#' 
#' Look up the 10 closest weather stations to the location entered
#' @param lat The latitude in decimal degrees
#' @param lon The longitude in decimal degrees
#' @param apikey Your Wunderground API key. This can be set ahead of time as an object.
#'
#'  
#' @export
station_lookup_pws <- function(lat, lon, apikey) {
  geocode <- paste0(lat, ",", lon)
  url_loc <- sprintf("https://api.weather.com/v3/location/near?geocode=%s&product=pws&format=json&apiKey=%s", geocode, apikey)
  jsonlite::fromJSON(url_loc) %>% as.data.frame()
}