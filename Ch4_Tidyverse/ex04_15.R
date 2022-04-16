# Q1 ----------------------------------------------------------------------
# 1. Load the murders dataset. Which of the following is true?
# a.murders is in tidy format and is stored in a tibble.
# b.murders is in tidy format and is stored in a data frame.
# c.murders is not in tidy format and is stored in a tibble.
# d.murders is not in tidy format and is stored in a data frame.
# (answer: b)

data(murders)

# Q2 ----------------------------------------------------------------------
# 2. Use as_tibble to convert the murders data table into a tibble and save it 
# in an object called murders_tibble.
murder_tibble <- as_tibble(murders)


# Q3 ----------------------------------------------------------------------
# 3. Use the group_by function to convert murders into a tibble that is 
# grouped by region.
group_by(murders,region)


# Q4 ----------------------------------------------------------------------
# Write tidyverse code that is equivalent to this code:
exp(mean(log(murders$population)))

murders %>% 
  .$population %>%
  log() %>%
  mean() %>%
  exp()

# Q5 ----------------------------------------------------------------------
# 5. Use the map_df to create a data frame with three columns named n, s_n, 
# and s_n_2. The first column should contain the numbers 1 through 100. 
# The second and third columns should each contain the sum of 1 through n 
# with n the row number.
n<-1:100

comp_s_n<-function(n){
  v<- 1:n
  tibble(s_n=sum(v))
}

comp_s_n_2<-function(n){
  v<- 1:n
  tibble(s_n_2=sum(v))
}

df<-data.frame(n,map_df(n, comp_s_n),map_df(n, comp_s_n_2))
class(df)
head(df)
