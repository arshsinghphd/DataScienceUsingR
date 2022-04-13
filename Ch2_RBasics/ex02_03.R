# 1. What is the sum of the first 100 positive integers? 
# The formula for the sum of integers 1 through n is n(n+1)/2. 
# Define n=100 and then use R to compute the sum of 1 through 100 
# using the formula. What is the sum?
n=100
sum_n <- n*(n+1)/2
sum_n
# 5050

#2. Now use the same formula to compute the sum of the integers 
# from 1 through 1,000.
n=1000
sum_n <- n*(n+1)/2
sum_n
#500500

#3. Look at the result of typing the following code into R:
n <- 1000
x <- seq(1, n)
sum(x)

# Based on the result, what do you think the functions seq and sum do? 
# You can use help.
# 1.sum creates a list of numbers and seq adds them up.
# 2.seq creates a list of numbers and sum adds them up.
# 3.seq creates a random list and sum computes the sum of 1 through 1,000
# 4.sum always returns the same number.

# ___2 is correct__


# 4. In math and programming, we say that we evaluate a function when 
# we replace the argument with a given number. So if we type sqrt(4), 
# we evaluate the sqrt function. In R, you can evaluate a function inside 
# another function. The evaluations happen from the inside out. 
# Use one line of code to compute the log, in base 10, of the square root
# of 100.

log10(sqrt(100))
# answer is 1

# 5. Which of the following will always return the numeric value stored in x? You can try out examples and use the help system if you want.
# 1.log(10^x)
# 2.log10(x^10)
# 3.log(exp(x))
# 4.exp(log(x, base = 2))
# correct answer is 3
