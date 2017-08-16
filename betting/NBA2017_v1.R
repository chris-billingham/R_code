#####################################
# 1 Package 
# 2 Data import
# 3 Data EDA
# 4 Data Cleaning
######################################
# 5 Data Modeling
# 6 Model Vaildation 
# 7 Model scoring
# 8 Data output
######################################

########    1 Package        ##########
library(rvest)
library(httr)
library(curl)
library(dplyr)


########    2 Data import        #####



####### Game by Game  ###########
month_ve=c('october','november','december','january','february','march','april','may','june')

for (month in month_ve){
  month<-paste('https://www.basketball-reference.com/leagues/NBA_2016_games-',month,sep='')
}

a=data.frame(v1='https://www.basketball-reference.com/leagues/NBA_2016_games-',v2=month_ve,v3='.html',stringsAsFactors=FALSE)
a$full_link=paste(paste(a$v1,a$v2,sep=''),a$v3,sep='')
a


#url_oct='https://www.basketball-reference.com/leagues/NBA_2016_games-october.html'
GBG003=data.frame()
for (url in a$full_link){
  print(url)
  download.file(url, destfile = "C:/Users/User/Desktop/Mission/R/code/scrapedpage.html", quiet=TRUE)  
  GBG001 <- read_html("C:/Users/User/Desktop/Mission/R/code/scrapedpage.html")
  GBG002=data.frame(GBG001%>%html_nodes("#schedule")%>%html_table())
  GBG003=rbind(GBG003,GBG002)
}


glimpse(GBG003)



####### Game +player

####### player #######

####### team ##########





