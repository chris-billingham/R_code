#DataExplorer
#EDA
#By Boxuan Cui
#https://cran.r-project.org/web/packages/DataExplorer/
#https://github.com/boxuancui/DataExplorer

#monthly download:267
#https://www.rdocumentation.org/packages/DataExplorer/versions/0.5.0

install.packages('DataExplorer') 
library(DataExplorer)


# airquality data set example 
#https://www.rdocumentation.org/packages/datasets/versions/3.4.3/topics/airquality
head(airquality)
create_report(airquality)

plot_missing(airquality)
plot_histogram(airquality)
plot_density(airquality)

plot_bar(airquality)


# diamonds data set example 
#http://ggplot2.tidyverse.org/reference/diamonds.html
library(ggplot2)
head(diamonds)

plot_missing(diamonds)
plot_histogram(diamonds)
plot_density(diamonds)
plot_bar(diamonds)

create_report(diamonds)

diamonds%>%arrange(desc(carat))

#########   fun  ######

#Bug 
library(dplyr)
tt=airquality%>%count(Day)
a=airquality
table(airquality$Day)
hist(airquality$Day)


