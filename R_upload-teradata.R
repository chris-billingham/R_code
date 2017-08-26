

library(mailR)
library(xlsx)
library(readxl)

library(DBI)
library(RJDBC)
library(rJava)

library(dplyr)
library(sqldf)
library(ebaytd)


################ ebay way connect ####################
source('C:/Users/tduan/Desktop/File/pass.R')

data001=read_excel("C:/Users/tduan/Desktop/Project/eGD/output/Tracking/eGD_tracking.xlsx")

glimpse(data001)
data002=data001[,1]

teradataFastloadCSV(data002, conn, connf, "P_bm_tony_t", "egd_list001", replace = TRUE, primary_index = c(1))















