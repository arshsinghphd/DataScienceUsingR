library(data.table)
library(dplyr)
library(dslabs)
library(NHANES)
rm(list=ls())
data("NHANES")

# 1. We will provide some basic facts about blood pressure. First let's 
# select a group to set the standard. We will use 20-to-29-year-old females.
# AgeDecade is a categorical variable with these ages. Note that the 
# category is coded like " 20-29", with a space in front! Use the 
# data.table package to compute the average and standard deviation of 
# systolic blood pressure as saved in the BPSysAve variable. 
# Save it to a variable called ref.
setDT(NHANES)
NHANES %>% head()
ref <- NHANES[AgeDecade==" 20-29",.(average=mean(BPSysAve,na.rm=TRUE),std=sd(BPSysAve,na.rm=TRUE))]
ref

# Q2 ----------------------------------------------------------------------
# Report the min and max values for the same group.
NHANES[AgeDecade==" 20-29",.(minimum=min(BPSysAve,na.rm=TRUE),maximum=max(BPSysAve,na.rm=TRUE))]

# Q3 ----------------------------------------------------------------------
# Compute the average and standard deviation for females, but for each age group separately rather
# than a selected decade as in question 1. Note that the age groups are defined by AgeDecade.
NHANES[Gender=="female",.(average=mean(BPSysAve,na.rm=TRUE),std=sd(BPSysAve,na.rm=TRUE)),by=AgeDecade]

# Q4 ----------------------------------------------------------------------
# Repeat exercise 3 for males.
NHANES[Gender=="male",.(average=mean(BPSysAve,na.rm=TRUE),std=sd(BPSysAve,na.rm=TRUE)),by=AgeDecade]

# Q5 ----------------------------------------------------------------------
# For males between the ages of 40-49, compare systolic blood pressure across race as reported in
# the Race1 variable. Order the resulting table from lowest to highest average systolic 
# blood pressure.
NHANES[Gender=="male" & AgeDecade==" 40-49",
       .(average=mean(BPSysAve,na.rm=TRUE),
         std=sd(BPSysAve,na.rm=TRUE)
         ),
       by=Race1
       ][order(average)]
