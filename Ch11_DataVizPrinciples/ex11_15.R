rm(list=ls())
library(tidyverse)
library(RColorBrewer)
library(dslabs)
data(us_contagious_diseases)
names(us_contagious_diseases)
summary(us_contagious_diseases$disease)
summary(us_contagious_diseases$state)
summary(us_contagious_diseases$population)


the_disease <- 'Smallpox'

dat <- us_contagious_diseases %>%
  filter( (!state %in% c('Alaska','Hawaii')) & 
           weeks_reporting>42 &
           disease==the_disease) %>%
  mutate(rate=count/population * 10^4 / weeks_reporting*52) %>%
  filter(!is.na(rate))

# Heat Map ----------------------------------------------------------------

dat %>% 
  ggplot(aes(year, state, fill = rate)) +
  geom_tile(color = "grey50") + 
  scale_x_continuous(expand=c(0,0)) +
  scale_fill_gradientn(colors = brewer.pal(4, "Blues"), trans = "sqrt") +
  theme_minimal() +  
  theme(panel.grid = element_blank(), 
        legend.position="bottom", 
        text = element_text(size = 8)) +
  ylab("") + xlab("")+
  ggtitle(the_disease)
  


# Line map ----------------------------------------------------------------

avg <- us_contagious_diseases %>%
  filter(!state %in% c('Alaska','Hawaii') & 
           weeks_reporting>42 &
           disease==the_disease) %>% 
  group_by(year) %>%
  summarize(us_rate = sum(count, na.rm = TRUE) / 
              sum(population, na.rm = TRUE) * 10000)

dat %>%
  ggplot(aes(year,rate)) +
  geom_line(aes(year, rate, group = state), alpha = 0.2, size = 1)+
  geom_line(aes(year, us_rate),  data = avg, size = 1)+
  ggtitle("Cases per 10,000 by state")+
  xlab('Year')+
  ylab('Rate ')
