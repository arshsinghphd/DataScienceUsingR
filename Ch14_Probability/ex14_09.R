library(dplyr)
library(gtools)
options(digits=4)

# Q1 ----------------------------------------------------------------------
# One ball will be drawn at random from a box containing: 3 cyan balls, 
# 5 magenta balls, and 7 yellow balls. What is the probability that the ball 
# will be cyan?

#Calculation
3/(3+5+7) # =.2

# Monte Carlo Experiment with B of 10^5
box <- c(rep('c',3),rep('m',5),rep('y',7))
B <- 10^5
mean(replicate(B,sample(box,1))=='c') # = ~.20185


# Q2 ----------------------------------------------------------------------
# What is the probability that the ball will not be cyan?
#Calculation
1 - 3/(3+5+7) # =.8

# Monte Carlo Experiment with B of 10^5
box <- c(rep('c',3),rep('m',5),rep('y',7))
B <- 10^5
mean(replicate(B,sample(box,1))!='c') # = ~.8003


# Q3 ----------------------------------------------------------------------


# Q10 ---------------------------------------------------------------------
# Two teams, say the Cavs and the Warriors, are playing a seven game 
# championship series. The first to win four games, therefore, wins the series. 
# The teams are equally good so they each have a 50-50 chance of winning each 
# game. If the Cavs lose the first game, what is the probability that they win
# the series?

# Calculate Pr, they can win in these cases:
# Cavs win 4 of the next 4 games (4 more, total 5 games)
# Cavs win 3 of the next 4 games + last game (5 more, total 6 games)
# Cavs win 3 of the next 5 games + last game (6 more, total 7 games)
(0.5^4)+(.5^5)+(.5^6)
#.109375


# Q11 ---------------------------------------------------------------------
# Confirm the results of the previous question with a Monte Carlo 
# simulation.
B <- 10^5
count=0
sum_cwins=array()
for (i in c(1:B)){
  sum_cwins[i]=0
  for (j in c(2:7)){
    if (sum_cwins[i]<4){
    sum_cwins[i]<-sum_cwins[i]+sample(c(0,1),1,prob=c(0.5,0.5))
    } else {
    break
    }
  }
} 
mean(sum_cwins==4)
