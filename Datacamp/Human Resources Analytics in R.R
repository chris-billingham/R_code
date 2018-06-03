# https://campus.datacamp.com/courses/human-resources-analytics-in-r-exploring-employee-dat
# by Ben Teusch
library(readr)
#data
recruitment=read_csv('https://assets.datacamp.com/production/course_5977/datasets/recruitment_data.csv')
# Import the data
survey <- read_csv("https://assets.datacamp.com/production/course_5977/datasets/survey_data.csv")


# Load the dplyr package
library(dplyr)

# Get an overview of the recruitment data
summary(recruitment)

# See which recruiting sources the company has been using
recruitment %>% 
  count(recruiting_source)

# Find the average attrition for the sales team, by recruiting source, sorted from lowest attrition rate to highest
avg_attrition <- recruitment %>%
  group_by(recruiting_source) %>% 
  summarize(attrition_rate = mean(attrition)) %>% 
  arrange(attrition_rate)

# Display the result
avg_attrition
# Load the ggplot2 package

# Find the average sales quota attainment for each recruiting source
avg_sales <- recruitment %>%
  group_by(recruiting_source) %>% 
  summarize(avg_sales_quota_pct = mean(sales_quota_pct)) 
library(ggplot2)

# Plot the bar chart
ggplot(avg_sales, aes(x = recruiting_source, y = avg_sales_quota_pct)) +
  geom_col()


# Plot the bar chart
ggplot(avg_attrition, aes(x = recruiting_source, y = attrition_rate)) +
  geom_col()


# Load the packages
library(dplyr)

# Get an overview of the data
summary(survey)
# Examine the counts of the department variable
survey %>% 
  count(department)

# Output the average engagement score for each department, sorted
survey %>%
  group_by(department) %>%
  summarize(avg_engagement = mean(engagement)) %>%
  arrange(avg_engagement)


# Create the disengaged variable and assign the result to survey
survey_disengaged <- survey %>% 
  mutate(disengaged = ifelse(engagement <= 2, 1, 0)) 

survey_disengaged

# Summarize the three variables by department
survey_summary <- survey_disengaged %>% 
  group_by(department) %>% 
  summarize(pct_disengaged = mean(disengaged),
            avg_salary = mean(salary),
            avg_vacation_days = mean(vacation_days_taken))

survey_summary
# Load packages
library(ggplot2)
library(tidyr)

# Gather data for plotting
survey_gathered <- survey_summary %>% 
  gather(key = "measure", value = "value",
         pct_disengaged, avg_salary, avg_vacation_days)

# Create three bar charts
ggplot(survey_gathered, aes(measure, value, fill = department)) +
  geom_col(position = "dodge")
library(ggplot2)

# Create three faceted bar charts
ggplot(survey_gathered, aes(measure, value, fill = department)) +
  geom_col(position = "dodge") +
  facet_wrap(~ measure, scales = "free")


# Add the in_sales variable
survey_sales <- survey %>%
  mutate(in_sales = ifelse(department == "Sales", "Sales", "Other")
         ,disengaged = ifelse(engagement <= 2, 1, 0))


table(survey_sales$in_sales,survey_sales$disengaged)


# Test the hypothesis using survey_sales
chisq.test(survey_sales$in_sales, survey_sales$disengaged)






