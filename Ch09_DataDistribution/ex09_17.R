library(dbplyr)
library(dslabs)
library(ggplot2)
rm(list=ls())

# Q1 ----------------------------------------------------------------------
# 1. Now we are going to use the geom_histogram function to make a histogram 
# of the heights in the height data frame. When reading the documentation 
# for this function we see that it requires just one mapping, the values to
# be used for the histogram. Make a histogram of all the plots.
# What is the variable containing the heights?
# a. sex
# b. heights
# c. height
# d. heights$height
# (answer: d)

data(heights)
?geom_histogram
p <- geom_histogram(mapping=aes(heights$height))


# Q2 ----------------------------------------------------------------------
# Now create a ggplot object using the pipe to assign the heights data to 
# a ggplot object. Assign height to the x values through the aes function.
p <- heights %>% ggplot(aes(height))


# Q3  ---------------------------------------------------------------------
# Now we are ready to add a layer to actually make the histogram. Use the 
# object created in the previous exercise and the geom_histogram function 
# to make the histogram.
p + geom_histogram()


# Q4 ----------------------------------------------------------------------
# Use the binwidth argument to change the histogram made in the previous 
# exercise to use bins of size 1 inch.
p + geom_histogram(binwidth=1)  


# Q5 ----------------------------------------------------------------------
# Instead of a histogram, we are going to make a smooth density plot. In 
# this case we will not make an object, but instead render the plot with 
# one line of code. Change the geometry in the code previously used to make
# a smooth density instead of a histogram.
qplot(heights$height,geom='density')


# Q6 ----------------------------------------------------------------------
# Now we are going to make a density plot for males and females separately. 
# We can do this using the group argument. We assign groups via the 
# aesthetic mapping as each point needs to a group before making the 
# calculations needed to estimate a density.
heights %>% qplot(height,group=sex,color=sex,geom='density',data=.)
                  
#Q7
heights %>% qplot(height,color=sex,geom='density',data=.)

#8
heights %>% 
  ggplot(aes(height, fill = sex)) + 
  geom_density(alpha=.2) 
