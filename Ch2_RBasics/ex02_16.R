#1 many states have populations below 5 million and are bunched up. 
# We may gain further insights from making this plot in the log scale. 
# Transform the variables using the log10 transformation and then plot them.

library(dslabs)
data(murders)
population_in_millions <- murders$population/10^6
total_gun_murders <- murders$total
plot(population_in_millions, total_gun_murders)
log_population <- log10(murders$population)
log_total_gun_murders <- log10(murders$total)
plot(log_population, log_total_gun_murders)

# 2. Create a histogram of the state populations.
x <-with(murders,population_in_millions)
hist(x)

# 3. Generate boxplots of the state populations by region.
boxplot(population_in_millions~region, data=murders)
