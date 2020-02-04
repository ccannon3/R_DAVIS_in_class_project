
#na.rm

#Challenge part of HW4

library(tidyverse)

surveys2 <- read_csv("data/portal_data_joined.csv")
surveys_tidy <- surveys2 %>% 
  select(species_id, hindfoot_length, year) %>% 
  filter(!is.na(hindfoot_length)) #removing all NAs from hindfoot_length

surveys_tidy <- surveys_tidy[-c(1:31338), ]

surveys_challenge <- surveys_tidy %>% 
  filter(sepcies_id == "RM", year == 1997)


#Mutate Function! (in Tidyverse)

#use read_csv to load the surveys dataframe

surveys <- read_csv("data/portal_data_joined.csv")

#want to make a new column based on columns that already exist in dataframe

#example, weight in grams but want in kilograms

surveys_mut <- surveys %>% 
  mutate(weight_kg = weight/1000)  #first argument is new name of column, second what set first argument equal to; added to end of dataframe

surveys_mut <- surveys %>% 
  mutate(weight_kg = weight/1000 , weight_kg2 = weight_kg*2) #make as many new columns as you want by adding a comma and a new argument

# == exactly equal to, == logical questions (i.e., using a filter), is this exactly equal to this; = setting something

#first filter out NAs and then create a new column
surveys_mut2 <- surveys %>% 
  filter(!is.na(weight)) %>%  #if it is na, don't want
  mutate(weight_kg = weight/1000)

#if want to filter more then here is an example; the code runs in order such that filter NAs out of weight and then filters out species_id of NL and then create new column using the mutate call

surveys_mut2 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  filter(species_id != "NL") %>% 
  mutate(weight_kg = weight / 1000)

#can check this by to see all the unique entries for all the species_id in the surveys_mut2 data.frame
unique(surveys_mut2$species_id)

#Note: the order we pipe things matters

#Challenge: order of operations from Course Materials, using dplyr and tidyr; Note: the question is put in a weird order so that we figure out the order of operations

#my code
surveys_hindfoot_half <- surveys %>%
  select(species_id, hindfoot_length) %>%
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half = hindfoot_length/2)

#answer code
surveys_hindfoot_half <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half = hindfoot_length / 2) %>% 
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_half)

#note: !is.na how to get rid of NAs

#SPLIT, APPLY, COMBINE

#when manipulating data.frames assuming there are groups inherent to the data; i.e., mean, or maximum height of a taxa

#group variables, do something to them (i.e. mean), and then put back in that data.frame

#using two different functions, group_by and summarize

#example: find mean weight for each sex
surveys_group <- surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight)) #name new column is the first argument and then setting it (like mutate)

#still NAs in the data; need to remove; using na.rm to remove NAs
surveys_group <- surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

#group by multiple columns, sex and species_id
surveys_group <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

#calculate multiple things within a single summarize function
surveys_group <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE), min_weight = min(weight, na.rm = TRUE))

#Whats the difference between summarize and mutate?
#can use group_by within a mutate call

#using summarize (i.e., 92 variables), makes a data frame that is just 92 rows and 3 variables
sum_surveys <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

#mutate instead of summarize; adds a whole new column onto our surveys dataframe (a new column on old dataset); does not chunk down (i.e. 34786 observations) so will have repeated pairs
mut_surveys <- surveys %>% 
  group_by(sex, species_id) %>% 
  mutate(mean_weight = mean(weight, na.rm = TRUE))

#want to know multiple things in our data, can summarize on multiple things

surveys2 %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(min_weight = min(weight), 
            max_weight = max(weight))
#if run into a problem with group_by then can add the following function:
surveys2 %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(min_weight = min(weight), 
            max_weight = max(weight)) %>% 
  ungroup()

#JOINS

#datasets from multiple sources that want to combine together

#functions in dplyr that can help with us, resource jenny bryan johns tutorial Chapter 15 join tables

#many ways of joining data together

tail <- read_csv("data/tail_length.csv") #inbetween quotes and start searching and hit tab it will find, so don't need to remember where datasets are
tail #want to get the tail data with rest of surveys data

#tip: thing joining on are those two columns the same
#check this by using summary call:
summary(surveys2$record_id)
summary(tail$record_id)

#basic structure of a join
# join_function(first_data, second_data, by = column_to_join_by)

#the columns need to be named the same thing

#may need to rename a column; use rename function

#left-join: returns all of the rows from first table with all columns from first table and second table, if there is a row from first table without a match in second table then going to return a NA

#left-join used a lot
surveys_joined <- left_join(surveys2, tail, by = "record_id")

NL_data <- surveys %>% 
  filter(species_id == "NL")
NL_data

left_join(NL_data, tail, by = "record_id") #left-join, have a target dataset, the first one, and just need to add some columns from other dataset to it

#tables don't have to be the same length to join in this way

#join by multiple columns, need a unique identifier to match between tables, can be unique combination of multiple columns--for instance:

#join function(first_data, second_data, by = c("year", "month", "day"))

#RESHAPING DATA w/ pivot_longer and pivot_wider

#going to use tidyr: functions called gather or spread, there are newer versions called pivot_longer and pivot_wider

#make sure that data has structure to it that it is at the same level

#see course materials data manipulation with tidyr (at bottom)

#pivoting with tidyr

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

str(surveys_mz) #call function structure to see what the data looks like

#want to look like what we might collect in the field; goal here is to have a column for every genus

#want to retain plot_id column and a column for every genus with the values of mean weight for that plot_id

#can predict or know what the shape should be like
#two ways to do this:
unique(surveys_mz$genus) #unique identifiers in column
n_distinct(surveys_mz$genus) #number of distinct values 

#so now know 10 columns plus plot_id, how many rows?
n_distinct(surveys_mz$plot_id)
#should then have 24 rows, 11 total columns (plot id, everyone of distinct genera)

#from excel pivot tables, adding more columns, so going to be wider
wide_survey <- surveys_mz %>% 
  pivot_wider(names_from = "genus", values_from = "mean_weight")    #what column want to get names from goes first, then values, what want to get values from

#easy to do if want to see data like this

#pivot_longer (from wide to longer); often collect data in a wider format than what to analyze for; pivot_longer going to do more often; R likes to work with things in a longer format

#example pivot wide survey back to long format
wide_survey %>% 
  pivot_longer(cols = -plot_id, names_to = "genus", values_to = "mean_weight")  #usually more columns want to collapse than keep; all columns except plot_id want to collapse into one column; create column names to genus, and a column with values of mean_weight
surveys_mz
#when pivoted to being wider, filled in with NAs
#when pivot back to long format, those NAs are still here, so looks different than surveys_mz (what we started with)
