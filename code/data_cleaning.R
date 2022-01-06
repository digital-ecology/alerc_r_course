

# Load libraries ----------------------------------------------------------

library(readr)
library(readxl)
library(dplyr)
library(janitor)
library(lubridate)


# Read data and clean -----------------------------------------------------

# data

records <- read_csv("data/myrecords.csv") 
records <- janitor::clean_names(records)

# convert dates

records$date <- lubridate::dmy(records$date)


# Data summaries ----------------------------------------------------------

# count of species

spp <- records %>% group_by(species) %>% count() %>% arrange(desc(n))
spp

# add common name into final table
spp2 <- records %>% 
  group_by(common_name, species) %>% 
  count() %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  select(common_name, species, n)
spp2

# count of species group

grp <- records %>%
  group_by(species_group) %>% 
  count(name = "grp_n") %>% 
  ungroup() %>% 
  select(species_group, grp_n)
grp

# filter data by date

# range tells us the date range for our data
range(records$date)

# filter 2020 records and count

y20 <- records %>% 
  mutate(year = lubridate::year(date)) %>% 
  filter(year == 2020) %>% 
  group_by(common_name, species) %>% 
  count()
y20


# Saving data -------------------------------------------------------------

# you may want to save data for use elsewhere, or to use in further analyses
# use readr to save as a csv

write_csv(grp, "data/species_group_summary.csv")
