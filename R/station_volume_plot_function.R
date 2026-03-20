library(ggplot2)
library(dplyr)
library(tigris)

figure_function <- function(stid, measure){
  station_current <- stations_df |> 
    filter(stationid == stid) |> 
    right_join(starttime_seq, by = "starttime") |> 
    ggplot(aes(x = starttime, y = {{measure}})) +
    geom_line(color = "#a9c47f") +
    geom_point(color = "#007b5f") +
    scale_x_datetime(
      date_breaks = "1 day",
      date_labels = "%Y-%m-%d",
      guide = guide_axis(angle = 45)
    )+
    xlab(NULL) +
    theme_bw() + 
    geom_hline(yintercept = mean(stations_df$tot_volume),
               color = "#aaaaaa")
  station_current
}

