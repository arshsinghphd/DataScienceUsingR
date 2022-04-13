# 1. Previously we created this data frame:
temp <- c(35, 88, 42, 84, 81, 30)
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", 
          "San Juan", "Toronto")
city_temps <- data.frame(name = city, temperature = temp)

# Remake the data frame using the code above, but add a line that converts the
# temperature from Fahrenheit to Celsius. The conversion is C=59??(F???32)
temp_c <- (temp-32)*5/9 
city_temps <- data.frame(name = city, temperature = temp_c)

# 2. What is the following sum 1+1/2^2+1/3^2+???1/100^2
# Hint: thanks to Euler, we know it should be close to ??^2/6
s <- 1:100
ans <- 1/s^2
sum(ans)
# 1.634984
pi^2/6
# 1.644934

# 3. Compute the per 100,000 murder rate for each state and store it in the 
# object murder_rate. Then compute the average murder rate for the US using the
# function mean. What is the average?
murder_rate <- murders$total*100000/murders$population 
mean(murder_rate)
# 2.779