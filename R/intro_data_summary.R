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
