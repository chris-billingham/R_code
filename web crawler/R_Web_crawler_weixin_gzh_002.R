

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
library(xmlview)

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

Account_url='http://mp.weixin.qq.com/profile?src=3&timestamp=1503844892&ver=1&signature=qu-LwAecFNHrhTh3IK64RvupYOW1SV*O6iTDgQPv5PhZuMefPhRZ5Sj1GORmZqnPFulmv4WAciFmik-Kwr04Gw=='

account_html_source = readLines(Account_url)

sink("account_html_source.html")
cat(account_html_source)
sink()


#read html
account_html=read_html("account_html_source.html")
# view html
xml_view(account_html)
#get account name
account_name=account_html%>%html_nodes(".profile_nickname")%>%html_text()
account_name

#get article name
account_article_name <- read_html("techstars.html")%>%html_nodes(".weui_media_title")%>%html_text
account_article_name2=str_replace_all(account_article_name,pattern=" ", repl="")
account_article_name2=str_replace_all(account_article_name2,pattern="\n", repl="")
account_article_name2=paste('标题:',account_article_name2)
account_article_name2

#get article link
account_article_link <- read_html("techstars.html")%>%html_nodes(".weui_media_title")%>%html_attr("hrefs")
account_article_link[1]

# make article full link
account_article_link002=paste("https://mp.weixin.qq.com",account_article_link,sep='')
account_article_link002

article_num=length(account_article_link002)



###########  save it to vector #################
account_article_content_all=c()
for (x in account_article_name2){
  Sys.sleep(runif(1, 2, 3))  # random 1 number from 2 to 3
  print(x)
  account_article_content_all=append(account_article_content_all,x)
  for (y in account_article_link002){
    if (which(account_article_name2== x)==which(account_article_link002== y)){
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
sink("output2.txt")
for (x in account_article_name2){
  Sys.sleep(runif(1, 2, 4)) # random 1 number from 2 to 4
  cat(x)
  cat('\n')
  for (y in account_article_link002){
    if (which(account_article_name2== x)==which(account_article_link002== y)){
      article_html=read_html(y)
      account_article_content <- article_html%>%html_nodes("#js_content p")%>%html_text
      cat(account_article_content)
      cat('\n')
      cat('\n')
    }
  }
}
sink()

