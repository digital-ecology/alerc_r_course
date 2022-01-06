

library(dplyr)
library(sf)


# get some data
# I have converted the SAC spatial data to a dataframe to keep things simple
sac <- st_read("data/SACs.shp")
sac <- as.data.frame(sac)

# basic stats

mean(sac$area)
median(sac$area)
sd(sac$area)
min(sac$area)
max(sac$area)
range(sac$area)

# add some random groups to the data
# demonstrate group mean calculation with dplyr
# this adds five groups randomly to the data, change the '1:5' bit to see what happens

sac <- sac %>% 
  mutate(group = sample(1:5, size = n(), replace = TRUE))

# convert area to hecatres
sac <- sac %>% 
  mutate(area_ha = area/10000)

# calculate group mean and standard deviation
sac %>% 
  group_by(group) %>%
  summarise(mean_area = mean(area_ha), st_dev = sd(area_ha))
  
