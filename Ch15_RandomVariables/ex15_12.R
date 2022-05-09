library(gtools)
library(dplyr)
library(ggplot2)
rm(list=ls())


# Q1 ----------------------------------------------------------------------
# 1. In American Roulette you can also bet on green. There are 18 
# reds, 18 blacks and 2 greens (0 and 00). What are the chances the
# green comes out?
2/38


# Q2 ----------------------------------------------------------------------
# 2. The payout for winning on green is $17 dollars. This means 
# that if you bet a dollar and it lands on green, you get $17. 
# Create a sampling model using sample to simulate the random 
# variable X for your winnings. 
x <- sample(c(-1,17), 1, prob = c(18/19, 1/19))
#rm(x)

# Q3 ----------------------------------------------------------------------
# 3. Compute the expected value of X.
p=1/19 #Pr(green)
E_x <- (p*(17) + (1-p)*(-1))
E_x 


# Q4 ----------------------------------------------------------------------
# 4. Compute the standard error of X.
SE_x <- abs(17 - 1)*sqrt(p*(1-p))
SE_x

# Q5 ----------------------------------------------------------------------
# 5. Now create a random variable S that is the sum of your 
# winnings after betting on green 1000 times. 
set.seed(1)
n <- 10^3
S <- sum(sample(c(-1,17), n, prob = c(18/19, 1/19),replace=TRUE))
S
# Q6 ----------------------------------------------------------------------
# 6. What is the expected value of S?
ex_S <- 1000*E_x
ex_S
# -52.63

# Q7 ----------------------------------------------------------------------
# 7. What is the standard error of S?
se_S <- 1000*SE_x
se_S
# 3572.75

# Q8 ----------------------------------------------------------------------
# 8. What is the probability that you end up winning money? 
# Hint: use the CLT.
mu <- ex_S
se <- se_S
pnorm(0,mean=mu,s=se)


# Q9,10 ----------------------------------------------------------------------
# 9. Create a Monte Carlo simulation that generates 1,000 outcomes of S. 
# Compute the average and standard deviation of the resulting list to confirm 
# the results of 6 and 7.
# 10. Now check your answer to 8 using the Monte Carlo result.

set.seed(1)
B <- 10^3
n <- 10^3
mean(replicate(B,sum(sample(c(-1,17), n, prob = c(18/19, 1/19),replace=TRUE))))
# -52.62
sqrt(n)*sd(replicate(B,sum(sample(c(-1,17), n, prob = c(18/19, 1/19),replace=TRUE))))
# 4149.53

# 11. The Monte Carlo result and the CLT approximation are close, but not that
# close. What could account for this? 1,000 simulations is not enough. If we 
# do more, they match. The CLT does not work as well when the probability of 
# success is small. In this case, it was 1/19. If we make the number of 
# roulette plays bigger, they will match better. The difference is within 
# rounding error. The CLT only works for averages.
set.seed(1)
B <- 10^4
n <- 10^3
mean(replicate(B,sum(sample(c(-1,17), n, prob = c(18/19, 1/19),replace=TRUE))))
# -52.23
sqrt(n)*sd(replicate(B,sum(sample(c(-1,17), n, prob = c(18/19, 1/19),replace=TRUE))))
# 4012.02
