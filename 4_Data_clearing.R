
##########   Data Standard ########################


#   1 Package    
#   2 Data import
#   3 Data EDA
#   4 Data Cleaning
#   5 Data Modeling
#   6 Model Vaildation
#   7 Model scoring
#   8 Data output

###################################################


########    1 Package        ##########

Sys.setenv(LANG = "en")
#install.packages('ggplot2')
#install.packages('dplyr')
#install.packages('rattle')
#install.packages('rpart.plot')
#install.packages('RColorBrewer')
#install.packages('caret')
library(ggplot2)
library(dplyr)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(caret)
library(datasets)

################################################
data001=read.csv('C:/Users/tduan/Desktop/Mission/R/data/train.csv')
head(data001)

glimpse(data001)

data002=data001%>%summarise(count=n(),PassengerId_mun=n_distinct(PassengerId))
data002


data003=data001%>%group_by(Sex)%>%summarise(
          count=n(),PassengerId_mun=n_distinct(PassengerId),Survived=sum(Survived),
          total_Fare=sum(Fare),avg_Fare=mean(Fare),mid_Fare=median(Fare),
          Fare_25=quantile(Fare, probs=0.25))
data003       



data004=data001%>%left_join(select(data003,Sex,avg_Fare),by=c("Sex"="Sex"))
glimpse(data004)









