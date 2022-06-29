library(tidyverse)
library(dplyr)

# Q1 ----------------------------------------------------------------------
# 1. Write an urn model function that takes the proportion of Democrats p 
# and the sample size N as arguments and returns the sample average if 
# Democrats are 1s and Republicans are 0s. Call the function take_sample.
take_sample<-function(p,N){
  x<- sample(c(0,1), size=N, replace=TRUE, prob=c(1-p,p))
  mean(x)
}


# Q2 ----------------------------------------------------------------------
# 2. Now assume p <- 0.45 and that your sample size is N=100. Take a sample
# 10,000 times and save the vector of mean(X) - p into an object called 
# errors. Hint: use the function you wrote for exercise 1 to write this in 
# one line of code.
B<-10**4
N<-100
p<-.45
errors<-replicate(B,take_sample(p,N)-p)


# Q3 ----------------------------------------------------------------------
# 3. The vector errors contains, for each simulated sample, the difference 
# between the actual p and our estimate ¯X. We refer to this difference as 
# the error. Compute the average and make a histogram of the errors 
# generated in the Monte Carlo simulation and select which of the following 
# best describes their distributions:

# A. The errors are all about 0.05.
# B. The errors are all about -0.05.
# C. The errors are symmetrically distributed around 0.
# D. The errors range from -1 to 1.

hist(errors)
e_bar<-mean(errors)
# almost zero
# (Ans: C)


# Q4 ----------------------------------------------------------------------
# 4. The error ¯X−p is a random variable. In practice, the error is not 
# observed because we do not know p. Here we observe it because we 
# constructed the simulation. What is the average size of the error if we 
# define the size by taking the absolute value ∣¯X−p∣ ?

e_abs_bar<-mean(abs(errors))
# 0.039232


# Q5 ----------------------------------------------------------------------
# 5. The standard error is related to the typical size of the error we make 
# when predicting. We say size because we just saw that the errors are 
# centered around 0, so thus the average error value is 0. For mathematical 
# reasons related to the Central Limit Theorem, we actually use the standard 
# deviation of errors rather than the average of the absolute values to 
# quantify the typical size. What is this standard deviation of the errors?

round(sd(errors),4)
# 0.0492


# Q6 ----------------------------------------------------------------------
# Theoretical standard deviation of errors or standard error of X:

round((p*(1-p)/N)**.5,4)
# 0.0497


# Q7 ----------------------------------------------------------------------
# 7. In practice, we don’t know p, so we construct an estimate of the 
# theoretical prediction based by plugging in ¯X for p. Compute this 
# estimate. Set the seed at 1 with set.seed(1).
set.seed(1)
x_hat<-replicate(B,take_sample(p,N))
x_bar<-mean(x_hat)
round((x_bar*(1-x_bar)/N)**.5,4)
# .0499


# Q8 ----------------------------------------------------------------------
# 8. Note how close the standard error estimates obtained from the Monte 
# Carlo simulation (exercise 5), the theoretical prediction (exercise 6), 
# and the estimate of the theoretical prediction (exercise 7) are. The 
# theory is working and it gives us a practical approach to knowing the 
# typical error we will make if we predict p with ¯X. Another advantage that 
# the theoretical result provides is that it gives an idea of how large a 
# sample size is required to obtain the precision we need. Earlier we 
# learned that the largest standard errors occur for p=0.5. 
# Create a plot of the largest standard error for N ranging from 100 to 
# 5,000. Based on this plot, how large does the sample size have to be to 
# have a standard error of about 1%?

# A. 100
# B. 500
# C. 2,500
# D. 4,000

take_sample<-function(p,N){
  x<- sample(c(0,1), size=N, replace=TRUE, prob=c(1-p,p))
  mean(x)
}

t<-tibble(N=numeric(), SE=numeric())
s<-seq(100,5000,100)
p<-0.45
B<-10**3
for(n in s){
  errors<-replicate(B,take_sample(p,n)-p)
  se<-sd(errors)
  t<-add_row(t,tibble_row(N=n,SE=se))
  }

t %>% ggplot(aes(N,SE)) +
  geom_point() +
  xlab('N') +
  ylab('Std. Err')

# (Ans: c)


# Q9 ----------------------------------------------------------------------
# 9. For sample size N=100, the central limit theorem tells us that the 
# distribution of ¯X is:
# Ans: b, approximately normal with expected value p and standard error
# √p(1−p)/N.


# Q10 ---------------------------------------------------------------------
# 10. Based on the answer from exercise 8, the error ¯X−p is:
#  Ans: b, approximately normal with expected value 0 and standard error 
# √p(1−p)/N.


# Q11 ---------------------------------------------------------------------
# To corroborate your answer to exercise 9, make a qq-plot of the errors 
# you generated in exercise 2 to see if they follow a normal distribution.
B<-10**4
N<-100
p<-.45
errors<-replicate(B,take_sample(p,N)-p)
qqline(errors, main = "Normal Q-Q Plot",
       xlab = "Theoretical Quantiles", ylab = "Sample Quantiles")


# Q12 ---------------------------------------------------------------------
# 12. If p=0.45 and N=100 as in exercise 2, use the CLT to estimate the 
# probability that ¯X>0.5. You can assume you know p=0.45 for this 
# calculation.
# ¯X-p=.5-.45=.05
# pr(¯X-p>.05)  = 1 - pr(¯X-p<=0.05)
#               = 1 - ( pnorm(.05/se(¯X)) - pnorm(-.05/se(¯X)) )
# se(¯X) = √p(1−p)/N 
p <- 0.45
N <- 100
seXbar <- (p * (1-p) /N)**.5
round(1-(pnorm(.05/seXbar)-pnorm(-1*.05/seXbar)),4)
# Ans= 0.3149


# Q13 ---------------------------------------------------------------------
# 13. Assume you are in a practical situation and you don’t know p. Take a 
# sample of size N=100 and obtain a sample average of ¯X=0.51. What is the 
# CLT approximation for the probability that your error is equal to or 
# larger than 0.01?

# since we do not know p, we can plug ¯X.
p_hat <- 0.51
N <- 100
seXbar <- (p_hat * (1-p_hat) /N)**.5
round(pnorm(.01/seXbar)-pnorm(-1*.01/seXbar),4)
# Ans= .1586
