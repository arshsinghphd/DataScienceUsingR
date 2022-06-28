library(gtools)
library(dplyr)
library(ggplot2)
rm(list=ls())


# Case Study - Finance ----------------------------------------------------
# Bank gives out 10^4 loans
# the default rate is 0.3 per period, and 
# you lose $200,000 in each foreclosure.
# loan = 180,000

set.seed(1)
n <- 10^4
p <- .03
loss <- (-2)*10^5
loan <- 180000

# A variable that represents bank's earnings each period
S <- sum(sample(c(loss,0), n, prob=c(p,(1-p)),replace=TRUE) )

# monte carlo repititions B
B <- 10^4
e <- replicate(B,sum(sample(c(loss,0), n, prob=c(p,(1-p)),replace=TRUE) ))
hist(e)


# expected value
mean(e) # monte carlo
(p*0+(1-p)*loss)*n # theoretical
# very close

# standard error
sd(e) # monte carlo
sqrt(n)*abs(loss)*sqrt(p*(1-p)) # theoretical
# also very close


# Deciding interest rate to make expected value of earnings as 0
r <- abs(loss)/loan * p/(1-p)
r
# 3.44%


# Interest rate be so that the chance of losing money is 1 in 20? 
# In math notation, what should the interest rate be so that Pr(S<0)=0.05
3.44/100*loan
qnorm(0,s=abs(loss-3.44/100*loan)*sqrt(p*(1-p)),mean=(p*3.44/100*loan+(1-p)*loss)*n)
