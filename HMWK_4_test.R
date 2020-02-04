#Tidyverse

library(tidyverse)

surveys2 <- read_csv("data/portal_data_joined.csv")

surveys_tidy <- select(surveys2, species_id, hindfoot_length, year)

View(surveys_tidy)

challenge_tidy <- surveys_tidy %>% 
  filter(year == 1997) %>% 
  filter(species_id == "RM")