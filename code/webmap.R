
# Webmap ------------------------------------------------------------------

# This script creates a webmap of selected Special Areas for Conservation (SACs)


# load the required libraries
library(leaflet)
library(leaflet.extras)
library(sf)
library(htmlwidgets)

# read in the SAC dataset
sac <- st_read("data/SACs.shp")

# transform it into the WGS84 projection for the webmap
sac <- st_transform(sac, 4326)

# create a webmap using the SAC data
m <- leaflet(sac) %>% 
  addTiles() %>% 
  addPolygons()

m

# save the webmap as an html widget for incorporating into a website
saveWidget(m, "map.html")
