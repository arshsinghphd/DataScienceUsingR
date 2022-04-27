# Preamble ----------------------------------------------------------------
library(tidyverse)
library(dslabs)
library(gridExtra)
options(digits = 3)
data(us_contagious_diseases)


# Q1 ----------------------------------------------------------------------
# 1. Pie charts are appropriate:
# A. When we want to display percentages.
# B. When ggplot2 is not available.
# C. When I am in a bakery.
# D. Never. Barplots and tables are always better.
# (Answer: D)


# Q2 ----------------------------------------------------------------------
# (answer=b)


# Q3 ----------------------------------------------------------------------
# (answer=c)

# Q4,5 ----------------------------------------------------------------------
# Redefine the state object so that the levels are re-ordered. 
# Print the new object state and its levels so you can see that the vector
# is not re-ordered by the levels.
dat <- us_contagious_diseases %>%  
  filter(year == 1967 & disease=="Measles" & !is.na(population)) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting)

dat %>% ggplot(aes(state, rate)) +
  geom_bar(stat="identity") +
  coord_flip() 

# Answer
dat <- us_contagious_diseases %>%  
  filter(year == 1967 & disease=="Measles" & !is.na(population)) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting) %>%
  mutate(state=reorder(state,rate))

dat %>% ggplot(aes(state, rate)) +
  geom_bar(stat="identity") +
  coord_flip() 

# Q6 ----------------------------------------------------------------------
# What is the main problem with this interpretation?
# (answer=c) It does not show all the data. We do not see the variability
# within a region and it’s possible that the safest states are not in the
# West.

# Q7 ----------------------------------------------------------------------
# Make a boxplot of the murder rates by region, showing all the points and
# ordering the regions by their median rate.
data('murders')
murders <- murders %>% mutate(rate = total/population*100000)

area_median <-murders %>%
  group_by(region) %>%
  summarize(median_rate=median(rate)) %>%
  as.data.frame()

murders<- merge(murders,area_median,by='region')

murders %>% mutate(region=reorder(region,median_rate)) %>%
  ggplot(aes(region,rate,color=region)) +
  geom_boxplot(show.legend=FALSE)+
  ylab("Murder Rate") +
  xlab("Region")


