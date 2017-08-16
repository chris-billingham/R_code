#############  stattleship   ############
#App Name
#poshsunshine
#Client Id
#dd71e5c9bf527d5c033ae08d4990747b
#Client Secret
#17f51993aeea43dc14744b369e0deee942d5b8bcfbcf26aea330ad69b1c056b7
#Access Token
#615d09a842951f27266d77202c31974a
#######################################


library (plyr)
library(stringr)
library(dplyr)
library(tidyr)
library(sqldf)

version
#devtools::install_github("stattleship/stattleship-r")
library(stattleshipR)
set_token('615d09a842951f27266d77202c31974a')

##############################    Get all NBA players   bio   ########################:
league <- "nba"
sport <- "basketball"
ep <- "players"
q_body <- list()
players <- ss_get_result(sport = sport, league = league, ep = ep,
                         query = q_body, version = 1, walk = TRUE)

length(players)
class(players)
summary(players)
(players)[1]
players_df <- do.call("rbind", lapply(players, function(x) x$players))
players_df

#############################  Games  #############################################

league <- "nba"
sport <- "basketball"
ep <- "games"
q_body <- list(interval_type = 'regularseason')
games <- ss_get_result(sport = sport, league = league, ep = ep,
                         query = q_body, version = 1, walk = TRUE)

games_df <- do.call("rbind", lapply(games, function(x) x$games))
games_df001=games_df[c("started_at","label","home_team_score","away_team_score"
                       ,"home_team_outcome","away_team_outcome"
                       ,"score_differential","attendance","duration")]
head(games_df)

names(games_df001)
summary(games_df001)
str(games_df001)
order(games_df001$score_differential)
games_df001 <- games_df001[order(-games_df001$score_differential),] 


games_df001=separate(data = games_df001, col = started_at, into = c("game_date", "game_date_time"), sep = "T")
games_df001=separate(data = games_df001, col = label, into = c("away_team", "home_team"), sep = " vs ")
games_df001=games_df001[games_df001$away_team!="Eastern Conference",]
games_df001$home_win_flag=ifelse(games_df001$home_team_outcome=="win",1,0)

str(games_df001)
sqldf("select * from games_df001")
sqldf("select * from games_df001 where home_team='Eastern Conference'")

sqldf("select home_team,max(score_differential) as max_score_differential from games_df001 group by home_team order by max_score_differential desc")
sqldf("select home_team,count(*) as game_cnt,sum(home_win_flag) as win_cnt
      ,avg(home_team_score) as home_team_score ,avg(away_team_score) as away_team_score
      ,avg(home_team_score)-avg(away_team_score) as diff
      from games_df001 group by home_team order by win_cnt desc")

