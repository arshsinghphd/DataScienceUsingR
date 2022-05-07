library(ggplot2)

# Q1 ----------------------------------------------------------------------
# 1. Assume the distribution of female heights is approximated by a normal distribution
# with a mean of 64 inches and a standard deviation of 3 inches. If we pick a female at 
# random, what is the probability that she is 5 feet or shorter?
pnorm(5*12,64,3)
# 0.09121

# Q2 ----------------------------------------------------------------------
# 2. Assume the distribution of female heights is approximated by a normal distribution 
# with a mean of 64 inches and a standard deviation of 3 inches. If we pick a female at 
# random, what is the probability that she is 6 feet or taller?
1-pnorm(6*12,64,3)
# 0.00383

# Q3 ----------------------------------------------------------------------
# 3. Assume the distribution of female heights is approximated by a normal distribution 
# with a mean of 64 inches and a standard deviation of 3 inches. If we pick a female at 
# random, what is the probability that she is between 61 and 67 inches?
pnorm(67,64,3)-pnorm(61,64,3)
# 0.6827


# Q4 ----------------------------------------------------------------------
# 4. Repeat the exercise above, but convert everything to centimeters. That is, multiply
# every height, including the standard deviation, by 2.54. What is the answer now?
pnorm(67*2.54,64*2.54,3*2.54)-pnorm(61*2.54,64*2.54,3*2.54)
# 0.6827


# Q5 ----------------------------------------------------------------------
# 5. Notice that the answer to the question does not change when you change units. This 
# makes sense since the answer to the question should not be affected by what units we
# use. In fact, if you look closely, you notice that 61 and 64 are both 1 SD away from 
# the average. Compute the probability that a randomly picked, normally distributed 
# random variable is within 1 SD from the average.
# 1 SD
pnorm(1,0,1)-pnorm(-1,0,1)
# 0.6827

# 2SD
pnorm(2,0,1)-pnorm(-2,0,1)
# 0.9545

# 3SD
pnorm(3,0,1)-pnorm(-3,0,1)
# 0.9973

# 6. To see the math that explains why the answers to questions 3, 4, and 5 are the same,
# suppose we have a random variable with average m and standard error s. Suppose we ask
# the probability of X being smaller or equal to a. Remember that, by definition, a is 
# (a−m)/s standard deviations s away from the average m. The probability is:
#   Pr(X≤a)
# Now we subtract m to both sides and then divide both sides by s:
#   Pr((X−m)/s≤(a−m)/s)
# The quantity on the left is a standard normal random variable. 
# It has an average of 0 and a standard error of 1. We will call it Z:
#   Pr(Z≤(a−m)/s)
# So, no matter the units, the probability of X≤a is the same as the probability of a 
# standard normal variable being less than (a−m)/s. If m is the average and s the
# standard error, which of the following R code would give us the right answer in every 
# situation:

# a. mean(X<=a)
# b. pnorm((a - m)/s)
# c. pnorm((a - m)/s, m, s)
# d. pnorm(a)
# (answer = b, pnorm assumed m=0, s=1)


# 7. Imagine the distribution of male adults is approximately normal with an expected 
# value of 69 and a standard deviation of 3. How tall is the male in the 99th percentile
x <- seq(-3, 3, length = 1000) * 3 + 69
y <- pnorm(x,mean=69,sd=3)
plot(x,y)
min(x[y>=0.99])
# 75.98


# 8. The distribution of IQ scores is approximately normally distributed. The average is 
# 100 and the standard deviation is 15. Suppose you want to know the distribution of 
# the highest IQ across all graduating classes if 10,000 people are born each in your 
# school district. Run a Monte Carlo simulation with B=1000 generating 10,000 IQ scores 
# and keeping the highest. Make a histogram.
B=10^3
m=100
s=15

max_iq <- function(){
  x <- seq(-3, 3, length = 10000) * s + m
  y <- pnorm(x,mean=m,sd=s)
  max(x[y>.99])
}

iqs <- replicate(B, max_iq())
hist(iqs)
