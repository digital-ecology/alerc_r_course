
# Webmap ------------------------------------------------------------------

# This script creates a webmap of selected Special Areas for Conservation (SACs)


# load the required libraries
library(leaflet)
library(leaflet.extras)
library(leaflet.esri)
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

library(leaflet.esri)

m <- leaflet() %>% 
  addTiles() %>% 
  setView(-1.2576985, 51.751975, 11) %>% 
  addEsriFeatureLayer(url = "https://services.arcgis.com/JJzESW51TqeY9uat/arcgis/rest/services/SSSI_England/FeatureServer/0",
                      popupProperty = "SSSI_NAME",
                      group = "SSSI")
m

m <- leaflet() %>% 
  addTiles() %>% 
  setView(-1.2576985, 51.751975, 11) %>% 
  addPolygons(data = sac, group = "SAC", color = "red") %>% 
  addEsriFeatureLayer(url = "https://services.arcgis.com/JJzESW51TqeY9uat/arcgis/rest/services/SSSI_England/FeatureServer/0",
                      popupProperty = "SSSI_NAME",
                      group = "SSSI") %>% 
  addLayersControl(baseGroups = "Basemap", overlayGroups = c("SSSI", "SAC"))
m
