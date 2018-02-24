
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



univar_num_features_summary <- lapply(numeric_features, function(var_name) {
  val <- data.frame(t(Summarize(tt[[var_name]])))
  val[] = lapply(val, function(x) round(x,2))
  #colnames(val) <- c("min","25th","50th","75th","max")
  return(val)
  
})

univar_num_features_summary


unzip("RtutoR-master.zip")
file.rename("RtutoR-master", "RtutoR")
shell("R CMD build RtutoR")
getwd()

setwd("C:/Users/User/Desktop/Mission/R/R_code/Shinydashboard")
install.packages("RtutoR_1.1.tar.gz", repos = NULL, type="source")



install.packages("installr")
library(RtutoR)
updateR()
version
