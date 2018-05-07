# GCVM
# Get;Clean;visualize;model




# Get





# Clean
# Writing Functions in R
#https://www.datacamp.com/courses/writing-functions-in-r
# Introduction to the Tidyverse
#https://www.datacamp.com/courses/introduction-to-the-tidyverse
# Communicating with Data in the Tidyverse
#https://www.datacamp.com/courses/communicating-with-data-in-the-tidyverse
# Data Analysis in R, the data.table Way
#https://www.datacamp.com/courses/data-table-data-manipulation-r-tutorial
# Writing Efficient R Code
#https://www.datacamp.com/courses/writing-efficient-r-code
# String Manipulation in R with stringr
#https://www.datacamp.com/courses/string-manipulation-in-r-with-stringr



# visualization
#Building Dashboards with shinydashboard
#https://www.datacamp.com/courses/building-dashboards-with-shinydashboard
# Building Web Applications in R with Shiny: Case Studies
#https://www.datacamp.com/courses/building-web-applications-in-r-with-shiny-case-studies





# model
# Forecasting Product Demand in R
#https://www.datacamp.com/courses/forecasting-product-demand-in-r
# Supervised Learning in R: Regression
# https://www.datacamp.com/courses/supervised-learning-in-r-regression
# Supervised Learning in R: Classification
# https://www.datacamp.com/courses/supervised-learning-in-r-classification
# Text Mining: Bag of Words
#https://www.datacamp.com/courses/intro-to-text-mining-bag-of-words
# Machine Learning with Tree-Based Models in R
#https://www.datacamp.com/courses/machine-learning-with-tree-based-models-in-r
# Cluster Analysis in R
#https://www.datacamp.com/courses/cluster-analysis-in-r
# Human Resources Analytics in R: Exploring Employee Data
#https://www.datacamp.com/courses/human-resources-analytics-in-r-exploring-employee-data
# Network Analysis in R
#https://www.datacamp.com/courses/network-analysis-in-r
# Network Science in R - A Tidy Approach
#https://www.datacamp.com/courses/network-science-in-r-a-tidy-approach
# Hierarchical and Mixed Effects Models
#https://www.datacamp.com/courses/hierarchical-and-mixed-effects-models
# Business Process Analytics in R
#https://www.datacamp.com/courses/business-process-analytics-in-r
# Valuation of Life Insurance Products in R
#https://www.datacamp.com/courses/valuation-of-life-insurance-products-in-r
# Data Privacy and Anonymization in R
#https://www.datacamp.com/courses/data-privacy-and-anonymization-in-r








library(dplyr)
library(sqldf)
data001=read.table('1.txt')
head(data001)
glimpse(data001)
data002=cbind(data001,ind=1:nrow(data001))

data002=data001%>%mutate(new_v56_a=paste(V5,V6),new_v56_b=paste(V6,V5)
                         
data003=sqldf('select a.* from data002 a left join data002 b on a.new_v56_a=b.new_v56_a')                         
                         
                         
)%>%mutate(V56_flag=ifelse(new_v56_a %in% new_v56_b,1,0)
)%>%filter(V56_flag==1)

%>%select(-new_v56_a,-new_v56_b,-V56_flag)

data002  
glimpse(data002)
