# Q1 ----------------------------------------------------------------------
# 1. Load the dplyr package and the murders dataset.
library(dplyr)
library(dslabs)
data(murders)
# You can add columns using the dplyr function mutate. 
# This function is aware of the column names and inside the function 
# you can call them unquoted:
murders <- mutate(murders, population_in_millions = population / 10^6)
# We can write population rather than murders$population. 
# The function mutate knows we are grabbing columns from murders.
# Use the function mutate to add a murders column named rate with 
# the per 100,000 murder rate as in the example code above. 
# Make sure you redefine murders as done in the example code above 
# ( murders <- [your code]) so we can keep using this variable.
murders <- mutate(murders, rate = total / population * 10^5)
head(murders)

# Q2----------------------------------------------------------------------
# 2. If rank(x) gives you the ranks of x from lowest to highest, 
# rank(-x) gives you the ranks from highest to lowest. 
# Use the function mutate to add a column rank containing the rank, 
# from highest to lowest murder rate. 
# Make sure you redefine murders so we can keep using this variable.
murders <- mutate(murders, rank = rank(-rate))
head(murders)

# Q3 ----------------------------------------------------------------------
# Use select to show the state names and abbreviations in murders. 
# Do not redefine murders, just show the results.
select(murders, state, abb)

# Q4 ----------------------------------------------------------------------
# Use filter to show the top 5 states with the highest murder rates. 
# After we add murder rate and rank, do not change the murders dataset, 
# just show the result. Remember that you can filter based on the rank column.
filter(murders, rank<6)


# Q5 ----------------------------------------------------------------------
# Create a new data frame called no_south that removes states from the 
# South region. How many states are in this category? 
no_south <-filter(murders, region!='South')
nrow(no_south)
# (answer=34)


# Q6 ----------------------------------------------------------------------
# Create a new data frame called murders_nw with only the states 
# from the Northeast and the West. How many states are in this category?
murders_nw<- filter(murders,region %in% c('Northeast','West'))
nrow(murders_nw)
# (answer=22)


# Q7 ----------------------------------------------------------------------
# Create a table called my_states that contains rows for states satisfying 
# both the conditions: it is in the Northeast or West and 
# the murder rate is less than 1. 
# Use select to show only the state name, the rate, and the rank.
my_states<-filter(murders,region%in%c('Northeast','West') & rate<1)
select(my_states,state,rate,rank)

