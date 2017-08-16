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
library(stringr)


#################    r-users  ###################################
R_job=read_html("https://www.r-users.com/jobs/page/3/")

pages=c(1:3)

urls=rbindlist(lapply(pages,function(x){
  url=paste("https://www.r-users.com/jobs/page/",x,"/",sep="")
  data.frame(url)
}),fill=TRUE)


################# page   ################
url_all=NULL
for (i in pages){
#print(i)
url=paste("https://www.r-users.com/jobs/page/",i,"/",sep="")
url_all=c(url_all,url)
}

url_all

#############  contents  ##################################
title_css=".job-expired:nth-child(6) strong+ a , strong a"
location_css=".location strong"
title_all=NULL
location_all=NULL
for (i in url_all){
  #print(i)
  html=read_html(i)
  title=html%>%html_nodes(title_css)%>%html_text()
  location=html%>%html_nodes(location_css)%>%html_text()
  #print(title)
  title_all=c(title_all,title)
  location_all=c(location_all,location)
}

title_all
location_all

