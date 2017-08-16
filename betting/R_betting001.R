
##################  pinnacle.API  ############################

#install.packages('pinnacle.API')
library(pinnacle.API)
library(data.table)
library(openssl)
library(httr)
library(jsonlite)
library(uuid)
library(purrr)
library(magrittr)
#devtools::install_github("durtal/betfaiR")
library(betfaiR)

AcceptTermsAndConditions(accepted=TRUE)
#Y
SetCredentials()
#TF967175
#UIO789uio!
SetCredentials("TF967175","UIO789uio!")
GetSports()
# Get Sports
sport_data <- GetSports(force = TRUE)
sport_data <- GetSports(force = FALSE)
# Get Soccer id
soccer_id <- with(sport_data, id[name == 'Soccer'])
# Get Odds
soccer_data <- showOddsDF(soccer_id)

# Lets select a single record and see what we're looking at
# (transposed for easier reading)


Sys.setenv(LANG = "en")
##################  Betfair.API with betfaiR  ############################


#jcwinningco@613.com
#UIO789uio!
bf <- betfair(usr = "jcwinningco@163.com",
              pwd = "UIO789uio!",
              key = "I7veNYyOtC72yqo4")

bf$session()

# return all countries
tmp <- bf$countries()
head(tmp)

# return all competitions and NBA games
tmp <- bf$competitions()
head(tmp)
tmp002=tmp[order(tmp$competitionRegion),] 
tmp[grep("nba", tolower(tmp$competition_name)), ]

# return all sport type
tmp <- bf$eventTypes()
head(tmp)

# return all football competitions
tmp <- bf$competitions(filter = marketFilter(eventTypeIds = 1))
head(tmp)

# return all basketball competitions
tmp <- bf$competitions(filter = marketFilter(eventTypeIds = 7522))
head(tmp)

# return all  NBA events whose start date is beyond next week
tmp <- bf$eventTypes(filter = marketFilter(eventTypeIds = 7522))
tmp <- bf$eventTypes(filter = marketFilter(eventTypeIds = 7522, from = Sys.Date() + 7))
tmp

# return all NBA  
tmp <- bf$events(filter = marketFilter(competitionIds = 10547864))
head(tmp)


# get market data on just one market
tmp <- bf$marketCatalogue()
tmp
summary(tmp)
# get market data with details about the event and the runners
tmp <- bf$marketCatalogue(marketProjection = c("EVENT", "runner_metadata"))
summary(tmp)
tmp

# to access the runners data
tmp[[1]]$runners

# horse racing data
tmp <- bf$marketCatalogue(filter = marketFilter(eventTypeIds = 7,
                                                marketCountries = "GB",
                                                marketTypeCodes = "WIN"),
                          marketProjection = c("event", "runner_metadata"))
summary(tmp)


# nba data
tmp <- bf$marketCatalogue(filter = marketFilter(competitionIds = 10547864),
                          marketProjection = c("COMPETITION","event","EVENT_TYPE"))
summary(tmp)


tmp <- bf$marketCatalogue(filter = marketFilter(competitionIds = 10547864,
                                                marketTypeCodes = "MATCH_ODDS"),
                          marketProjection = c("COMPETITION","EVENT","EVENT_TYPE","MARKET_START_TIME",
                                               "MARKET_DESCRIPTION",
                                               "RUNNER_DESCRIPTION","RUNNER_METADATA"),
                          maxResults = 5)
summary(tmp)

market <- bf$marketBook(marketIds = 1.131629091,
                        priceProjection=c("SP_AVAILABLE","SP_TRADED","EX_BEST_OFFERS",
                                          "EX_ALL_OFFERS","EX_TRADED")
                  
                        )
summary(market)


############    Odd        ########################
bf$currentOrders(betId = NULL,
                 marketId = 1.131629091,
                 orderProjection = "ALL",
                 from = NULL,
                 to = NULL,
                 orderBy = "BY_BET",
                 sort = "EARLIEST_TO_LATEST",
                 fromRecord = NULL,
                 count = NULL)




