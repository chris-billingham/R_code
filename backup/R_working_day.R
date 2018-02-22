

library(ggplot2)
library(dplyr)
library(reshape2)
library(dplyr)
library(sqldf)
library(scales)
library(zipcode)
data("zipcode")
library(maps)
library(mapdata)
library(rMaps)
library(XML)
library(sqldf)
library(plyr)
library(formattable)
library(xlsx) 
options(java.parameters = "-Xmx8G")
library(DBI)
library(RJDBC)
library(rJava)
library(ebaytd)
library(dplyr)

#install.packages("bizdays")
library(bizdays)

#devtools::install_github("janzzon/difftimeOffice")
library(difftimeOffice)


##############   Old connect #############################
#jdbc.drv<-JDBC("com.teradata.jdbc.TeraDriver", c("C:/JDBC/terajdbc4.jar", "C:/JDBC/tdgssconfig.jar"))
#jdbc.conn<-dbConnect(jdbc.drv, "jdbc:teradata://xxxxxxxx", "xxxxxxx", "xxxxxxxx") 

source('C:/Users/tduan/Desktop/File/pass.R')



test_check("difftimeOffice")

now <- as.POSIXct(Sys.time())

now2=now+60*60*24*7

now
now2


diff=difftime_office_hours(now, now2, working_hours = c(9, 18))
diff
diff/(60*60)


