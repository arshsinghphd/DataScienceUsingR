library(ggplot2)
library(stats)
library(gtools)

same_birthday <- function(n){
  bdays <- sample(1:365, n, replace=TRUE)
  any(duplicated(bdays))
}

B <- 10^seq(0.5, 4, len = 30)

compute_prob <- function(B,n=25){
  results <- replicate(B, same_birthday(n))
  mean(results)
}

prob <- sapply(B, compute_prob)
qplot(B, prob, geom = "line")
# expect = 0.569
