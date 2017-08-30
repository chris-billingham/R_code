#install.packages("XLConnect")
#############################    XLSX #################################

#read.csv
#read.delim
#read.table
#read_csv
#read_tsv
#read_delim
#install.packages('xlsx')
#install.packages("readxl")
#install.packages("devtools")
#install_github("geoffjentry/twitteR")
#install.packages("twitteR")
#install.packages("RCurl")
#install.packages("base64enc")
#library(devtools)
#install.packages("twitteR")
#install.packages("base64enc")
#install.packages("httr")
#install.packages("ROAuth")
#install.packages("googleVis")

#install.packages("jsonlite")

#install.packages("zip")
library(jsonlite)
#install.packages("httpuv")
library(httpuv)
#install.packages("httr")
install.packages("fun")
library(httr)
library(base64enc)
library(twitteR)
library(ROAuth)
library(httr)
library(RCurl)
library(xlsx)
library(readxl)
library(dplyr)
library(fun)
#options(httr_oauth_cache=T)

library(googleVis)
library(zip)

shell("notepad") 

system("./Notepad++ wx_gzh.js")

getwd()



########  audio
install.packages('audio')
library(audio)
bday_file <- tempfile()
download.file("http://www.happybirthdaymusic.info/01_happy%20birthday%20song.wav", bday_file, mode = "wb")
bday <- load.wave(bday_file)
play(bday)
#install.packages('tuneR')
library(tuneR)

File1<- readMP3("Becoming_A_Legend.mp3")
play(File1)




# image
install.packages('png')
library(png)
#read file
img<-readPNG("R_logo.png")

#get size
dim(img)[1]
dim(img)[2]
dim(img)




excel_sheets("C:/Users/User/Desktop/Mission/R/data/xlsx001.xlsx")
excel001=read_excel("C:/Users/User/Desktop/Mission/R/data/xlsx001.xlsx")

excel001=read_excel("C:/Users/tduan/Desktop/Mission/R/data/data001.xlsx")

excel001
excel002=read_excel("C:/Users/User/Desktop/Mission/R/data/xlsx001.xlsx",sheet="table002")

excel003=read_excel("C:/Users/User/Desktop/Mission/R/data/xlsx001.xlsx",sheet="table001",skip=1)
excel003

excel004=read_excel("C:/Users/User/Desktop/Mission/R/data/xlsx001.xlsx",sheet="table001",n_max=3)
excel004


excel005=read.xlsx("C:/Users/User/Desktop/Mission/R/data/xlsx001.xlsx",sheetName="table001")
excel005



##################################     XLConnect   ####################################

#install.packages("XLConnect")




library(XLConnect)


book=loadWorkbook("C:/Users/tduan/Desktop/Mission/R/data/data001.xlsx")

getSheets(book)

data001=readWorksheet(book,sheet="Sheet1")
data001

data002=readWorksheet(book,sheet="Sheet1",startRow=3,endRow =4 ,startCol =1 ,endCol =2 ,header=FALSE)
data002


createSheet(book,name="new_sheet")
writeWorksheet(book,data002,sheet ="new_sheet")


saveWorkbook(book,file="C:/Users/tduan/Desktop/Mission/R/data/data002.xlsx")

data003=readWorksheet(book,sheet="new_sheet")
data003

renameSheet(book,"new_sheet","new_sheet_v2")


saveWorkbook(book,file="C:/Users/tduan/Desktop/Mission/R/data/data002.xlsx")


removeSheet(book,sheet="new_sheet_v2")
saveWorkbook(book,file="C:/Users/tduan/Desktop/Mission/R/data/data002.xlsx")



##############################   DATA base  ############################
# Connect to the MYSQL 
library(devtools)
library(DBI)
library(RMySQL)
library(RJDBC)


con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")

# Create data frame short
short=dbGetQuery(con,"select  id,name from users where length(name) <5 ")

# Print short
short

dbDisconnect(con)

# Connect to the TERADATA

library(teradataR)
library(ebaytd)

teradataInit("tduan", "xxxxxxxxxx")

access_con <- teradataConnect(system = "mozart") 

tony_con <- teradataConnect(system = "mozart",database='P_bm_tony_t') 
tony_con_fast <- teradataConnect(system = "mozart",database='P_bm_tony_t',fast=TRUE) 


dbExistsTable(tony_con,"P_bm_tony_t","test")

dbExistsRemove(conn,"P_bm_tony_t","test")


df1 <- data.frame(x=seq(1,10),y=seq(11,20))

teradataFastloadCSV(df1, tony_con, tony_con_fast, "P_bm_tony_t", "test123", replace = TRUE, primary_index = c(1))

df2 <- dbGetQuery(tony_con,'select * from P_bm_tony_t.test')
print(df2)


####################   dplyr  data base ##########################################
library(dplyr)
library(RMySQL)

my_db <- src_mysql(dbname = "dplyr", 
                   host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                   port = 3306, 
                   user = "student",
                   password = "datacamp")

# Reference a table within that source: nycflights
nycflights <- tbl(my_db, "dplyr")

# glimpse at nycflights
glimpse(nycflights)
dim(nycflights)

head(nycflights)

# Ordered, grouped summary of nycflights
nycflights%>%
  group_by(carrier)%>%
  summarise(n_flights=n(),
            avg_delay=mean(arr_delay))%>%
  arrange(avg_delay)          


##########################  HTTP ###########################################


