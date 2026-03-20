#setup 

library(tidyr)
library(dplyr)
library(lubridate)
library(ggplot2)
#library()
#library()
#library()

#   --Today's Topic: 
#   --Working with date and time in lubridate

#load in data tables 
#clean_df includes count data organized by detector id
#detectors includes contextual information about detectors by detector id 
clean_df <- readRDS("data/clean_data.rds")
raw_detectors <- read.csv("data/raw/detectors.csv", stringsAsFactors = F)

#display head of count table with Pacific timezone 
head(ymd_hms(clean_df$starttime, tz="US/Pacific"))


#Overwrite start time with correct time zone 
clean_df$starttime <- ymd_hms(clean_df$starttime, tz = "US/Pacific")

# --- 

det_st_ids <- raw_detectors |> 
  select(
    detectorid,
    stationid
  ) |> 
  distinct()

df_stids <- clean_df |> 
  left_join(det_st_ids, by = c("detector_id" = "detectorid"))

stations_df <- df_stids |> 
  group_by(
    stationid,
    starttime
  ) |> 
  summarise(
    mean_speed = mean(speed),
    tot_volume = sum(volume),
    mean_occ = mean(occupancy)
  )

str(stations_df)

# graph outputs 

station_1059 <- stations_df |> 
  filter(stationid == 1059) |> 
  right_join(starttime_seq, by = "starttime") |> 
  ggplot(aes(x = starttime, y = tot_volume)) +
  geom_line(color = "#007b5f") +
  geom_point(color = "#a9c47f") +
  scale_x_datetime(
    date_breaks = "1 day",
    date_labels = "%Y-%m-%d",
    guide = guide_axis(angle = 45)
  )+
  xlab(NULL) +
  theme_light() + 
  geom_hline(yintercept = mean(stations_df$tot_volume),
             color = "#aaaaaa")

station_1059


#create a new record or sequence to populate missing values
#create new vector sequence for counts that don't exist 

starttime_seq <- seq(
  from = ymd_hms("2026-02-01 00:00:00" , tz = "US/Pacific"),
  to = ymd_hms("2026-02-16 00:00:00", tz = "US/Pacific"),
  by = "15 min"
) |> 
  as.data.frame()
colnames(starttime_seq) <- c("starttime")


#clean_df_filter <- clean_df |> 
  #filter(detector_id == "101984")
  #filter(detector_id == "101186")
#str(clean_df_filter)
