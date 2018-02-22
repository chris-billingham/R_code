#install.packages("tidyquant")
#install.packages("Quandl")
#install.packages("PerformanceAnalytics")
#install.packages("installr")

library(installr)
version
updateR()

library(quantmod)
library(tidyquant)
library(Quandl)
library(xts)
library(PerformanceAnalytics)

i=0
repeat{
  i=i+1
  print(i)
  if(i>50){break}
}


data=rnorm(5)

# Create dates as a Date class object starting from 2016-01-01
dates <- seq(as.Date("2016-01-01"), length = 5, by = "days")

# Use xts() to create smith
smith <- xts(x = data, order.by = dates)

# Create bday (1899-05-08) using a POSIXct date class object
bday <- as.POSIXct("1899-05-08")

# Create hayek and add a new attribute called born
hayek <- xts(x = data, order.by = dates, bornbday)
hayek

dates <- as.Date("2016-01-01") + 0:4
dates
as.POSIXct(dates)
