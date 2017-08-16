
#install.packages("qrmdata")
#install.packages("xts")
library(qrmdata)
library(xts)

Sys.setlocale(locale = "English")


####################### S&P500 ################################################
data(SP500)
head(SP500)

tail(SP500)
dim(SP500)

plot(SP500)

####################### Dow Jones index #############################################
data("DJ")

# Show head() and tail() of DJ index
head(DJ)
tail(DJ)

# Plot DJ index
plot(DJ)

# Extract 2008-2009 and assign to dj0809
dj0809 <-DJ["2008-01-01/2009-12-31"]

# Plot dj0809
plot(dj0809)


####################### UK FTSE (Financial Times Stock Exchange) index   ##################

data("FTSE")

head(FTSE)
tail(FTSE)

plot(FTSE)

<<<<<<< HEAD


=======
>>>>>>> f5a2a5f6d75e8c56a4a99752ef0dcf005566cb61
########################################################
# Load DJ constituents and view names
data("DJ_const")
names(DJ_const)


# Extract APPL and GS in 2008-09 and assign them to stocks
stocks=DJ_const[, c(1, 10)]["2008-01-01/2009-12-31"]

# Plot stocks with plot.zoo()
plot.zoo(stocks)


<<<<<<< HEAD
###############       FX    ########################################
=======
#######################################################
>>>>>>> f5a2a5f6d75e8c56a4a99752ef0dcf005566cb61

# Load "GBP_USD" and "EUR_USD"
data("GBP_USD")
data("EUR_USD")

# Plot the two exchange rates
plot(GBP_USD)
plot(EUR_USD)

# Plot a "USD_GBP" exchange rate (not GBP_USD)
plot(1/GBP_USD)

# Merge the two exchange rates EUR_USD and GBP_USD
fx <- merge(GBP_USD, EUR_USD, all = TRUE)

# Extract the merged time series for 2010-2015 and assign to fx0015
fx0015=fx["2010-01-01/2015-12-31"]

# Plot the exchange rates for the period 2010-2015
<<<<<<< HEAD
plot.zoo(fx0015)


data("CNY_USD")

plot.zoo(1/CNY_USD)

############################################

sp500x=diff((log(SP500)))[-1]

head(sp500x)

plot(sp500x)
plot.zoo(sp500x)

sp500x_w=apply.weekly(sp500x,sum)

=======
plot.zoo()(fx0015)
>>>>>>> f5a2a5f6d75e8c56a4a99752ef0dcf005566cb61
