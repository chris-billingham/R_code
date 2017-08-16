library(data.table)
library(openssl)
library(httr)
library(jsonlite)
library(uuid)
library(purrr)
library(magrittr)
#devtools::install_github("durtal/betfaiR")
library(betfaiR)
##################  Betfair.API with betfaiR  ############################
#jcwinningco@613.com
#UIO789uio!
bf <- betfair(usr = "jcwinningco@163.com",
              pwd = "UIO789uio!",
              key = "I7veNYyOtC72yqo4")

bf$session()

###########################  NBA ###################################
#competition:NBA
#event:Golden State Warriors v San Antonio Spurs
#marketTypes:eg. WINNER, HANDICAP, OVER_UNDER_25, etc
#Market ID:Moneyline


# return all competitions and NBA games
tmp <- bf$competitions()
head(tmp)
tmp[grep("nba", tolower(tmp$competition_name)), ]




# return all NBA  
bf$events(filter = marketFilter(competitionIds = 9310282)) #NBA Outrights 
bf$events(filter = marketFilter(competitionIds = 10547864)) #NBA 

# Golden State Warriors v San Antonio Spurs
bf$events(filter = marketFilter(eventIds = 28231933)) 

bf$marketTypes(filter = marketFilter(eventIds = 28231933))

tmp <- bf$marketTypes(filter = marketFilter(eventId = 28231933))
head(tmp)

############## find market id   ######################
tmp <- bf$marketCatalogue(filter = marketFilter(eventIds = 28231933),
                          marketProjection = c("EVENT", "runner_metadata","MARKET_DESCRIPTION","RUNNER_DESCRIPTION")
                          ,maxResults = 30)
summary(tmp)
tmp
################ market Moneyline:1.131629091  ######################


tmp=bf$marketBook(marketIds = list(1.131629091),
              priceProjection = "EX_BEST_OFFERS",
              orderProjection = "EXECUTABLE",
              matchProjection = "NO_ROLLUP",
              getRunners = NULL)
summary(tmp)
tmp





















