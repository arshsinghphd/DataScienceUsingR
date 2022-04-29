# Preamble ----------------------------------------------------------------
library(tidyverse)
library(dslabs)
library(dplyr)
library(ggplot2)
library(gganimate)
rm(list=ls())
setwd('C:/Users/arsha/OneDrive/LearningProgramming/LearningML/R/Ch10_DataProject')

data(gapminder)
gapminder %>% as_tibble()

# Animation ---------------------------------------------------------------
p1 <- ggplot(gapminder, aes(fertility, life_expectancy,colour = continent)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(2, 12)) +
  # Animating the plot
  labs(title = 'Year: {frame_time}', x = 'Fertility Rate', y = 'Life Expectancy') +
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
anim_save('plot_gdpPercap_lifeExp.gif')


# TimeSeries --------------------------------------------------------------
p2 <- gapminder %>% 
  filter(country == "United States") %>% 
  ggplot(aes(year, fertility)) +
  geom_line() +
  labs(title = 'Fertility Rate', y = 'Fertility Rate', x = 'Year') +
  transition_reveal(year,keep_last = TRUE)
animate(p2,nframes = 96, fps=6, renderer=gifski_renderer(loop=FALSE))
anim_save('USA_fertility.gif')

countries <- c("South Korea","Germany")
labels <- data.frame(country = countries, x = c(1975,1965), y = c(5,1))

p3 <- gapminder %>% filter(country %in% countries & !is.na(fertility)) %>% 
  ggplot(aes(year, fertility, color = country)) +
  geom_line()+
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  theme(legend.position = "none") +
  transition_reveal(year,keep_last = TRUE)
animate(p3,renderer=gifski_renderer(loop=FALSE))
anim_save('SKorea_Germany.gif')


# Density ------------------------------------------------------------------

library(ggridges)
gapminder <- gapminder %>% 
  mutate(group = case_when(
    region %in% c("Western Europe", "Northern Europe","Southern Europe", 
                  "Northern America", 
                  "Australia and New Zealand") ~ "West",
    region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    region %in% c("Caribbean", "Central America", 
                  "South America") ~ "Latin America",
    continent == "Africa" & 
      region != "Northern Africa" ~ "Sub-Saharan",
    TRUE ~ "Others"))

gapminder <- gapminder %>% 
  mutate(group = factor(group, levels = c("Others", "Latin America", 
                                          "East Asia", "Sub-Saharan",
                                          "West")))

gapminder <- gapminder %>%  mutate(dollars_per_day = gdp/population/365)

p4 <- gapminder %>% 
  filter(!is.na(dollars_per_day) & group %in% c('West','East Asia')) %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2") +
  geom_density(alpha = 0.2) + 
  # animation
  labs(title = 'Year: {closest_state}', x = 'Dollars_Per_Day', y = 'Density') +
  transition_states(year,transition_length = 1, state_length = 1, wrap = TRUE)

animate(p4,renderer=gifski_renderer(loop=FALSE))
anim_save('DollarPerDay_EA.gif')

p5 <- gapminder %>% 
  filter(!is.na(dollars_per_day) & group %in% c('West','Latin America')) %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2") +
  geom_density(alpha = 0.2) + 
  # animation
  labs(title = 'Year: {closest_state}', x = 'Dollars_Per_Day', y = 'Density') +
  transition_states(year,transition_length = 1, state_length = 1, wrap = TRUE)

animate(p5,renderer=gifski_renderer(loop=FALSE))
anim_save('DollarPerDay_LA.gif')

p6 <- gapminder %>% 
  filter(!is.na(dollars_per_day) & group %in% c('West','Sub-Saharan')) %>%
  ggplot(aes(dollars_per_day,fill = group)) +
  scale_x_continuous(trans = "log2") +
  geom_density(alpha = 0.2) + 
  # animation
  labs(title = 'Year: {closest_state}', x = 'Dollars_Per_Day', y = 'Density') +
  transition_states(year,transition_length = 1, state_length = 1, wrap = TRUE)
animate(p6,renderer=gifski_renderer(loop=FALSE))
anim_save('DollarPerDay_SSA.gif')

p7 <- gapminder %>% 
  group_by(year) %>%
  mutate(weight_pop = population/sum(population)*2) %>%
  ungroup() %>%
  mutate(group = ifelse(group == "West", "West", "Developing")) %>%
  filter(!is.na(dollars_per_day) & group %in% c('West','Developing')) %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2") +
  geom_density(alpha = 0.2, weight='weight_pop') + 
  # animation
  labs(title = 'Year: {closest_state}', x = 'Dollars_Per_Day', y = 'Density') +
  transition_states(year,transition_length = 1, state_length = 1, wrap = TRUE)
animate(p7,renderer=gifski_renderer())
anim_save('DollarPerDay_West_Developing.gif')


