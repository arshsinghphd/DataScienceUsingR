# 1. Examine the built-in dataset co2. Which of the following is true:

# a. co2 is tidy data: it has one year for each row.
# b. co2 is not tidy: we need at least one column with a character vector.
# c. co2 is not tidy: it is a matrix instead of a data frame.
# d. co2 is not tidy: to be tidy we would have to wrangle it to have 
#    three columns (year, month and value), then each co2 observation would 
#   have a row. 
# (answer: d)

library(tidyverse)
data(co2)
str(co2)
#timeseries
frequency(co2)
start(co2)
end(co2)

# 2. Examine the built-in dataset ChickWeight. Which of the following is true:
# a.ChickWeight is not tidy: each chick has more than one row.
# b.ChickWeight is tidy: each observation (a weight) is represented by one row. 
#   The chick from which this measurement came is one of the variables.
# c.ChickWeight is not tidy: we are missing the year column.
# d.ChickWeight is tidy: it is stored in a data frame.
# (answer: b)

data("ChickWeight")
chwt<-ChickWeight
str(chwt)
head(chwt,20)

# 3. Examine the built-in dataset BOD. Which of the following is true:
# a.BOD is not tidy: it only has six rows.
# b.BOD is not tidy: the first column is just an index.
# c.BOD is tidy: each row is an observation with two values (time and demand)
# d.BOD is tidy: all small datasets are tidy by definition.
# (answer: c)
data(BOD)
head(BOD)
str(BOD)

#4. Which of the following built-in datasets is tidy (you can pick more than one):
# BJsales         <- ts, not tidy
# EuStockMarkets  <- ts, not tidy
# DNase           <- tidy
# Formaldehyde    <- tidy
# Orange          <- tidy
# UCBAdmissions   <- table, not tidy 
data("BJsales")
str(BJsales)
frequency(BJsales)

data(EuStockMarkets)
str(EuStockMarkets)

data(DNase)
str(DNase)
head(DNase)
attributes(DNase)

data(Formaldehyde)
str(Formaldehyde)
head(Formaldehyde)

data(Orange )
str(Orange)
head(Orange)
attributes(Orange)

data(UCBAdmissions)
str(UCBAdmissions)
# table
attributes(UCBAdmissions)
head(UCBAdmissions,20)
summary(UCBAdmissions)
