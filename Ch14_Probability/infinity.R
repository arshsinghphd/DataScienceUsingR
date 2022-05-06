library(ggplot2)
library(stats)
library(gtools)

same_birthday <- function(n){
  bdays <- sample(1:365, n, replace=TRUE)
  any(duplicated(bdays))
}

B <- 10^seq(0.5, 6, len = 50)

compute_prob <- function(B,n=25){
  results <- replicate(B, same_birthday(n))
  mean(results)
}

prob <- sapply(B, compute_prob)
qplot(log10(B), prob, geom = "line")
# expect = 0.569
