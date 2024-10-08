library(dslabs)
data("polls_us_election_2016")
library(tidyverse)
polls <- polls_us_election_2016 %>%
  filter(enddate >= "2016-10-31" & state == "U.S.")
head(polls)
library(dplyr)

# Q1 ----------------------------------------------------------------------
# ABC News/Washington Post poll
N <- polls$samplesize[1]
x_hat <- polls$rawpoll_clinton[1]/100
#assume p is not known, plug using x_hat
se_hat <- (x_hat * ( 1- x_hat)/N)**.5
x_hat -1.96 * se_hat
x_hat +1.96 * se_hat
CI <- c(.4492,.4908)


# Q2 ----------------------------------------------------------------------
# Now use dplyr to add a confidence interval as two columns, call them 
# lower and upper, to the object poll. Then use select to show the pollster, 
# enddate, x_hat,lower, upper variables. Hint: define temporary columns 
# x_hat and se_hat.
polls$x_hat<-polls$rawpoll_clinton/100 # convert from percent to decimal
polls$se_hat<-(abs(polls$x_hat * (1 - polls$x_hat)/polls$samplesize))**.5
polls$upper <- polls$x_hat +1.96 * polls$se_hat
polls$lower <- polls$x_hat -1.96 * polls$se_hat
data <- polls %>% select(pollster,enddate,x_hat,lower, upper)

# Q3 ----------------------------------------------------------------------
# 3. The final tally for the popular vote was Clinton 48.2% and Trump 46.1%. 
# Add a column, call it hit, to the previous table stating if the 
# confidence interval included the true proportion p=0.482 or not.
p <- 0.482
data$hit <- (p>data$lower) &  (p <data$upper)


# Q4 ----------------------------------------------------------------------
# 4. For the table you just created, what proportion of confidence intervals 
# included p?
round(mean(data$hit),4)
# .3143


# Q5 ----------------------------------------------------------------------
# 5. If these confidence intervals are constructed correctly, and the theory 
# holds up, what proportion should include p?
# 95%


# Q6 - 9 ----------------------------------------------------------------------
# 6. A much smaller proportion of the polls than expected produce confidence 
# intervals containing p. If you look closely at the table, you will see 
# that most polls that fail to include p are underestimating. The reason 
# for this is undecided voters, individuals polled that do not yet know who 
# they will vote for or do not want to say. Because, historically, 
# undecideds divide evenly between the two main candidates on election day, 
# it is more informative to estimate the spread or the difference between 
# the proportion of two candidates d, which in this election was 
# 0.482−0.461=0.021. Assume that there are only two parties and that d=2p−1, 
# redefine polls as below and re-do exercise 1, but for the difference.

polls <- polls_us_election_2016 %>% 
  filter(enddate >= "2016-10-31" & state == "U.S.")  %>%
  mutate(d_hat = rawpoll_clinton / 100 - rawpoll_trump / 100)

polls$se_hat<-(abs(polls$d_hat*(1-polls$d_hat)/polls$samplesize))**.5

polls$upper <- polls$d_hat +1.96 * polls$se_hat
polls$lower <- polls$d_hat -1.96 * polls$se_hat
data <- polls %>% select(pollster,enddate,d_hat,lower, upper)

p <- (0.482 - .461)
data$hit <- (p>=data$lower) &  (p<=data$upper)
plot(data$hit)
round(mean(data$hit),4)
# .1429



# Q9 ----------------------------------------------------------------------
# 9. Although the proportion of confidence intervals goes up substantially, 
# it is still lower than 0.95. In the next chapter, we learn the reason for
# this. To motivate this, make a plot of the error, the difference between 
# each poll’s estimate and the actual d=0.021. Stratify by pollster.

plot(data$d_hat-.021)
mean(data$d_hat-.021)
sd(data$d_hat-.021)
plot(data$d_hat-.021)

data %>% 
  ggplot(aes((d_hat-.021), pollster))+
  geom_point()


# Q10 ----------------------------------------------------------------------
# 10. Redo the plot that you made for exercise 9, but only for pollsters 
# that took five or more polls.
temp<-count(data,pollster)
data2 <- merge.data.frame(data, temp, by='pollster',all.x=FALSE, all.y=FALSE)
data2 <- data2 %>% filter(n>=5) 

sd(data2$d_hat-.021)
round(mean(data2$hit),4)
# .1042

data2 %>% 
  ggplot(aes((d_hat-.021), pollster))+
  geom_point()