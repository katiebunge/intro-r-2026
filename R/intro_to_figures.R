#load libraries 

library(dplyr)
library(ggplot2)
library(tidyr)
library(plotly)

# load clean dataset

clean_df <- readRDS("data/clean_data.rds")

# generate first figure 
# graphs using ggplot2

speed_occ_fig <- clean_df |> 
  ggplot(aes(x = speed, y = occupancy, color = as.factor(detector_id))) + 
  geom_point()
speed_occ_fig

# change data type from numeric continuous to factor
# reassign column 

#one way you can change the data type - is permament.
#If you're unsure you want to commit this permanently, use
#nested functions. 
clean_df$detector_id <- as.factor(clean_df$detector_id)

#generate new figure object
#explore speed vs. volume 
# filter out some detectors 

speed_vol_fig <- clean_df |> 
  filter(detector_id < 101100) |> 
  # filter(speed > 40) |>
  ggplot(aes(x = speed, y = volume, color = as.factor(detector_id))) +
  geom_point()
speed_vol_fig

vol_speed_fig <- clean_df |> 
  ggplot(aes(x = volume, y = speed, color = as.factor(detector_id))) +
  geom_point()
vol_speed_fig


speed_vol_fig2 <- clean_df |> 
  # filter(detector_id < 101100) |> 
  ggplot(aes(x = volume, y = speed, color = as.factor(detector_id))) +
  geom_smooth(method = "lm")
speed_vol_fig2

#Plotly - adds navigatable pop-ups on ggplot 2 plot 
speed_vol_figly <- ggplotly(speed_vol_fig2)
speed_vol_figly