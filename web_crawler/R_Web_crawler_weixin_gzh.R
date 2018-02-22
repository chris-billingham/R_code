

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

#Create JS method 1
connection="wx_gzh.js"
js_doc_full="var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'techstars.html'

page.open('https://mp.weixin.qq.com/profile?src=3&timestamp=1503743147&ver=1&signature=qu-LwAecFNHrhTh3IK64RvupYOW1SV*O6iTDgQPv5PhZuMefPhRZ5Sj1GORmZqnPucW0b5AXUgOI*u1eNz704w==', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});"

writeLines(sprintf(js_doc_full)
           ,con=connection)


#Create JS method 2
js_doc_1="var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'techstars.html'

page.open('"

js_doc_2="', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});"


sink("wx_gzh.js")
cat(js_doc_1,Account_url,js_doc_2, sep='')
sink()
###########################################################

thepage = readLines('http://mp.weixin.qq.com/profile?src=3&timestamp=1503844892&ver=1&signature=qu-LwAecFNHrhTh3IK64RvupYOW1SV*O6iTDgQPv5PhZuMefPhRZ5Sj1GORmZqnPFulmv4WAciFmik-Kwr04Gw==')


sink("thepage.html")
cat(thepage)
sink()
txt <- getURL('http://mp.weixin.qq.com/profile?src=3&timestamp=1503844892&ver=1&signature=qu-LwAecFNHrhTh3IK64RvupYOW1SV*O6iTDgQPv5PhZuMefPhRZ5Sj1GORmZqnPFulmv4WAciFmik-Kwr04Gw==')

sink("txt.txt")
cat(txt)
sink()
account_html=read_html("thepage.html")
#get html 
system("./phantomjs wx_gzh.js")

#read html
account_html=read_html("techstars.html")
# view html
xml_view(account_html)
#get account name
account_name=account_html%>%html_nodes(".profile_nickname")%>%html_text()
account_name

#get article name
account_article_name <- read_html("techstars.html")%>%html_nodes(".weui_media_title")%>%html_text
account_article_name

#get article link
account_article_link <- read_html("techstars.html")%>%html_nodes(".weui_media_title")%>%html_attr("hrefs")
account_article_link[1]

# make article full link
account_article_link002=paste("https://mp.weixin.qq.com",account_topic_link,sep='')
account_article_link002

#article link
article_url=account_article_link002[1]

#read article html
article_html=read_html(article_url)

#get article content
account_article_content <- article_html%>%html_nodes("#js_content p")%>%html_text
account_article_content






