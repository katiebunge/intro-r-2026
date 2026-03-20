#Installation document to bring in R packages for Intro to R TREC workshop 2026-03-18
#Alternative way to install packages without using install load package 


#Other useful packages include tidytext, 

pkgs <- c(
  "rio", #import/export by file extension
  "tidyverse", #dplyr, tidyr, ggplot2, readr, etc. 
  "lubridate", #date-time parsing
  "stringr", #string utilities
  "janitor", #clean_names(), tabyl(), etc. Useful for cleaning data 
  "scales", #percent_format and friends 
  # "tidycensus", #ACS API wrapper (optional bonus section)
  "summarytools",
  "textclean"
)

need <- pkgs[!pkgs %in% rownames(installed.packages())]
if (length(need)) install.packages(need)

invisible(lapply(pkgs, library, character.only = TRUE))
