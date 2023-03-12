# Preamble ----------------------------------------------------------------
library(tidyverse)
library(dslabs)
library(dplyr)
library(ggplot2)
library(gganimate)
rm(list=ls())
setwd('C:/Users/arsha/OneDrive/LearningProgramming/LearningML/R/Forbes')

# Setting-up data ---------------------------------------------------------
forbes <- read.csv("forbes04_15.csv")


# Distibution of wealth ---------------------------------------------------
years <- c(2005,2010,2015)
labels <- data.frame(year = years, x = c(.9,1.25,1.8), y = c(400,390,400))
p <- forbes %>% 
  filter(!is.na(r), year %in% years) %>%
  ggplot(aes(w,r,group=year,color=year,label=year)) +
  geom_line()+
  geom_text(data = labels, aes(x, y, label = year), size = 4) +
  scale_x_continuous(trans = "log10") + 
  theme(legend.position = "none") +
  labs(title = 'Weath Distribution Among Forbes 400\'s top 100', y = 'Rank', x = 'Wealth') +
  transition_reveal(w,keep_last = TRUE) 
animate(p,nframes = 96, fps=6, renderer=gifski_renderer(loop=FALSE))
anim_save('w_distr.gif')


p1 <- forbes  %>%
  group_by(year)%>%
  ggplot(aes(w, r,label=year)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(2, 12)) +
  scale_x_continuous(trans = "log10") + 
  # Animating the plot
  labs(title = 'Year: {frame_time}', x = 'Wealth', y = 'rank') +
  transition_time(year) +
  ease_aes('linear') +
  enter_fade() +
  exit_fade() +
  theme( plot.title = element_text(size=20, face= "bold", colour= "black" ),
         axis.title.x = element_text(size=18, face="bold", colour = "black"),
         axis.title.y = element_text(size=18, face="bold", colour = "black"),
         axis.text.x = element_text(size=18, face="bold", colour = "black"),
         axis.text.y = element_text(size=18, face="bold", colour = "black"),
         strip.text.x = element_text(size=16, face="bold", colour = "black"),
         plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm") )

animate(p1,nframes = 96, fps=6,end_pause=18)
anim_save('W_distr_dots.gif')

p2 <- forbes  %>%
  group_by(year)%>%
  ggplot(aes(w, r,color=graduate)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(2, 12)) +
  scale_x_continuous(trans = "log10") + 
  # Animating the plot
  labs(title = 'Year: {frame_time}', x = 'Wealth', y = 'rank') +
  transition_time(year) +
  ease_aes('linear') +
  enter_fade() +
  exit_fade() +
  theme( plot.title = element_text(size=20, face= "bold", colour= "black" ),
         axis.title.x = element_text(size=18, face="bold", colour = "black"),
         axis.title.y = element_text(size=18, face="bold", colour = "black"),
         axis.text.x = element_text(size=18, face="bold", colour = "black"),
         axis.text.y = element_text(size=18, face="bold", colour = "black"),
         strip.text.x = element_text(size=16, face="bold", colour = "black"),
         plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm") )

animate(p2,nframes = 96, fps=6,end_pause=18)
anim_save('W_distr_grad.gif')

p3 <- forbes  %>%
  group_by(year)%>%
  ggplot(aes(w, r,color=self_made)) +
  scale_x_continuous(trans = "log10") + 
  geom_point(alpha = 0.7) +
  scale_size(range = c(2, 12)) +
  # Animating the plot
  labs(title = 'Year: {frame_time}', x = 'Wealth', y = 'rank') +
  transition_time(year) +
  ease_aes('linear') +
  enter_fade() +
  exit_fade() +
  theme( plot.title = element_text(size=20, face= "bold", colour= "black" ),
         axis.title.x = element_text(size=18, face="bold", colour = "black"),
         axis.title.y = element_text(size=18, face="bold", colour = "black"),
         axis.text.x = element_text(size=18, face="bold", colour = "black"),
         axis.text.y = element_text(size=18, face="bold", colour = "black"),
         strip.text.x = element_text(size=16, face="bold", colour = "black"),
         plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm") )

animate(p3,nframes = 96, fps=6,end_pause=18)
anim_save('W_distr_self.gif')


# Density -----------------------------------------------------------------

p4 <- forbes %>% filter(!is.na(w)) %>%
  mutate(graduate=as.factor(graduate)) %>%
  ggplot(aes(w, fill = graduate)) +
  scale_x_continuous(trans = "log10") +
  geom_density(alpha = 0.2) + 
  # animation
  labs(title = 'Year: {closest_state}', x = 'Wealth', y = 'Density') +
  transition_states(year,transition_length = 1, state_length = 1, wrap = TRUE)
animate(p4,nframes = 96, fps=12,end_pause=24)
anim_save('graduate.gif')


p5 <- forbes %>% 
  filter(!is.na(w)) %>%
  mutate(self_made=as.factor(self_made)) %>%
  ggplot(aes(w, fill = self_made)) +
  scale_x_continuous(trans = "log10") +
  geom_density(alpha = 0.2) + 
  # animation
  labs(title = 'Year: {closest_state}', x = 'Wealth', y = 'Density') +
  transition_states(year,transition_length = 1, state_length = 1, wrap = TRUE)
animate(p5,nframes = 96, fps=12,end_pause=24)
anim_save('self_made.gif')
