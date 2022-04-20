# Q1 ----------------------------------------------------------------------
# 1. Load the data.table package and the murders dataset and 
# convert it to data.table object:
 
library(data.table)
library(dslabs)
data(murders)
murders <- setDT(murders)
# Add a murders column named rate with the per 100,000 murder rate 
murders[,rate:=total*100000/population]
murders %>% head()


# Q2 ----------------------------------------------------------------------
# 2. Add a column rank containing the rank, from highest to lowest murder rate.
murders[,rank:=rank(-rate)]
murders %>% head()

# Q3 ----------------------------------------------------------------------
# Show the state names and abbreviations in murders.
murders[,.(state,abb)]


# Q4 ----------------------------------------------------------------------
# Show the top 5 states with the highest murder rates. After we add 
# murder rate and rank, do not change the murders dataset just show the 
# result.
murders[rank<=5]


# Q5 ----------------------------------------------------------------------
# Create a new data frame called no_south that removes states from the 
# South region. How many states are in this category?
no_south <- murders[region!='South']
nrow(no_south)
# 34
no_south[region=='South']
#Empty data.table (0 rows and 7 cols): state,abb,region,population,total,rate.


# Q6 ----------------------------------------------------------------------
# Create a new data frame called murders_nw with only the states from 
# the Northeast and the West. How many states are in this category?
murders_nw<-murders[region %in% c('Northeast','West')]
nrow(murders_nw)
# 22

# check region
murders_nw[,.(region)]


# Q7 ----------------------------------------------------------------------
# Create a table called my_states that contains rows for states satisfying
# both the conditions: they are in the Northeast or West and the murder 
# rate is less than 1. Show only the state name, the rate, and the rank.

my_states <- murders[(region %in% c('Northeast','West')) & rate<1]
my_states[,.(state,rate,rank)]

# check region
my_states[,.(state,rate,rank,region)]

