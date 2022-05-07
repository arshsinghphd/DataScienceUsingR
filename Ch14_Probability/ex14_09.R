library(dplyr)

# 10. Two teams, say the Cavs and the Warriors, are playing a seven game 
# championship series. The first to win four games, therefore, wins the series. 
# The teams are equally good so they each have a 50-50 chance of winning each 
# game. If the Cavs lose the first game, what is the probability that they win
# the series?

# Calculate Pr, they can win in these cases:
# Cavs win 4 of the next 4 games (4 more, total 5 games)
# Cavs win 3 of the next 4 games + last game (5 more, total 6 games)
# Cavs win 3 of the next 5 games + last game (6 more, total 7 games)
(0.5^4)+(.5^3*.5^1*.5)+(.5^3*.5^2*.5)
#.109375


# Q11 ---------------------------------------------------------------------
#  Confirm the results of the previous question with a Monte Carlo 
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
