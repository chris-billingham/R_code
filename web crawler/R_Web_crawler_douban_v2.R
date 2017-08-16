#install.packages("rvest")
#install.packages("jpeg")
#install.packages("installr")
#install.packages("httr")
#Sys.setlocale("LC_ALL","Chinese")
#library(installr)
#updateR()
#install.packages("xml2")
#install.packages(c("xml2","rvest","jpeg","httr","stringr","dplyr"))
library(xml2)
library(rvest)
library(jpeg)
library(httr)
library(stringr)
library(dplyr)
Sys.setlocale(locale='Chinese')

###################     Douban            #####################################

R_douban=function(x="女朋友",y=5,z=2){
y=floor(y)
z=floor(z)
if (y>10){y=10}
if (y<1){y=1}
if (z>5){y=5}  
if (z<1){z=1}
  
library(xml2)
library(rvest)
library(jpeg)
library(httr)
library(stringr)
library(dplyr)
Sys.setlocale(locale='Chinese')
group_url=paste("https://www.douban.com/search?cat=1019&q=",x,sep="")

group_url_read=read_html(group_url)
group_name=group_url_read%>%html_nodes(".title a")%>%html_text()
group_link=group_url_read%>%html_nodes(".title a")%>%html_attr("onclick")

first=regexpr("sid: ",group_link)
last=regexpr(", qcat",group_link)
group_id=substr(group_link,first+5,last-1)
group_id
group_id2=group_id[(1:y)]
groups=paste("https://www.douban.com/group/",group_id2,sep="")

pages=seq(0, (z-1)*25, 25)  # 0 25  from 0 to 25 by 25 
all_title=character()
all_group=character()
all_count=character()
all_writter=character()
all_link=character()
all_time=character()
topic=0
n=0
for (group in groups){
  n=n+1
  print(paste("Group name:",group_name[n]))
for (page in pages){
  print(paste("Current page number:",page/25+1))
  group2=paste(group,"/discussion?start=",sep="")
  douban=read_html(paste(group2,page,sep=""))
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
  all_group=c(all_group,rep(group_name[n],length(title)))
  Sys.sleep(runif(1, 1, 2))  # random 1 number from 1 to 2
  topic=topic+length(title)
  print(paste("Total topic number:",topic))
}
}

df=data.frame(all_title,all_writter,all_count,all_link,all_time,all_group)
df$all_title=gsub("[[:blank:]]","",df$all_title)
df$all_writter=gsub("[[:blank:]]","",df$all_writter)
df$all_count=as.numeric(df$all_count)
#df$all_time=as.Date(df$all_time)
df$all_link=str_trim(df$all_link,side = c("both", "left", "right"))
df=df[order(-df$all_count),]
str(df)
head(df)
return(df)
}

R_douban()

R_douban("女朋友")


data001=R_douban("ebay",2,2)



for (i in (1:5)){
  browseURL(data001$all_link[i]) 
  Sys.sleep(runif(1, 1, 2))  # random 1 number from 1 to 2
}










top001=read_html(as.character(df$all_link[10]))
#top001=read_html("https://www.douban.com/group/topic/89313590/")
pic=top001%>%html_nodes("#link-report img")%>%html_attr("src")
pop_common=top001%>%html_nodes(".popular-bd p")%>%html_text()
pop_common

for (a in pic){
    download.file(a,paste(substr(a, nchar(a)-12, nchar(a)-3),'.jpg',sep=""), mode = 'wb')
}

getwd()

