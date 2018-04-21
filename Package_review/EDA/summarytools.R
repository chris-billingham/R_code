#summarytools
#EDA
#By Dominic Comtois
#https://cran.r-project.org/web/packages/summarytools/
#https://github.com/dcomtois/summarytools

#monthly download:269
#https://www.rdocumentation.org/packages/summarytools/versions/0.8.3

install.packages("summarytools")
library(summarytools)

# iris data set example 
head(iris)
view(dfSummary(iris))

# airquality data set example 
#https://www.rdocumentation.org/packages/datasets/versions/3.4.3/topics/airquality
head(airquality)

view(dfSummary(airquality))

# diamonds data set example 
#http://ggplot2.tidyverse.org/reference/diamonds.html
library(ggplot2)
head(diamonds)

view(dfSummary(diamonds))




