#' Weather scrape from range of dates
#' 
#' Collect data from a station between two dates. If the station was not active during the requested dates, you will receive a warning message.
#' 
#' @param stationID The station ID you want to obtain the weather data.
#' @param start_date The first day you want to start collecting data. In the format yyyy-mm-dd.
#' @param end_date The last day you want to start collecting data. In the format yyyy-mm-dd.
#' @param apikey Your APIKey from wunderground.
#' @export
weather_grab_range <- function(stationID, start_date, end_date, apikey) {
  # Create vector of dates in the range
  dates <- seq(as.Date(start_date), as.Date(end_date), by = 'day')
  
  # Initialize progress bar
  pb <- progress_bar$new(format = '[:bar] :percent ETA: :eta', total = length(stationID) * length(dates))
  
  # Call weather_grab function for each date and combine data into a single data frame
  weather_data <- map_dfr(stationID, function(station) {
    print(paste('  Processing station:', station))
    
    lapply(dates, function(date) {
      print(paste('Processing date:', date))
      result <- weather_grab(station, format(date, '%Y%m%d'), apikey)
      
      # Increment progress bar
      pb$tick()
      
      result
    }) %>% bind_rows() %>%
      mutate(stationID = station)  # Add a column for station ID
  })
  
  # Check if the resulting data frame is empty
  if (nrow(weather_data) == 0) {
    warning('No data collected for the specified date range.')
  }
  
  return(weather_data)
}