# Q1 ----------------------------------------------------------------------
library(tidyverse)
data("murders")
# combine two lines of code below using pipe
murders <- mutate(murders, rate =  total / population * 100000, 
                  rank = rank(-rate))
select(murders,state, rate,rank)
# answer
murders %>% mutate(
                  rate =  total / population * 100000, 
                  rank = rank(-rate)
                  ) %>% select(
                    state, rate,rank)

# Q2 ----------------------------------------------------------------------
# Reset murders to the original table by using data(murders). 
# Use a pipe to create a new data frame called my_states that considers 
# only states in the Northeast or West which have a murder rate lower than 1, 
# and contains only the state, rate and rank columns. 
# The pipe should also have four components separated by three %>%
data(murders) 
my_states <- murders %>% mutate(
                              rate =  total / population * 100000,
                              rank = rank(-rate)
                                ) %>% filter(
                                (region== 'Northeast'| region=='West') & rate<1
                                ) %>% select(
                                  state,rate,rank)
nrow(my_states)
head(my_states)
