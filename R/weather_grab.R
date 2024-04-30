#' Single day weather grab
#' 
#' Collect weather data for a single day from a single station.
#' @param stationID The station ID you want to obtain the weather data.
#' @param date A single day to obtain weather data. In the format 'yyyy-mm-dd'. e.g., '2021-09-17'
#' @param apikey Your APIKey from wunderground.
#' 
#' @export
#' 
weather_grab <- function(stationID, date, apikey) {
  url <- sprintf('https://api.weather.com/v2/pws/history/hourly?stationId=%s&format=json&units=m&date=%s&apiKey=%s', stationID, format(date, "%Y%m%d"), apikey)
  jsonlite::fromJSON(url) %>% as.data.frame()
}