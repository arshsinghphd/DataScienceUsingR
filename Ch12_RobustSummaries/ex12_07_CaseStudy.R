rm(list=ls())
library(tidyverse)
library(dplyr)
library(dslabs)

# Outliers -------------------------------------------------------------------------

data("reported_heights")

reported_heights <- reported_heights %>%
  mutate(original_heights=height, height=as.numeric(height))

reported_heights %>% filter(is.na(height)) %>% head()

NAs <- reported_heights %>% filter(is.na(height)) %>% nrow() 
NAs

All <- nrow(reported_heights)
All

reported_heights <- filter(reported_heights, !is.na(height))
reported_heights <- reported_heights %>% mutate(sex=as.factor(sex))

reported_heights %>% 
  group_by(sex) %>%
  summarize(average = mean(height), sd = sd(height),
            median = median(height), MAD = mad(height))

# Male average and SD are way off compared to females
reported_heights %>% 
  ggplot(aes(sex,height)) +
  geom_boxplot() +
  xlab('Sex') + ylab('Heights (inches)')

reported_heights %>% arrange(desc(height)) %>% top_n(10, height)

whisker <- 3*IQR(reported_heights$height)
max_height <- quantile(reported_heights$height, .75) + whisker
min_height <- quantile(reported_heights$height, .25) - whisker
reported_heights %>% 
  filter(!between(height, min_height, max_height)) %>% 
  select(original_heights) %>%
  head(20) %>% pull(original_heights)
# these seem to be mostly errors of entering feet and inches or centimeters 
# instead of inches