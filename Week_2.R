# welcome to week 2!

R_DAVIS_2020

x <- 5
y <- x*2 #the argument is evaluated and the value is stored, i.e. not like excel spreadsheet functions

x <- 20 #x is changed but y above stays the same, we are not assigning the value of x*2 for y, we are storing the output of that equation in y

#tip don't assign object until know what to assign it as in order to reduce confusion 

#tip: tools, keyboard shortcuts help (can modify)

x <- 20
x*2
y <- x*2

#how R talks back

#errors
log_of_word <- log("word") #error is not an output
log_of_word

#errors stop the whole process and don't give outputs other than the error

#warnings
log_of_negative <- log(-2)  #NaNs are not a numbers
log_of_negative      #this object exists but its NaN, can                         lead to trickier problems, because                           output stored but nonsense

# messages aren't anything to worry about really
message("you guys are doing great")

#see course github course materials spreadsheets

#how we think about data and how R thinks about data

#tips for formatting data

#1) never modify raw data once entered, put in raw data folder, read only, to clean data, make a copy and put in clean data folder

#2) keep notes, plain text file in the same directory, can inlcude a notes column, put row above headers with a row of descriptions, such as units, of each column

#3) organize your data according to tidy data principles. Each column is a variable like "weight" or "site_ID"         each row is a single observation                             don't combine pieces of information in a single cell

#4) what to enter for missing data, NA is good (see github)

#5) export data CSV and TSV best format for most programs

#6) treat dates as individual columns, so a year gets a column, month gets a column, day gets a column, can stitch together as a date in R (weary of how excel treats dates)

#Github course materials project management with RStudio

getwd()   #return current working directory as a file path
setwd()   #set working directory to something else
#this is an example of an absolute filepath

#~ is shortcut for working directory, it refers to username

# hit tab within "" will pull up all the files within the working directory and this is an example of a relative file path

"data/portal_data_joined.csv"

#what if need to go up a level in the tree structure that is the directory, just move into the data folder, but if do need to go up a level it is "../"

#read function
read.csv()

#project management tips from github course materials
#Treat raw data as read only
#Treat generated output as disposable
#have separate directories for each of the following:
#data: ideally .csv files as these are flat, transparent, and universal. You may have other specialized formats as well. .rda and .rds are R-specific data files but you never need to use these.
#code: .R files, perhaps .do files if Stata is your thing, .py files for Python, etc.
#results: .png or .pdf files for plots; .tex or .txt files for tables
#papers: .tex if you write in LaTex, .doc for wrod, .Rmd for RMarkdown and .pdf or .html rendered documents

