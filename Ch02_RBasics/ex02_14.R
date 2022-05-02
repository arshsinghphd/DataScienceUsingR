library(dslabs)
data(murders)
str(murders)

# 1. Compute the per 100,000 murder rate for each state and store it in an object 
## called murder_rate. Then use logical operators to create a logical vector named 
## low that tells us which entries of murder_rate are lower than 1.
murder_rate <- murders$total*100000/murders$population
low <- murder_rate<1
low

# 2. Now use the results from the previous exercise and the function which to 
## determine the indices of murder_rate associated with values lower than 1.
ind <- which(murder_rate<1)
ind

# 3. Use the results from the previous exercise to report the names of the states 
## with murder rates lower than 1.
murders$state[ind]

# 4. Now extend the code from exercises 2 and 3 to report the states in the Northeast 
## with murder rates lower than 1.
ind <- which(murder_rate<1 & murders$region == 'Northeast')
murders$state[ind]

# 5. Compute the murder rate for each state and the average of these numbers. 
## How many states are below the average?
ave <- mean(murder_rate)
ind <- murder_rate < ave
str(murders$state[ind])
# Ans 27

# 6. Use the match function to identify the states with abbreviations AK, MI, and IA.
ind <- match(c('AK','MI','IA'),murders$abb)
murders$state[ind]

# 7. Use the %in% operator to create a logical vector that answers the question: 
## which of the following are actual abbreviations: MA, ME, MI, MO, MU?
abblist <- c('MA','ME','MI','MO','MU')
realabb <- abblist%in%murders$abb

# 8. Extend the code you used in exercise 7 to report the one entry that is not 
## an actual abbreviation.
ind <- which(realabb!=TRUE)
abblist[ind]
