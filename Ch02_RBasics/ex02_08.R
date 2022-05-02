# 1. Use the function c to create a vector with the average high temperatures in 
# January for Beijing, Lagos, Paris, Rio de Janeiro, San Juan, and Toronto, which 
# are 35, 88, 42, 84, 81, and 30 degrees Fahrenheit. Call the object temp.
temp <- c(35,88,42,84,81,30)
temp
# 2. Now create a vector with the city names and call the object city.
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")

# 3. Use the names function and the objects defined in the previous exercises to 
# associate the temperature data with its corresponding city.
names(temp) <- city
temp

# 4. Use the [ and : operators to access the temperature of the first three cities 
# on the list.
temp[1:3]

# 5. Use the [ operator to access the temperature of Paris and San Juan.
temp["Paris"]
temp["San Juan"]

# 6. Use the : operator to create a sequence of numbers 12,13,14,.,73
s6 <- 12:73

# 7. Create a vector containing all the positive odd numbers smaller than 100.
s7 <- seq(1,100,2)
s7

# 8. Create a vector of numbers that starts at 6, does not pass 55, and adds 
# numbers in increments of 4/7: 6, 6 + 4/7, 6 + 8/7, and so on. How many numbers 
# does the list have? Hint: use seq and length.
s1 <- seq(0,(55-6),4/7)
s2 <- s1 + 6
length(s2)

# 9. What is the class of the following object a <- seq(1, 10, 0.5)?
a <- seq(1, 10, 0.5)
class(a)

# 10. What is the class of the following object a <- seq(1, 10)?
a <- seq(1, 10)
class(a)

# 11. The class of class(a<-1) is numeric, not integer. R defaults to numeric and 
# to force an integer, you need to add the letter L. Confirm that the class of 1L 
# is integer.
class(-1)
class(1L)

# 12. Define the following vector:
x <- c("1", "3", "5")
# and coerce it to get integers
as.integer(x)
