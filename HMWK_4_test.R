#Assignment 4

#Base R

surveys <- read.csv("data/raw_data/portal_data_joined.csv") 

colnames(surveys)

surveys_base <- surveys[1:60, c(6,9,13)] #because base R does not read in the characters need to use numbers of positions for columns not column names

View(surveys_base)

challenge_base <- surveys_base[(surveys_base[ ,2] > 150), ] #selecting just the weights (column 2) that are greater than 150

#Tidyverse

library(tidyverse)

surveys2 <- read_csv("data/raw_data/portal_data_joined.csv")

surveys_tidy <- select(surveys2, species_id, hindfoot_length, year)

View(surveys_tidy)

challenge_tidy <- surveys_tidy %>% 
  filter(year == 1997) %>% 
  filter(species_id == "RM")


