rm(list=ls())
library(tidyverse)
library(dplyr)
library(HistData)
data("Galton")
x <- Galton$child

# Q1,2 --------------------------------------------------------------------
av1 <- mean(x)
sd1 <- sd(x)
m1 <- median(x)
mad1 <- mad(x)


# Q3,4,5,6 ----------------------------------------------------------------
x_with_error <- x
x_with_error[1] <- x_with_error[1]*10
av2 <- mean(x_with_error)
sd2 <- sd(x_with_error)
m2 <- median(x_with_error)
mad2 <- mad(x_with_error)

av2 - av1 
sd2 - sd1
m2 - m1
mad2 - mad1


# Q7 ----------------------------------------------------------------------
# How could you use exploratory data analysis to detect that an error was made?

# a. Since it is only one value out of many, we will not be able to detect this.
# b. We would see an obvious shift in the distribution.
# c. A boxplot, histogram, or qq-plot would reveal a clear outlier.
# d. A scatterplot would show high levels of measurement error.
# (answer: c)
qqnorm(x_with_error)
qqline(x_with_error)


# Q8 ----------------------------------------------------------------------

error_avg <- function(x,k){
  x[1] = k
  mean(x)
}
x <- Galton$child
error_avg(x,10^4)
error_avg(x,-10^4)
