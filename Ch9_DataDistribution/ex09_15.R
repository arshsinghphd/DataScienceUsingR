library(dslabs)
rm(list=ls())
data(heights)

# Q1 ----------------------------------------------------------------------
# 1. Define variables containing the heights of males and females like this:
male <- heights$height[heights$sex == "Male"]
female <- heights$height[heights$sex == "Female"]
# How many measurements do we have for each?
length(male)
length(female)

# Q2 ----------------------------------------------------------------------
# 2. Suppose we can’t make a plot and want to compare the distributions side 
# by side. We can’t just list all the numbers. Instead, we will look at the 
# percentiles. Create a five row table showing female_percentiles and 
# male_percentiles with the 10th, 30th, 50th, 70th, & 90th percentiles for 
# each sex. Then create a data frame with these two as columns.
p<-seq(.1,.9,.2)
female_percentiles <- quantile(female,p)
str(female_percentiles)
male_percentiles <- quantile(male,p)

df <- data.frame(male_percentiles,female_percentiles)
df

# Q3-7 are not programming related ----------------------------------------
# Q8 ----------------------------------------------------------------------
# What proportion of the data is between 69 and 72 inches (taller than 69, 
# but shorter or equal to 72)? Hint: use a logical operator and mean.
x <- heights$height[heights$sex=="Male"]
pr=(length(x[x<=72])-length(x[x<=69]))/length(x)
pr


# Q9 ----------------------------------------------------------------------
# Suppose all you know about the data is the average and the standard 
# deviation. Use the normal approximation to estimate the proportion you 
# just calculated.
p<- seq(.05,.95,.05)
ave=mean(heights$height[heights$sex=="Male"])
std=sd(heights$height[heights$sex=="Male"])
# pnorm gives prop_density less than or equal to q
pr_norm=pnorm(72,mean=ave,sd=std)-pnorm(69,mean=ave,sd=std)
pr_norm
(pr-pr_norm)/pr_norm
# 0.09, off by 10% or so


# Q10 ---------------------------------------------------------------------
# Notice that the approximation calculated in question nine is very close to
# the exact calculation in the first question. Now perform the same task for
# more extreme values. Compare the exact calculation and the normal approximation
# for the interval (79,81]. 
# How many times bigger is the actual proportion than the approximation?
pr=(length(x[x<=81])-length(x[x<=79]))/length(x)
pr
pr_norm=pnorm(81,mean=ave,sd=std)-pnorm(79,mean=ave,sd=std)
pr_norm
(pr-pr_norm)/pr_norm
# 0.61 off by 60% or so.


# Q11 ---------------------------------------------------------------------
# Approximate the distribution of adult men in the world as normally 
# distributed with an average of 69 inches and a standard deviation of 3 inches. 
# Using this approximation, estimate the proportion of adult men that are 
# 7 feet tall or taller, referred to as seven footers. 
# Hint: use the pnorm function.
pr_7ft=1-pnorm(7*12,mean=69,sd=3)
pr_7ft
# almost zero, 2.8e(-7)


# Q12 ---------------------------------------------------------------------
# There are about 1 billion men between the ages of 18 and 40 in the world. 
# Use your answer to the previous question to estimate how many of these men 
# (18-40 year olds) are seven feet tall or taller in the world?
n_7ft=10^9*pr_7ft 
n_7ft
# ~287


# Q13 ---------------------------------------------------------------------
# There are about 10 National Basketball Association (NBA) players that are 
# 7 feet tall or higher. Using the answer to the previous two questions, what
# proportion of the world’s 18-to-40-year-old seven footers are in the NBA?
p_7ft_NBA=10/n_7ft
p_7ft_NBA
# ~3.5% 
# 0.03488556


# Q14 ---------------------------------------------------------------------
#  Repeat the calculations performed in the previous question for Lebron 
# James’ height: 6 feet 8 inches. There are about 150 players that are at 
# least that tall.
pr_6_8=1-pnorm((6*12+8),mean=69,sd=3)
n_6_8=10^9*pr_6_8
pr_6_8_nba=150/n_6_8
pr_6_8_nba
# ~0.122% 


# Q15 ---------------------------------------------------------------------
# In answering the previous questions, we found that it is not at all rare 
# for a seven footer to become an NBA player. What would be a fair critique 
# of our calculations:
# a. Practice and talent are what make a great basketball player, not height.
# b. The normal approximation is not appropriate for heights.
# c. As seen in question 10, the normal approximation tends to 
#    underestimate the extreme values. It’s possible that there
#    are more seven footers than we predicted.
# d. As seen in question 10, the normal approximation tends to overestimate 
#    the extreme values. It’s possible that there are fewer seven footers 
#    than we predicted.
# (answer=c)
