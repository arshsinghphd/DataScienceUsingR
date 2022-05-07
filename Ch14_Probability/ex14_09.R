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
1 - 3/(3+5+7) #= 0.8

# Monte Carlo Experiment with B of 10^5
box <- c(rep('c',3),rep('m',5),rep('y',7))
B <- 10^5
mean(replicate(B,sample(box,1))!='c') # = ~0.8003


# Q3 ----------------------------------------------------------------------
# Instead of taking just one draw, consider taking two draws. You take the 
# second draw without returning the first draw to the box. We call this 
# sampling without replacement. What is the probability that the first draw 
# is cyan and that the second draw is not cyan?
#Calculate
3/15*12/14 #= 0.1714

S=replicate(B,sample(box,2,replace=FALSE))
mean(S[1,]=='c' & S[2,]!='c') #= 0.1716


# Q4 ----------------------------------------------------------------------
# Now repeat the experiment, but this time, after taking the first draw and 
# recording the color, return it to the box and shake the box. We call this
# sampling with replacement. What is the probability that the first draw is 
# cyan and that the second draw is not cyan?
#Calculate
3/15*12/15 #= 0.1600

S=replicate(B,sample(box,2,replace=TRUE))
mean(S[1,]=='c' & S[2,]!='c') #= 0.1596


# Q4 ----------------------------------------------------------------------

# Calculate Pr, they can win in these cases:
# Cavs win 4 of the next 4 games (4 more, total 5 games)
# Cavs win 3 of the next 4 games + last game (5 more, total 6 games)
# Cavs win 3 of the next 5 games + last game (6 more, total 7 games)
(0.5^4)+(.5^5)+(.5^6)
#.109375


# Q5 ----------------------------------------------------------------------
# Two events A and B are independent if Pr(A and B)=Pr(A)P(B). 
# Under which situation are the draws independent?
# a. You don’t replace the draw.
# b. You replace the draw.
# c. Neither
# d. Both
# (answer=b)


# Q6 ----------------------------------------------------------------------
# Say you’ve drawn 5 balls from the box, with replacement, and all have been
# yellow. What is the probability that the next one is yellow?

7/15 #=.4667
mean(replicate(B,sample(box,1))=='y') #=.4685


# Q7 ----------------------------------------------------------------------
# If you roll a 6-sided die six times, what is the probability of not seeing
# a 6?
5/6 


# Q8 ----------------------------------------------------------------------
# Two teams, say the Celtics and the Cavs, are playing a seven game series. 
# The Cavs are a better team and have a 60% chance of winning each game. 
# What is the probability that the Celtics win at least one game?

# Case: 1 - Cavs win first 4 game ending the series
1 - .6^4 # = .8704


# Q9 ----------------------------------------------------------------------
# Create a Monte Carlo simulation to confirm your answer to the previous 
# problem.
cav_wins <- function(n=4){
  sum(sample(c(1,0),n,prob=c(.6,.4),replace=TRUE))
}

1 - mean(replicate(B,cav_wins(4))==4)
# .8699


# Q10 ---------------------------------------------------------------------
# Two teams, say the Cavs and the Warriors, are playing a seven game 
# championship series. The first to win four games, therefore, wins the series. 
# The teams are equally good so they each have a 50-50 chance of winning each 
# game. If the Cavs lose the first game, what is the probability that they win
# the series?


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
