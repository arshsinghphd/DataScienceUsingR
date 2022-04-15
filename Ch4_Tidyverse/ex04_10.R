library(NHANES)
data(NHANES)

# Q1 ----------------------------------------------------------------------
# 1. We will provide some basic facts about blood pressure. 
# First let’s select a group to set the standard. 
# We will use 20-to-29-year-old females. 
# AgeDecade is a categorical variable with these ages. 
# Note that the category is coded like " 20-29", with a space in front! 
# What is the average and standard deviation of systolic blood pressure as saved 
# in the BPSysAve variable? Save it to a variable called ref.
# Hint: Use filter and summarize and use the 
# na.rm = TRUE argument when computing the average and standard deviation. 
# You can also filter the NA values using filter.

head(NHANES)
#use na.rm=TRUE with mean and sd
ref <- NHANES %>% 
  filter(Gender=="female" & AgeDecade==" 20-29") %>%
  select(BPSysAve) %>%
  summarize(ave=mean(BPSysAve,na.rm = TRUE),std=sd(BPSysAve,na.rm = TRUE)) 

ref

# filter to remove NA in BPSysAve (less preferrable)
ref <- NHANES %>% 
  filter(Gender=="female" & AgeDecade==" 20-29" & BPSysAve!='NA') %>%
  select(BPSysAve) %>%
  summarize(ave=mean(BPSysAve),std=sd(BPSysAve))

ref

# Q2 ----------------------------------------------------------------------
# 2. Using a pipe, assign the average to a numeric variable ref_avg. 
# Hint: Use the code similar to above and then pull.

ref_ave <- ref %>% pull(ave)
ref_ave

ref_std <- ref %>% pull(std)
ref_std


# Q3 ----------------------------------------------------------------------
#3. Now report the min and max values for the same group.

stats <- NHANES %>% 
  filter(Gender=="female" & AgeDecade==" 20-29" & BPSysAve!='NA') %>%
  summarize(min_median_max=quantile(BPSysAve,c(0,0.5,1)))%>%
  pull()
stats
stats['0%']
stats['100%']


# Q4 ----------------------------------------------------------------------
# 4. Compute the average and standard deviation for females, but for each age 
# group separately rather than a selected decade as in question 1. 
# Note that the age groups are defined by AgeDecade. 
# Hint: rather than filtering by age and gender, 
# filter by Gender and then use group_by.
stats <- NHANES %>% 
  filter(Gender=='female' &  BPSysAve!='NA') %>%
  group_by(AgeDecade) %>% 
  summarize(ave=mean(BPSysAve), std=sd(BPSysAve))
stats


# Q5 ----------------------------------------------------------------------
# 5. Repeat exercise 4 for males.
stats <- NHANES %>% 
  filter(BPSysAve!='NA') %>%
  group_by(Gender,AgeDecade) %>% 
  summarize(ave=mean(BPSysAve), std=sd(BPSysAve))
stats
male_stats <- stats %>% filter(Gender=='male')
male_stats


# Q6 ----------------------------------------------------------------------
# We can actually combine both summaries for exercises 4 and 5 into one 
# line of code. This is because group_by permits us to group by more 
# than one variable. Obtain one big summary table using
# group_by(AgeDecade, Gender).

# already done above
stats


# Q7 ----------------------------------------------------------------------
# For males between the ages of 40-49, compare systolic blood pressure across
# race as reported in the Race1 variable. Order the resulting table from lowest
# to highest average systolic blood pressure.
race_bp <- NHANES %>% 
  filter(BPSysAve!='NA' & AgeDecade==' 40-49') %>%
  group_by(Race1) %>%
  summarize(ave=mean(BPSysAve)) %>%
  arrange(ave)
race_bp  
