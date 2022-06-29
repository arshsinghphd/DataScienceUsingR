library(dslabs)
data("polls_us_election_2016")
library(tidyverse)
polls <- polls_us_election_2016 %>%
  filter(enddate >= "2016-10-31" & state == "U.S.")
