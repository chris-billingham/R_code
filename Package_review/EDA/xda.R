#xda
#EDA
#By Ujjwal Karn
#
#https://github.com/ujjwalkarn/xda

#monthly download:
#https://www.rdocumentation.org/packages/xda/versions/0.2

library(devtools)
install_github("ujjwalkarn/xda")
library(xda)



# airquality data set example 
#https://www.rdocumentation.org/packages/datasets/versions/3.4.3/topics/airquality
head(airquality)

numSummary(airquality)

# diamonds data set example 
#http://ggplot2.tidyverse.org/reference/diamonds.html
library(ggplot2)
head(diamonds)

numSummary(diamonds)



