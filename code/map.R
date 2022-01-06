library(sf)
library(tmap)
library(tmaptools)

sac <- st_read("data/SACs.shp")

sac <- st_transform(sac, 4326)

# read OSM raster data
osm <- tmaptools::read_osm(sac, ext=1.1)

m <- tm_shape(osm) + 
      tm_rgb() +
    tm_shape(sac) + 
      tm_fill("blue") + 
      tm_borders("blue")
m

tmap_save(m, "maps/map.png")
