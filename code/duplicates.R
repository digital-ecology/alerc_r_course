

# load libraries ----------------------------------------------------------

library(readr)
library(dplyr)
library(lubridate)
library(janitor)

# read data ---------------------------------------------------------------

dupes <- read_csv("data/duplicates.csv")
dupes <- janitor::clean_names(dupes)

# we get a warning with the following code. why?
# some dates are just years, others are year ranges
# we can either run the code and generate NAs, or we can leave it as a character field
# matching characters is harder, but we can try that.
# how important is a year for detecting duplicates? we may not know if we remove them
dupes$date <- dmy(dupes$date)

# add unique id column

dupes <- dupes %>% mutate(id = row_number())


# group_by to find duplicates ---------------------------------------------

# we can use dplyr::group_by() to group together records to see if there are any duplicates

d1 <- dupes %>% 
  group_by(common_name, date, grid_ref) %>% 
  add_count() %>% # counts the number of records in each group and adds it in a column
  ungroup()

# use dplyr::filter() to filter out records with a count > 1

d1 <- d1 %>% 
  filter(n>1)

max(d1$n)

# too many records that are not duplicates
# add a new grouping variable

d2 <- dupes %>% 
  group_by(common_name, date, grid_ref, location) %>% 
  add_count() %>% 
  ungroup()

d2 <- d2 %>% 
  filter(n>1)

max(d2$n)

# records with n=17 all share a common name, but are in fact different records
# add latin_name as a grouping variable

d3 <- dupes %>% 
  group_by(latin_name, date, grid_ref, location) %>% 
  add_count() %>% 
  ungroup()

d3 <- d3 %>% 
  filter(n>1)

max(d3$n)

# this is pretty good and seems to have captured most duplicates, but if we add the
# abundance_sex_stage var to our filter, we may be able to do better

d4 <- dupes %>% 
  group_by(latin_name, abundance_sex_stage, date, grid_ref, location) %>% 
  add_count() %>% 
  ungroup()

d4 <- d4 %>% 
  filter(n>1) %>% 
  arrange(latin_name, abundance_sex_stage)

max(d4$n) # now max is 2, which is good

# so we have identified duplicates, but we want to record that without deleting them. how?
# add a duplicate column
# then join these data back to the original data

dupes_clean <- d4 %>% 
  mutate(duplicates = "duplicate") %>% 
  select(id, duplicates)

clean <- left_join(dupes, dupes_clean, by = "id")

# now our original data has a column which identifies which are duplicates