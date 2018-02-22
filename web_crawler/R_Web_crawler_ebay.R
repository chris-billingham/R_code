#install.packages("rvest")
#install.packages("jpeg")
#install.packages("installr")
#install.packages("httr")
#Sys.setlocale("LC_ALL","Chinese")
#library(installr)
#updateR()
#install.packages("xml2")
#install.packages("xlsx")
library(xml2)
library(xlsx)
library(rvest)
library(jpeg)
library(httr)
library(stringr)

#################    ebay  ###################################

pages=c(1:2)
################# page   ################
url_all=NULL
for (i in pages){
  #print(i)
  url=paste("http://www.ebay.com/sch/i.html?_from=R40&_sacat=0&_nkw=spinner&_pgn=",i,"&_skc=350&rt=nc",sep="")
  url_all=c(url_all,url)
}

url_all


#############  contents  ##################################
title_css=".vip"
price_css=".prc .bold"
location_css="#ListViewInner .full-width , #item544387e84c li"
title_all=NULL
price_all=NULL
#location_all=NULL
#link_all=NULL
for (i in url_all){
  #print(i)
  html=read_html(i)
  title=html%>%html_nodes(title_css)%>%html_text()
  link=html%>%html_nodes(title_css)%>%html_attr("href")
  price=html%>%html_nodes(price_css)%>%html_text()
  print(title)
  print(link)
  title_all=c(title_all,title)
  #link_all=c(link_all,link)
  price_all=c(price_all,price)
  #location_all=c(location_all,location)
}



title_all
title_all002=str_replace_all(title_all, "\n", "")
title_all002=str_replace_all(title_all002, "\r", "")
title_all002=str_replace_all(title_all002, "\t", "")
title_all002



price_all

price_all002=str_replace_all(price_all, "\n", "")
price_all002=str_replace_all(price_all002, "\r", "")
price_all002=str_replace_all(price_all002, "\t", "")
price_all002

all001=cbind(title_all002,price_all002)

head(all001)
dim(all001)

write.csv(all001, "C:/Users/User/Desktop/Mission/R/output/ebay001.csv")
