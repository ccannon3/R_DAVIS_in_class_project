#Welcome to Week 4 of R-Davis

#Let's review what we ended on last week: Factors

#note: homework should take about 30 minutes

#Factors as data:


sex <- as.factor(c("male", "female", "male", "male"))

sex

#why list two levels the way it does is alphabetical

class(sex)
typeof(sex)    
#factors are integer vectors with character labels attached to them; can't add more levels after assigned

#potential to reorder factor (i.e., categories low, medium, high)

sex <- factor(sex, levels = c("male", "female"))
sex

#converting factors to characters (when we want to use factors, usually want character data to remain character data)

as.character(sex)  #now quotations, tells us this is a character factor

#ex: pulled in data with years but came in as factors but want to convert to numeric and can be a little trickier

year_fct <- as.factor(c(1990, 1983, 1977, 1998, 1990))

as.numeric(year_fct) #get back numbers 1-4, assigned each character vector a value for earliest and later years, DOESN'T WORK

#need to convert years to characters and then can convert to numbers all in one step
as.numeric(as.character(year_fct)) #r works outside in

#how to change nature of vectors in the environment
year_fct <- as.numeric(as.character(year_fct)) 

#renaming factors and levels within factors

levels(sex) 

levels(sex)[1] #use [] to pull out one of the vectors
levels(sex)[1] <- "MALE"
levels(sex)

# In-Class Challenge (from website: Course Materials: How R thinks about data: Factors)

levels(sex)[1] <- "M"
levels(sex) [2] <- "F"

sex <- factor(sex, levels = c("F", "M"))
sex


#Starting with Data

#using base R to read in dataset portal_data_joined.csv in raw_data folder

surveys <- read.csv("data/portal_data_joined.csv") #this is a data.frame

#in environment, pull down on arrow next to "surveys" to get information about the dataset (13 variables =13 columns, observations are rows); can click on surveys and pops up and can look at as .csv or excel file
#is this tidy data? Mostly 
#Tidy data: every row is a single observation and every column has one variable

(class(surveys)) #check what kind of type surveys is
#data.frame is just vectors with the same length

nrow(surveys) #number of rows in data.frame
head(surveys) #the first 6 rows
colnames(surveys) #names of all the columns 
summary(surveys) #summary of everything in the dataframe

#In-Class Challenge (website: Course Materials: Starting with Data in R, using str function)

str(surveys) #structure of an R object, alternative to summary, display compactly abbreviated contents of lists (i.e., nested objects)
#answers to questions: 1) class=data.frame 2) rows=34786, columns=13, 3) factors 4) 48

# $ call individual columns
#convert species id to character 
surveys$species_id <- as.character(surveys$species_id)
str(surveys)

#check the data, command unique, pull-out unique identifiers in a column
unique(surveys$species_id)
unique(surveys$species)



#Indexing and subsetting dataframes

#brackets have two dimensions for dataframes
#[row, column]

surveys[1,1] #element in first row in the first column
surveys[1, 6]

surveys[,3] #if there is a black space R thinks we want just the third column

#if want to pull out the first 3 elements of the seventh column
surveys[1:3, 7] # : shortcut for I want from here to here

#all columns rows 1-6
surveys[1:6,]
surveys[6,] #just the sixth row

#exclude the first column (take everything but this row, use - sign)
surveys[ , -1]

surveys[-c(7:34786),]#same as head function, just the first six rows

#also call columns by their names

surveys["species_id"] #pulling out just that column all rows

surveys[1:6, "species_id"] #rows 1-6 and all in the species_id column

#In-Class Challenge, Starting with Data in R, subsetting a dataframe

surveys_200 <- surveys[200, ]
nrow(surveys_200)
tail(surveys_200)
n_rows <- nrow(surveys)
surveys_last <- surveys[n_rows, ]
surveys_middle <- surveys[n_rows / 2, ]
surveys_head <- surveys[-(7:n_rows), ]


#TIDYVERSE

#how to install a package, install.packages("tidyverse") (now always installed)

#Load package using library(tidyverse), need to load into every project

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

surveys #nicer than what popped out with base R
#double means integers, character are characters
#tibble a data.frame that prints nicely
class(surveys)
# tbl_df, table of data.frame"

#dplyr is an awesome package
# great for subsetting data.frames

#select and filter 9two functions in dplyr)

#select is for columns, and filter is for rows

surveys_new <- select(surveys, plot_id, species_id, weight) #select (data.frame, variables I want), fast way to select columns I want

#filtering data in rows

surveys_plot3 <- filter(surveys, plot_id == 3) #rows with only plot_ids that are 3

#lets talk about pipes

#pipe a function that allows you do multiple functions in a data.frame at the same time

#can select and filter at the same time

#I want all weights greater than 5 and only the columns, species_id, sex, weight

#intermediate steps
surveys2 <- filter(surveys, weight > 5)

surveys_sml <- select(surveys2, species_id, sex, weight)

#can use a pipe to do this in 1 step, useful for doing many things all at once in data.frame, creating one new object

#pipe, take output of one function and pipe it into another function

#a pipe looks like this %>% 
#keyboard shortcuts Mac: command+shift+m

#redoing above using a pipe

surveys_sml2 <- surveys %>% 
  filter(weight > 5) %>% 
  select(species_id, sex, weight) #R knows we are in surveys and that we are filtering out the weight greater than 5 





