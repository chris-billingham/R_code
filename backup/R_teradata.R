
library(xlsx)
library(readxl)

library(DBI)
library(RJDBC)
library(rJava)

library(dplyr)
library(sqldf)
library(ggplot2)

################ ebay way connect #######################################################
source('C:/Users/tduan/Desktop/File/pass.R')

egd_whitelist001=read_xlsx("C:/Users/tduan/Desktop/Project/eGD/output/eDM list.xlsx")
dim(egd_whitelist001)
egd_whitelist002=as.data.frame(egd_whitelist001)


dbSendQuery(conn, " drop table P_bm_tony_t.egd_whitelist001")


teradataFastloadCSV(egd_whitelist002, conn, connf, "P_bm_tony_t", "egd_whitelist001", primary_index = c(1))

tt=dbGetQuery(conn, " select * from P_bm_tony_t.egd_whitelist001")

##################  upload ###############################################################

egd_whitelist003=dbGetQuery(conn, " select a.* ,b.EMAIL from P_bm_tony_t.egd_whitelist001 a left join PRS_SECURE_V.DW_USERS b  on a.SLR_ID=b.USER_ID")
dim(egd_whitelist003)
head(egd_whitelist003)
