#' Plotting Station Locations
#' 
#' Plot the locations of the nearest weather stations from the chosen location. Each station is classified as -1, 0, or 1. This will visualize the geographic location and provide information on the quality of data. 
#' ' @param data_frame The dataframe from station_lookup_pws().
#' @export
plot_pws <- function(data_frame) {
  df_pws <- data_frame
  df_pws$color <- ifelse(df_pws$location.qcStatus == -1, "red",
                         ifelse(df_pws$location.qcStatus == 0, "orange", "green"))
  
  leaflet(df_pws) %>%
    addTiles() %>%
    addCircleMarkers(
      lng = ~location.longitude,
      lat = ~location.latitude,
      color = ~color,
      popup = ~paste("Station: ", location.stationId , "<br>ID: ", location.stationId, "<br>QC Status: ", location.qcStatus),
      label = ~paste("Station: ", location.stationId )
    ) %>%
    addLegend(colors = c("red", "orange", "green"), labels = c("-1", "0", "1"), title = "QC Status")
}
