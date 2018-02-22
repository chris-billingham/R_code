

###########  install and load package ###################
#install.packages('ggvis')
#install.packages('knitr')
#devtools::install_github("hrbrmstr/xmlview")

library(RCurl)
library(rvest)
library(stringr)
library(plyr)
library(dplyr)
library(ggvis)
library(knitr)
library(xml2)
#library(xmlview)

Sys.getlocale("LC_TIME")
Sys.setlocale("LC_ALL","chs")
###########  Using R to scrape WX article  ###############

#R web crawler
#http://www.ituring.com.cn/article/465317
#https://www.youtube.com/watch?v=jyqnbUNEO00

#R web crawler:WX article
#https://www.datacamp.com/community/tutorials/scraping-javascript-generated-data-with-r#gs.SK2T38I
#https://www.youtube.com/watch?v=GayFRUUtHj4



###########  Using Python to scrape WX article  ###############
#Python web crawler
#https://www.youtube.com/watch?v=XQgXKtPSzUI

#Python web crawler:WX article
#http://blog.csdn.net/qiqiyingse/article/details/70050113




###################    weixin GZH   v1        #####################################

getwd()
setwd('C:/Users/tduan/Desktop/Mission/R/R_code/web crawler')

setwd('C:/Users/User/Desktop/Mission/R/R_code/web crawler')

topic='ebay'

url=paste('http://weixin.sogou.com/weixin?type=2&s_from=input&query=',topic,'&ie=utf8&_sug_=n&_sug_type_=',sep='')
url

# Get first 2 page topic and topic link 
article_name_all=c()
article_link_all=c()
for (i in seq(2)){
  print(i)
  url=paste('http://weixin.sogou.com/weixin?query=',topic,'&_sug_type_=&s_from=input&_sug_=n&type=2&page=',i,'&ie=utf8',sep='')
  print(url)
  article_url=read_html(url)
  article_name=article_url%>%html_nodes("h3 a")%>%html_text()
  article_name_all=append(article_name_all,article_name)
  article_link=article_url%>%html_nodes("h3 a")%>%html_attr("href")
  article_link_all=append(article_link_all,article_link)
  Sys.sleep(runif(1, 2, 3))  # random 1 number from 2 to 3
}

article_name_all
article_link_all


###########  save it to vector #################
account_article_content_all=c()
for (x in article_name_all){
  Sys.sleep(runif(1, 2, 3))  # random 1 number from 2 to 3
  print(x)
  print(which(article_name_all== x))
  account_article_content_all=append(account_article_content_all,x)
  for (y in article_link_all){
    if (which(article_name_all== x)==which(article_link_all== y)){
    print(y)
    article_html=read_html(y)
    account_article_content <- article_html%>%html_nodes("#js_content p")%>%html_text
    account_article_content_all=append(account_article_content_all,account_article_content)
    }
  }
}

account_article_content_all

account_article_content_all2=account_article_content_all[account_article_content_all != ""]
account_article_content_all2


########  ouput to txt  ##################
sink("output3.txt")
for (x in article_name_all){
  Sys.sleep(runif(1, 2, 3)) # random 1 number from 2 to 3
  cat(x)
  cat('\n')
  for (y in article_link_all){
    if (which(article_name_all== x)==which(article_link_all== y)){
      article_html=read_html(y)
      account_article_content <- article_html%>%html_nodes("#js_content p")%>%html_text
      cat(account_article_content)
      cat('\n')
      cat('\n')
    }
  }
}
sink()

