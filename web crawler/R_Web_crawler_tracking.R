#install.packages("rvest")
#install.packages("jpeg")
#install.packages("installr")
#install.packages("httr")
#Sys.setlocale("LC_ALL","Chinese")
#library(installr)
#updateR()
#install.packages("xml2")
#install.packages("xlsx")
#install.packages("curl")
library(xml2)
library(xlsx)
library(rvest)
library(jpeg)
library(httr)
library(stringr)
library(sqldf)
library(curl)


#1ZE356F80309406728
#9274899993700903986070
#9374889672090173183119
#1ZE356F8YW35850398
#9200190181411266143210
#9374889681090190992860
#9374889681090190992860





########################   UPSP ##############################################


data001=read.csv("C:/Users/tduan/Desktop/ilm_qc001.csv",stringsAsFactors = FALSE)
names(data001)
data001
data002=data001

data003=data001$FRST_TRKING_NR_TXT




#USPS001=subset(data001,CARRIER_NAME=='USPS')

#USPS002=USPS001$FRST_TRKING_NR_TXT
################# page   ################
url_all=NULL
for (i in data003){
  #print(i)
  url=paste("https://tools.usps.com/go/TrackConfirmAction?qtc_tLabels1=",i,sep="")
  url_all=c(url_all,url)
}

url_all


#############  contents  ##################################
status_css=".status-green"
number_css=".tracking-number"
ship_css=".callout"
status_all=NULL
number_all=NULL
ship_all=NULL
for (i in url_all){
  a=runif(1, 2, 5)
  print(a)
  Sys.sleep(a)  # random 1 number from 1 to 3
  #print(i)
  download.file(i, destfile = "scrapedpage.html", quiet=TRUE)
  html=read_html("scrapedpage.html")
  status=html%>%html_nodes(status_css)%>%html_text()
  number=html%>%html_nodes(number_css)%>%html_text()
  ship=html%>%html_nodes(ship_css)%>%html_text()
  if (length(status)==0){status='empty'} 
  if (length(number)==0){number='empty'} 
  if (length(ship)==0){ship='empty'} 
  ans=paste(number,status)
  print(ans)
  status_all=append(status_all,status)
  number_all=append(number_all,number)
  ship_all=append(ship_all,ship)
}


ship_all
ship_all002=str_replace_all(ship_all, "\n", "")
ship_all002=str_replace_all(ship_all002, "\r", "")
ship_all002=str_replace_all(ship_all002, "\t", "")
ship_all002
status_all
number_all=str_replace_all(number_all, " ", "")



output001=cbind(status_all,number_all,ship_all002)
output001
output001=data.frame(output001)
output001$number_all=as.character(output001$number_all)
output001




output002=sqldf('select a.*, b.* from data002 a left join output001 b on a.FRST_TRKING_NR_TXT=b.number_all')
output002

output002$FRST_TRKING_NR_TXT=as.character(output002$FRST_TRKING_NR_TXT)
output002$ITEM_ID=as.character(output002$ITEM_ID)
output002$TRANS_ID=as.character(output002$TRANS_ID)
output001$number_all


########################   UPS ##############################################
#https://wwwapps.ups.com/WebTracking/processPOD?Requester=&tracknum=

#https://wwwapps.ups.com/WebTracking/track?track=yes&trackNums=


#dd:nth-child(2)

write.csv(output002, "C:/Users/tduan/Desktop/Mission/R/code/R_code/ebay001.csv")
write.xlsx(output002, "C:/Users/tduan/Desktop/Mission/R/code/R_code/ebay001.xlsx")



