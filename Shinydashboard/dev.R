
install.packages('RtutoR')
library(RtutoR)

univar_num_features_summary <- lapply(numeric_features, function(var_name) {
  val <- data.frame(t(Summarize(tt[[var_name]])))
  val[] = lapply(val, function(x) round(x,2))
  #colnames(val) <- c("min","25th","50th","75th","max")
  return(val)
  
})

environment(univar_num_features_summary) <- asNamespace('RtutoR')

fixInNamespace("univar_num_features_summary", pos = 3)
fixInNamespace("univar_num_features_summary", pos="package:RtutoR")

univar_num_features_summary() <- RtutoR:::univar_num_features_summary()

?assignInNamespace

remove.packages('RtutoR')

tt=read_xlsx("df.xlsx")
write_xlsx(tt, 'aa.xlsx')

names(tt)
a='mpg'
res = generate_exploratory_analysis_ppt(tt,target_var = a,
                                        output_file_name = "titanic_exp_report.pptx")


tt
a=as.vector(tt[2])
b=c(t(tt$am))

install.packages('FSA')
library(FSA)

Summarize(b)

?fivenum
data_type <- sapply(tt,class)

numeric_features <- names(data_type)[sapply(data_type,function(x) any(x %in% c("numeric","integer","double")))]
categorical_features <- names(data_type)[sapply(data_type,function(x) any(x %in% c("factor","character","logical")))]

univar_num_features_summary1 <- lapply(numeric_features, function(var_name) {
  val <- data.frame(t(fivenum(tt[[var_name]])))
  val[] = lapply(val, function(x) round(x,2))
  #colnames(val) <- c("min","25th","50th","75th","max")
  return(val)
  
})

glimpse(tt)

tt$drat=as.numeric(tt$drat)
tt$wt=as.numeric(tt$wt)
tt$qsec=as.numeric(tt$qsec)

univar_num_features_summary1
summary(tt[numeric_features])
categorical_features
table(tt[categorical_features])


univar_cat_features_summary <- lapply(categorical_features, function(var_name) {
  count <- table(tt[[var_name]])
  perct <- paste0(round(prop.table(count)*100,2),"%")
  val <- as.data.frame(rbind(count,perct))
  labels <- data.frame(Metric = c("Count","Perct."))
  val <- cbind(labels,val)
  return(val)
  
})
categorical_features
univar_cat_features_summary

univar_num_features_summary2 <- lapply(numeric_features, function(var_name) {
  val <- data.frame(t(Summarize(tt[[var_name]])))
  val[] = lapply(val, function(x) round(x,2))
  #colnames(val) <- c("min","25th","50th","75th","max")
  return(val)
  
})

univar_num_features_summary2


unzip("RtutoR-master.zip")
file.rename("RtutoR-master", "RtutoR")
shell("R CMD build RtutoR")
getwd()

setwd("C:/Users/User/Desktop/Mission/R/R_code/Shinydashboard")
install.packages("RtutoR_1.1.tar.gz", repos = NULL, type="source")



install.packages("gdtools")
library(RtutoR)
updateR()
version

library(RtutoR)
library(readxl)
library(dplyr)
tt=read_xlsx("ACCT_INFO.xlsx")
glimpse(tt)

tt=tt%>%select(input_slr_id,am_email,BUH,WinIT,AMH.y)

target_var_type <- data_type[which(names(tt) == target_var)]
data_type <- sapply(tt,class)
data_type

numeric_features <- names(data_type)[sapply(data_type,function(x) any(x %in% c("numeric","integer","double")))]
numeric_features
categorical_features <- names(data_type)[sapply(data_type,function(x) any(x %in% c("factor","character","logical")))]
categorical_features

res = generate_exploratory_analysis_ppt(tt,target_var = 'WinIT',
                                        output_file_name = "titanic_exp_report.pptx")


length(unique(tt$input_slr_id))

x <- c(3:5, 11:8, 8 + 0:5)
x
unique(x)

x[duplicated(x)]

head(tt[duplicated(tt$mpg),])

a=tt[duplicated(tt$mpg),]
a
tt%>%filter(mpg %in% a$mpg)%>%arrange(mpg)
nrow(a)

names(a)
           