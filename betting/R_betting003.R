install.packages("rvest")

library(rvest)

########## example ##################
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating


###############      cover         ########################
url="http://www.covers.com/pageLoader/pageLoader.aspx?page=/data/nba/teams/teams.html"

url_read=read_html(url)

url_nodes <- html_nodes(url_read,css='#content a')

team_name <- html_text(url_nodes)
team_link = html_attr(url_nodes,'href')
head(team_name)
head(team_link)
team_name=as.data.frame(team_name)
team_link=as.data.frame(team_link)
team=cbind(team_name,team_link)
team

GS001_url='http://www.covers.com/pageLoader/pageLoader.aspx?page=/data/nba/teams/pastresults/2016-2017/team404117.html'
GS001_read=read_html(GS001_url)
GS001_nodes <- html_nodes(GS001_read,xpath='//*[@id="LeftCol-wss"]/table[2]')
team_games <- html_table(GS001_nodes)
team_games
team_games002=team_games[[1]]
team_games002
