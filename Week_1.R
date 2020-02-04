# Welcome to R-Davis 2020 Week 1

1 + 100

#r uses the order of operations

3 + 5 *2

#use parentheses to force order of operations

(3 + 5)*2


#scientific notation

2 / 10000

1e9*8

#call functions in R

sin(3.14)

log(3)

exp(.5)

#nesting functions, interpreted from the inside out

sqrt(exp(4))


#comparisons in R

#R can do logical comparisons
# == is, ! not

1 == 1

1 == 3

1 != 2

#objects and assignments in R 
# <- assignment operator

x <- 1/4

log(x)

x <- 99

x <- x + 1 

this_is_my_object <- 90

#rules for naming objects, cannot have a space, cannot start with a number

#tab completion: enter different arguments into a function

log(this_is_my_object)

#for help can go to console and type in ?function and learn more from help file


log(3, 10) #there are two arguments to log for instance, base and x

log(x=3, base = 10) #the same as above

log(10, 3) #different from above, because R assumes base is second

log(base = 10, x = 3) #specifying the argument so like the first example even though not what R expects

log(x = 10, base = 3)

# R communications: error, 

log(aword) #error message, good to google

