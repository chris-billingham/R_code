

###########  install and load package ###################
#install.packages('ggvis')
#install.packages('knitr')
#devtools::install_github("hrbrmstr/xmlview")


install.packages('XML')

library(RCurl)
library(rvest)
library(stringr)
library(plyr)
library(dplyr)
library(ggvis)
library(knitr)
library(xml2)
library(XML)

#library(xmlview)



##################    We work   v1        #####################################

getwd()
setwd('C:/Users/tduan/Desktop/Mission/R/R_code/web crawler')

location_url='https://www.wework.com/locations'

location_html=readLines(location_url)

sink("location_html.html")
cat(location_html)
sink()

location_html_r=read_html("location_html.html")

location_names=location_html_r%>%html_nodes('li.marketListItem__countryList__2KKre a')%>%html_text()
location_names2=location_names[1:(length(location_names)/2)]

location_names2

location_url=location_html_r%>%html_nodes('li.marketListItem__countryList__2KKre a')%>%html_attr("href")
location_url2=location_url[1:(length(location_url)/2)]

location_url3=paste('https://www.wework.com',location_url2,sep='')
location_url3

location_url3[1]

office_html_r=read_html(location_url3[1])


office_names=office_html_r%>%html_nodes('.titleContainer__buildingCard__jJ9-z h3')%>%html_text()
office_names

office_price=office_html_r%>%html_nodes('.sm10 span')%>%html_text()
office_price

office_address=office_html_r%>%html_nodes('.titleContainer__buildingCard__jJ9-z div')%>%html_text()
office_address

office_desc=office_html_r%>%html_nodes('div.descriptionCard__geogrouping__FnElF p')%>%html_text()
office_desc



for (i in location_url3){
    print(i)
    office_names=read_html(i)%>%html_nodes('.title__buildingCard__1AK3U')%>%html_text()
    print(office_names)
}





