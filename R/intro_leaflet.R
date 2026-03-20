#mapping demonstration


library(dplyr)
library(tidyr)
library(leaflet)
#library(usmaps) - this is a good intro package for categorizing data on political boundaries
library(sf)
library(tigris)


#locating traffic counter stations on the map 

raw_stations <- read.csv("data/raw/stations.csv", stringsAsFactors = F)

stations <- raw_stations |> 
  filter(end_date == "") |> 
  select(
    stationid,
    locationtext,
    lon,
    lat,
    milepost,
    agency
  )

#create map 

stations_map_filtered <- stations |> 
  filter(lat > 0) |> 
  as.data.frame()

stations_map <- stations_map_filtered |> 
  leaflet() |> 
  addProviderTiles(providers$Stadia.OSMBright) |> 
  addCircleMarkers(
    lng = stations$lon,
    lat = stations$lat,
    color = "#007b5f",
    radius = 2,
    popup = paste("Stationid: ", stations$station_id, "<br>", 
                  "Description: ", stations$locationtext, "<br>",
                  "Agency: ", stations$agency, "<br>",
                  "Milepost: ", stations$milepost, "<br>",
                  "Latitude: ", stations$lat, "<br>",
                  "Longitude: ", stations$lon)
  )
stations_map

#using tigris - tiger shapefiles 

wa_counties <- counties(state = "WA")

wa_counties <- st_transform(wa_counties, crs = '+proj=longlat +datum=WGS84')

wa_county_map <- wa_counties |>  
  leaflet() |> 
  addProviderTiles(providers$Esri.OceanBasemap) |> 
  addPolygons(
    highlightOptions = highlightOptions(color = "white", weight = 2, 
                                        bringToFront = T),
    popup = paste(
      "NAME: ", wa_counties$NAME, "<br>"
    )
  )
wa_county_map