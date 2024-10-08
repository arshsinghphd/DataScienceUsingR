rm(list=ls())
options(digits=3)
library(tidyverse)
library(dslabs)
library(RColorBrewer)
library(dplyr)
data("us_contagious_diseases")
str(us_contagious_diseases)
levels(us_contagious_diseases$disease)

# Q1,2 --------------------------------------------------------------------

the_disease <- 'Smallpox'
dat <- us_contagious_diseases %>%
  filter(disease == the_disease & 
           !state %in% c("Hawaii","Alaska") & 
           weeks_reporting>42) %>%
  mutate(rate=count/population * 10000 * 52/weeks_reporting) 


#HeatMap

dat %>%  ggplot(aes(year,state,fill=rate)) +
  geom_tile() + 
  scale_x_continuous(expand=c(0,0))+ # remove the extra space on x-axis
  scale_fill_gradientn(colors = brewer.pal(4, "Blues")) + #change color scheme
  theme_minimal() + # makes NA white from grey
  theme(panel.grid = element_blank(), # assigns no space
        axis.text.x=element_text(size=8),
        axis.text.y=element_text(size=6), 
        title=element_text(size=20),
        legend.text= element_text(size=8),
        legend.title=element_text(size=10)
        )+
  xlab("")+ylab("")+
  ggtitle(the_disease)


# Line Map

avg <- us_contagious_diseases %>% 
  filter(disease == the_disease & 
           !state %in% c("Hawaii","Alaska") & 
           weeks_reporting>42) %>%
  group_by(year) %>%
  summarize(US_Mean_Rate= sum(count,na.rm=TRUE)/ sum(population,na.rm=TRUE) *10000,
            n_states=n_distinct(count,na.rm=TRUE)) 
# allowing for as low as 42 weeks of data to be counted as a whole year

dat %>% ggplot() +
  geom_line(aes(year,rate,group=state),alpha=.3,show.legend=FALSE,color ='grey50') +
  geom_line(data=avg, mapping=aes(x=year, y=US_Mean_Rate),size=1)+
  geom_text(data = data.frame(x = 1930, y = 5), 
            mapping = aes(x, y, label="US Average"), 
            color="black")+
  geom_text(data = data.frame(x = 1935, y = 5), 
            mapping = aes(x, y, label="States"), 
            color="grey50")+
  xlab('Rate') + ylab('Year') + 
  ggtitle(paste("US-wide Rate of Incidences of",the_disease))


# Q3 ----------------------------------------------------------------------
# For the state of California, make a time series plot showing rates for all 
# diseases. Include only years with 10 or more weeks reporting. Use a 
# different color for each disease.
levels(us_contagious_diseases$state)

the_state="California"
cal <- us_contagious_diseases %>%
  group_by(year) %>%
  filter(state==the_state, weeks_reporting>10) %>%
  mutate(rate=count/population *10^4)

cal %>% ggplot(aes(year,rate,color=disease)) +
  geom_line(size=1) + 
  xlab('Year') +
  ylab('Incidence Rate per 10,000 persons') +
  ggtitle(the_state)


# Q4 ----------------------------------------------------------------------
# Now do the same for the rates for the US.
the_state='USA'
us <- us_contagious_diseases %>%
  filter(weeks_reporting>10) %>%
  group_by(disease,year) %>%
  mutate(rate=sum(count,na.rm=TRUE)/sum(population,na.rm=TRUE) *10^4)

us %>% ggplot(aes(year,rate,color=disease)) +
  geom_line(size=1) +
  xlab('Year') +
  ylab('Incidence Rate per 10,000 persons') +
  ggtitle(the_state)
