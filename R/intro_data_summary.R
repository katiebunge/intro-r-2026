#load libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(summarytools)

#library(dplyr, tidyr, ggplot2)


#Load Raw Data 

raw_15min <- read.csv("data/raw/agg_15min_data.csv", stringsAsFactors = F)

#Exploring Structure of the Data
str(raw_15min)

#Preliminary Data Exploration 
head(raw_15min)
tail(raw_15min)

summary(raw_15min)

glimpse(raw_15min)

dfSummary(raw_15min)

#Call a specific column or row 
#Call a row
raw_15min[3,]
#Call a column
raw_15min[,2]


#Mean 
mean(raw_15min$speed)
mean(raw_15min$volume)

#Histogram
hist(raw_15min$volume)

#learn about filters 
#filtering is dplyr function
#introduce pipe function 
#introduce filtering 

occ_20plus <- raw_15min |> 
  filter(occupancy > 20)
occ10_sp80 <- raw_15min |> 
  filter(occupancy < 10 & speed > 80)
table(occ10_sp80$detector_id)

# Working with null values also called NA's
blank_example <- raw_15min |> 
  filter(is.na(speed))
# create a data frame excluding the NA values in the Speed variable 
complete_df <- raw_15min |> 
  filter(!is.na(speed))

subset_o10s80 <- occ10_sp80 |> 
  filter(detector_id %in% c(101185, 101176))


#RDS is compressed data file specifically for working with R 
#When you load data frame or table back in, it retains the formatting you did 
saveRDS(complete_df, "data/clean_data.rds")
