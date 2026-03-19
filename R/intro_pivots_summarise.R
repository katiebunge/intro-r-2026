#setup 
#load libraries 

library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(viridis)

#New section 

#Load in data from RDS and detector csv 

clean_df <- readRDS("data/clean_data.rds")
detectors <- read.csv("C:/Users/bungek/OneDrive - Washington State Department of Transportation/Desktop/IntroRWorkshop/intro-r-2026/data/raw/detectors.csv")

#return unique or distinct detector records

#detectors_unique <- detectors |> 
  #distinct(stationid, .keep_all = T) |> # retains all variables
    #select(detectorid, stationid)

#aggregate total metrics by station ID 
#example of using joins in dplyr 

det <- detectors |> 
  filter(!is.na(end_date)) |> 
  select(detectorid, stationid)

df_stids <- clean_df |> 
  left_join(det, by = c("detector_id" = "detectorid"))


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

head(stations_df)

#graphing results 

st_speed_occ_fig <- stations_df |> 
  filter(stationid < 3140) |> 
  ggplot(aes(x = mean_speed , y = mean_occ)) +
  geom_point(aes(color = factor(stationid))) +
  scale_color_viridis(discrete = T) +
  theme_light() +
  facet_grid(stationid ~ .)

st_speed_occ_fig