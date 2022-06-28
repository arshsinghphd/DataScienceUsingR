library(dplyr)
library(ggplot2)
# Q1 ----------------------------------------------------------------------
# 1.Suppose you poll a population in which a proportion p of voters are 
#   Democrats and 1−p are Republicans. Your sample size is N=25. 
#   Consider the random variable S which is the total number of Democrats 
#   in your sample. What is the expected value of this random variable? 
#   Hint: it’s a function of p.

# Ans: N*p


# Q2 ----------------------------------------------------------------------
# 2. What is the standard error of S? 
#    Hint: it’s a function of p.

# Ans: N*sqrt(p*(1-p)/N)


# Q3 ----------------------------------------------------------------------
# 3.Consider the random variable S/N. 
#   This is equivalent to the sample average, which we have been denoting 
#   as ¯X. What is the expected value of the ¯X? 
#   Hint: it’s a function of p.

# Ans: p


# Q4 ----------------------------------------------------------------------
# 4. What is the standard error of ¯X? Hint: it’s a function of p.

# Ans: sqrt(p*(1-p)/N)


# Q5 ----------------------------------------------------------------------
# 5. Write a line of code that gives you the standard error se for the 
#   problem above for several values of p, specifically for
p <- seq(0, 1, length = 100)
# Make a plot of se versus p.
se <- sqrt(p*(1-p)/25)
plot(p,se)


# Q6 ----------------------------------------------------------------------
# 6. Copy the code above and put it inside a for-loop to make the plot 
#   for N=25, N=100, and N=1000.
t <- tibble(n0=numeric(),p0=numeric(),se0=numeric())

for(n in c(25,100,1000)){
  p1 <- seq(0, 1, length = n)
  n1 <- rep(n,n)
  se1 <- sqrt(p1*(1-p1)/n)
  t=add_row(t,n0=n1, p0=p1, se0=se1)
}

labels <- tibble(n =c(25,100,1000), y = c(.1,.055,.02), x = c(.30,.4,.5))
t %>%
  ggplot(aes(p0,se0)) +
  geom_point(show.legend=FALSE)+
  ylab("Std. Err.") +
  xlab("Probability")+
  geom_text(data=labels, aes(x, y, label=n), size = 5) 


# Q7 ----------------------------------------------------------------------
# 7. If we are interested in the difference in proportions, p−(1−p), our 
#   estimate is d=¯X−(1−¯X). Use the rules we learned about sums of random
#   variables and scaled random variables to derive the expected value of d.

# d=2¯X-1
# exp(d)=2*exp(p)-1


# Q8 ----------------------------------------------------------------------
# 8. What is the standard error of d?

# se(d)=2*se(p)


# Q9 ----------------------------------------------------------------------
# 9. If the actual p=.45, it means the Republicans are winning by a 
#   relatively large margin since d=−.1, which is a 10% margin of victory. 
#   In this case, what is the standard error of 2^X−1 if we take a sample 
#   of N=25?

# p=.45
# N=25
#exp(p)=p=.45
# se(p)=sqrt(p(1-p)/N)=.099
#exp(d)=2p-1= -0.10
# se(p)=2*sqrt(p(1-p)/N)=.199


# Q10 ----------------------------------------------------------------------  
# 10. Given the answer to 9, which of the following best describes your 
#   strategy of using a sample size of N=25? 
#  a.The expected value of our estimate 2¯X−1 is d, so our prediction will be right on. 
#  b.Our standard error is larger than the difference, so the chances of 2¯X−1
#    being positive and throwing us off were not that small. We should pick a 
#    larger sample size. 
#  c.The difference is 10% and the standard error is about
#    0.2, therefore much smaller than the difference. 
#  d.Because we don’t know p, we have no way of knowing that making N larger would
#    actually improve our standard error.
#
# (Ans: b)