#sqldf
#Data manipulation
#By 		G. Grothendieck
#https://cran.r-project.org/web/packages/sqldf/
#https://github.com/ggrothendieck/sqldf/

#monthly download:4,892 rank 96th
#https://www.rdocumentation.org/packages/sqldf/versions/0.4-11

install.packages('sqldf')
library(sqldf)


head(iris)
data001=sqldf("select * from iris limit 5")
data001

data002=sqldf("select * from iris limit 1")
data002

data003=sqldf("select a.* ,b.'Sepal.Length' as epal_Length_b
              from data001 a left join data002 b
              on a.Species=b.Species")

data003




