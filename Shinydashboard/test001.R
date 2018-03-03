
library(summarytools)
library(readxl)

library(dplyr)

dd=read_excel('df.xlsx')
glimpse(iris)

a=view(dfSummary(dd), file = "EDA.html")




