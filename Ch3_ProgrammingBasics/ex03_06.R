# 1. What will this conditional expression return?
## Not all positives
x <- c(1,2,-3,4)

if(all(x>0)){
  print("All Postives")
} else{
  print("Not all positives")
}

# 2. Which of the following expressions is always FALSE when at least
# one entry of a logical vector x is TRUE?
# all(x)
# any(x)
# any(!x)
# all(!x) <- answer
x <- (True, False)
all(!x)

# 3. The function nchar tells you how many characters long a character vector is. 
# Write a line of code that assigns to the object new_names the state abbreviation 
# when the state name is longer than 8 characters.

# to make nchar work we have to convert the state into list of single letters
nchar(unlist(strsplit(murders$state[1],"")))

nmax=length(murders$state)
new_name<-murders$state
for(i in 1:nmax){
  n<-nchar(unlist(strsplit(murders$state[i],"")))
  if(n>8){
    new_name[i]=murders$abb[i]
    print(n)
    print(new_name[i])
  }
}
new_name

# 4. Create a function sum_n that for any given value, say n, computes the sum of 
# the integers from 1 to n (inclusive). Use the function to determine the sum of 
# integers from 1 to 5,000.
sum_n <- function(n){
  li=1:n
  sum(li)
}
sum_n(5000)

# 5. Create a function altman_plot that takes two arguments, x and y, and 
# plots the difference against the sum.
altman_plot<-function(x,y){
  Sum=x+y
  Diff=x-y
  plot(Sum,Diff)
}
altman_plot(10,2)


# 6. After running the code below, what is the value of x?
# guess: 3, since the function is not called. It it were called, x=5.
x <- 3
my_func <- function(y){
  x <- 5
  y+5
}
x

# 7. Write a function compute_s_n that for any given n computes the sum 
# S_n=1^2+2^2+3^2+…n^2. Report the value of the sum when n=10.
compute_s_n <- function(n){
  li<-1:n
  sum(li*li)
}
compute_s_n(10)

# 8. Define an empty numerical vector s_n of size 25 using 
# s_n <- vector("numeric", 25) and store in the results of S1,S2,…S25 
# using a for-loop.
s_n <- vector("numeric", 25)
for(i in 1:25){
  s_n[i]=compute_s_n(i)
}
s_n

# 9. Repeat exercise 8, but this time use sapply.
s_n2 <- sapply(1:25,compute_s_n)
s_n2

# 10. Repeat exercise 8, but this time use map_dbl.
??map_dbl
library(purrr)
s_n3<- map_int(1:25,compute_s_n)
s_n3

# 11. Plot Sn versus n. Use points defined by n=1,…,25.
n <- 1:25
s_n <- map_int(n,compute_s_n)
plot(n,s_n)

# 12. Confirm that the formula for this sum is Sn=n(n+1)(2n+1)/6
s_n_formula<-function(n){
  n*(n+1)*(2*n+1)/6
}

n <- 10000
test<-vector(10000)
for(i in 1:n){
  test[i]=compute_s_n(i)==s_n_formula(i)
  
}
sum(test)==n
# true for all n
