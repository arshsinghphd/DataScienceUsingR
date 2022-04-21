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

# Q3 ----------------------------------------------------------------------
x <- heights$height[heights$sex=="Male"]
length(x[x>69 & x<=72])/length(x)
# .3337
