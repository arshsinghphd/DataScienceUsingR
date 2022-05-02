library(dplyr)
library(ggplot2)
library(dslabs)
rm(list=ls())
data(heights)
data(murders)

# Q1 ----------------------------------------------------------------------
p <- murders %>% ggplot()
class(p)
#"gg"     "ggplot"

# Q2 ----------------------------------------------------------------------
# Remember that to print an object you can use the command print or simply type the object. 
# Print the object p defined in exercise one and describe what you see.
# a. Nothing happens.
# b. A blank slate plot.
# c. A scatterplot.
# d. A histogram
# (Answer=b)
print(p)

# Q3 ----------------------------------------------------------------------
# Using the pipe %>%, create an object p but this time associated with the
# heights dataset instead of the murders dataset.
p <- heights %>% ggplot()

# Q4 ----------------------------------------------------------------------
class(p)
#"gg"     "ggplot"


# Q5 ----------------------------------------------------------------------
# Now we are going to add a layer and the corresponding aesthetic mappings. 
# For the murders data we plotted total murders versus population sizes.
# Explore the murders data frame to remind yourself what are the names for
# these two variables and select the correct answer.

# a. state and abb.
# b. total_murders and population_size.
# c. total and population.
# d. murders and size.
# (answer=c)
head(murders)

# Q6 ----------------------------------------------------------------------
# To create the scatterplot we add a layer with geom_point. 
# The aesthetic mappings require us to define the x-axis and y-axis variables, 
# respectively. So the code looks like this:
# murders %>% ggplot(aes(x = , y = )) +
#  geom_point()
# Fill this out with the correct variable names

murders %>% ggplot(aes(x = population/10^6, y = total)) +
            geom_point()


# Q7 ----------------------------------------------------------------------
# Remake the plot but now with total in the x-axis and population in the y-axis
murders %>% ggplot(aes(x = total,y = population/10^6)) +
  geom_point()


# Q8 ----------------------------------------------------------------------
# murders %>% ggplot(aes(population, total)) + geom_label()
# will give us the error message: 
# Error: geom_label requires the following missing aesthetics: label
# Why is this?
# a. We need to map a character to each point through the label argument in aes.
# b. We need to let geom_label know what character to use in the plot.
# c. The geom_label geometry does not require x-axis and y-axis values.
# d. geom_label is not a ggplot2 command.
# (answer=b)
murders %>% ggplot(aes(population/10^6, total)) + geom_label()


# Q9 ----------------------------------------------------------------------
# Rewrite the code above to use abbreviation as the label through aes

# note that the points are not added yet:
murders %>% ggplot(aes(population/10^6, total)) +
            geom_label(aes(label=abb))
# OR 
murders %>% ggplot(aes(population/10^6, total,label=abb)) +
            geom_label()


# Q10 ----------------------------------------------------------------------
# Change the color of the labels to blue. How will we do this?
# a. Adding a column called blue to murders.
# b. Because each label needs a different color we map the colors through aes.
# c. Use the color argument in ggplot.
# d. Because we want all colors to be blue, we do not need to map colors, 
#    just use the color argument in geom_label.
# (Answer= d)


# Q11 ---------------------------------------------------------------------
# Rewrite the code above to make the labels blue.
murders %>% ggplot(aes(population/10^6, total)) +
  geom_label(aes(label=abb),color='blue')
# OR
murders %>% ggplot(aes(population/10^6, total,label=abb)) +
  geom_label(color='blue')


# Q12 ---------------------------------------------------------------------
# Now suppose we want to use color to represent the different regions. 
# In this case which of the following is most appropriate:
# a. Adding a column called color to murders with the color we want to use.
# b. Because each label needs a different color we map the colors through 
#    the color argument of aes .
# c. Use the color argument in ggplot.
# d. Because we want all colors to be blue, we do not need to map colors, just use the color argument in geom_label.
# (answer=b)


# Q13 ---------------------------------------------------------------------
# Rewrite the code above to make the labels’ color be determined by the state’s region.
murders %>% ggplot(aes(population/10^6, total)) +
  geom_label(aes(label=abb,color=region))


# Q14 ---------------------------------------------------------------------
# Now we are going to change the x-axis to a log scale to account for the fact 
# the distribution of population is skewed. Let’s start by defining an object 
# p holding the plot we have made up to now: 
p <- murders %>% 
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label() 
p
# To change the y-axis to a log scale we learned about the scale_x_log10() 
# function. Add this layer to the object p to change the scale and render the
# plot.
p + scale_y_log10()


# Q15 ---------------------------------------------------------------------
# Repeat the previous exercise but now change both axes to be in the log scale.
p <- murders %>% 
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()
p + scale_x_log10() +
  scale_y_log10()

# Q16 ---------------------------------------------------------------------
# Now edit the code above to add the title “Gun murder data” to the plot.
p <- murders %>% 
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()
p + scale_x_log10() +
  scale_y_log10()+
  ggtitle('Gun muder data')

