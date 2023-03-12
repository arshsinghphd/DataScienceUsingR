rm(list=ls())
library(dslabs)
library(tidyverse)
data(heights)

x <- heights %>% filter(sex=="Male") %>% pull(height)

# Q1 ----------------------------------------------------------------------

