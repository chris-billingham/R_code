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


###################     Douban            #####################################
pages=seq(0, 100, 25)
all_title=character()
all_count=character()
all_writter=character()
all_link=character()
all_time=character()
for (page in pages){
  douban=read_html(paste("https://www.douban.com/group/haixiuzu/discussion?start=",page,sep=""))
  title=douban%>%html_nodes(".olt .title a")%>%html_text()
  view_count=douban%>%html_nodes(".title~ td:nth-child(3)")%>%html_text()
  writter=douban%>%html_nodes(".title+ td")%>%html_text()
  link=douban%>%html_nodes(".olt .title a")%>%html_attr("href")
  time=douban%>%html_nodes(".time")%>%html_text()
  all_title=c(all_title,title)
  all_count=c(all_count,view_count)
  all_writter=c(all_writter,writter)
  all_link=c(all_link,link)
  all_time=c(all_time,time)
}


df=data.frame(all_title,all_writter,all_count,all_link,all_time)
df$all_title=gsub("[[:blank:]]","",df$all_title)
df$all_writter=gsub("[[:blank:]]","",df$all_writter)
df$all_count=as.numeric(df$all_count)
df$all_time=as.Date(df$all_time)

df=df[order(-df$all_count),]
str(df)
head(df)

browseURL(as.character(df$all_link[1]), browser = getOption("browser"),
          encodeIfNeeded = FALSE)

top001=read_html(as.character(df$all_link[10]))
#top001=read_html("https://www.douban.com/group/topic/89313590/")
pic=top001%>%html_nodes("#link-report img")%>%html_attr("src")
pop_common=top001%>%html_nodes(".popular-bd p")%>%html_text()
pop_common

for (a in pic){
    download.file(a,paste(substr(a, nchar(a)-12, nchar(a)-3),'.jpg',sep=""), mode = 'wb')
}

getwd()
############# encoding ##############################
url="http://bbs.pinggu.org/"
  
x <- content(GET(url), "raw")
guess_encoding(x)  
read_html(url, encoding = "ISO-8859-1")  





