#install.packages("rvest")
#install.packages("jpeg")
#install.packages("installr")
#install.packages("httr")
#Sys.setlocale("LC_ALL","Chinese")
#library(installr)
#updateR()
#install.packages("xml2")
library(xml2)
library(rvest)
library(jpeg)
library(httr)

#################    IMDB  ###################################
imdb=read_html("http://www.imdb.com/movies-in-theaters/")

title=imdb%>%html_nodes("h4 a")%>%html_text()
title
genre=imdb%>%html_nodes("time+ span")%>%html_text()
genre
time=imdb%>%html_nodes("time")%>%html_text()

imdb_table=data.frame(title,genre,time)
imdb_table$time=gsub(" min","",imdb_table$time)
imdb_table$time=as.numeric(imdb_table$time)


movie=read_html("http://www.imdb.com/search/name?birth_monthday=4-8&ref_=nv_cel_brn_1&refine=birth_monthday&start=1")
title=movie%>%html_nodes(".name > a")%>%html_text()

pages=seq(1, 200, 50)
all_title=character()
for (page in pages){
  movie=read_html(paste("http://www.imdb.com/search/name?birth_monthday=4-8&ref_=nv_cel_brn_1&refine=birth_monthday&start=",page,sep=""))
  title=movie%>%html_nodes(".name > a")%>%html_text()
  all_title=c(all_title,title)
}

all_title