# Load the readxl and gdata package
library(readxl)
library(gdata)

# Specification of url: url_xls
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

# Import the .xls file with gdata: excel_gdata
excel_gdata= read.xls(url_xls)

# Download file behind URL, name it local_latitude.xls
download.file(url_xls,"local_latitude.xls")

# Import the local .xls file with readxl: excel_readxl
excel_readxl= read_excel("local_latitude.xls")

#############################  read SAS #######################
#install.packages("haven")
library(haven)
library(dplyr)
data001=read_sas("C:/Users/tduan/Desktop/data_account002_v2.sas7bdat")



data002=data001%>%filter(USER_SLCTD_ID=='goodworkhardn')


data001_v2=read_sas("C:/Users/tduan/Desktop/data_account002.sas7bdat")





########################   API  &  Json ###########################
#   Json
# Load the  package
library(jsonlite)

# wine_json is a JSON
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'

# Convert wine_json into a list: wine
wine=fromJSON(wine_json)

# Print structure of wine
str(wine)
wine

##################### Star War API   #################


library(httr)
library(jsonlite)

# https://swapi.co/
# Goal: Get the data for the planet Alderaan
# verb (method) = GET
# URL (endpoint) = http://swapi.co/api/planets/
# parameter = search

alderaan <- GET("http://swapi.co/api/planets/?search=alderaan")


alderaan$status_code
alderaan$headers$`content-type`
names(alderaan)

# Get the content of the response
text_content <- content(alderaan, as = "text", encoding = "UTF-8")
text_content

# Parse with httr
parsed_content <- content(alderaan, as = "parsed")
names(parsed_content)
parsed_content$count
str(parsed_content$results)
parsed_content$results[[1]]$name
parsed_content$results[[1]]$terrain

# Parse with jsonlite
json_content <- text_content %>% fromJSON
json_content
planetary_data <- json_content$results
names(planetary_data)
planetary_data$name
planetary_data$terrain

# -------------------------------

# Helper function
json_parse <- function(req) {
  text <- content(req, as = "text", encoding = "UTF-8")
  if (identical(text, "")) warn("No output to parse.")
  fromJSON(text)
}

# List results
planets <- GET("http://swapi.co/api/planets") %>% stop_for_status()
json_planets <- json_parse(planets)

# The response includes metadata as well as results
names(json_planets)
json_planets$count
length(json_planets$results$name)
json_planets$`next`

swapi_planets <- json_planets$results
swapi_planets$name

# Get the next page of results based on the content of the `next` field
next_page <- GET(json_planets$`next`) %>% stop_for_status()

# Use a function to parse the results
parsed_next_page <- json_parse(next_page)
parsed_next_page$results$name

# If the API results come back paged like this, you can write a loop to follow the next URL 
# until the there are no more pages, and rbind all the data into a single dataframe.

# Grab data on all of the Star Wars planets
planets <- GET("http://swapi.co/api/planets") %>% 
  stop_for_status() %>% 
  json_parse
swapi_planets <- planets$results

next_page <- planets$`next`
while(!is.null(next_page)) {
  more_planets <- GET(next_page) %>% 
    stop_for_status() %>% 
    json_parse
  swapi_planets <- rbind(swapi_planets, more_planets$results)
  next_page <- more_planets$`next`
}

length(swapi_planets$name)
swapi_planets$name

# In real life, you'd also want to handle any errors, headers, proxy, rate limits, etc. as needed.
help(package=httr)




##################### Douban movie  API   #################
library(RCurl)
library(XML)
library(RJSONIO)
movieScoreapi <- function(x) {
  api <- "https://api.douban.com/v2/movie/search?q={"
  url <- paste(api, x, "}", sep = "")
  res <- getURL(url)
  reslist <- fromJSON(res)
  name <- reslist$subjects[[1]]$title
  score <- reslist$subjects[[1]]$rating$average
  return(list(name = name, score = score))
}
movieScoreapi("僵尸世界大战")



##############  twitter API   ################
# https://apps.twitter.com/app/14115179/keys

consumer_key='EQr5kHd5JhQrsOvAk7x5Ak2LU'
consumer_secret='LisjBswI88wuW0OV6LUkIJZkEOYKm7vSzqsJQWMQfXc3eKXwIy'
access_token='790128816647614464-Pu6fOFne0TbgEgxPpZdu7xXAW9tBhed'
access_secret='6dJI4x5xUY47AmIj6ueMNd77Sew7fYYZBG9MnVxZ9eUkQ'
setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)
setup_twitter_oauth(consumer_key,consumer_secret,access_token=NULL, access_secret=NULL)
setup_twitter_oauth(consumer_key,consumer_secret)


##############  Github API   ################
# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on what you 
myapp <- oauth_app(appname = "JC_fly",
                   key = "74b478df4a6f096416ad",
                   secret = "42f952218b41801b2b837f6f7eb01e2b01c32db2")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)

#account jcflyingco    ########
req <- GET("https://api.github.com/users/jcflyingco/repos", gtoken)
# Take action on http error
stop_for_status(req)
# Extract content from a request
json1 = content(req)
# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

glimpse(gitDF)


##  account jcflyingco v2   ###
json_data=fromJSON("https://api.github.com/users/jcflyingco/repos")
glimpse(json_data)
######################    account hadley    ################3
json_data=fromJSON("https://api.github.com/users/hadley/repos?page=1&per_page=100")
glimpse(json_data)
###############    Google VIS API ##############

