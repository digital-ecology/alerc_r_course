library(readr)
library(dplyr)
library(janitor)
library(ggplot2)

# read in data

records <- read_csv("data/myrecords.csv")
records <- janitor::clean_names(records)

# plot species by record count

a <- ggplot(records, aes(species)) +
  geom_bar()
a

b <- ggplot(records, aes(species_group)) +
  geom_bar()
b

c <- ggplot(grp, aes(species_group, grp_n)) +
  geom_col()
c

d <- spp2 %>% 
  filter(n > 3) %>% 
  ggplot(aes(x=common_name, fill=common_name, y=n)) +
  geom_col()+
  theme_light() +
  theme(axis.text.x=element_text(angle=90,hjust=1)) +
  ggtitle("Most recorded species") +
  labs(x = "Common name", y = "No. of records", fill = "Common name")
d


