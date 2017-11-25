#https://www.kaggle.com/c/house-prices-advanced-regression-techniques


getwd()


# package
library(dplyr)
library(ggplot2)
#library(devtools)
#install_github("ujjwalkarn/xda")
library(xda)
library(caret)


# data input
train001=read.csv('C:/Users/tduan/Desktop/Mission/R/R_code/Kaggle/House Prices/data/train.csv')
test001=read.csv('C:/Users/tduan/Desktop/Mission/R/R_code/Kaggle/House Prices/data/test.csv')


# EDA
dim(train001)
str(train001)
head(train001)
summary(train001)
glimpse(train001)
glimpse(test001)



numSummary(train001)
charSummary(train001)
Plot(train001,'SalePrice') 
#removeSpecial(mydata, vec)

########## The percentage of train data missing cells.
sum(is.na(train001)) / (nrow(train001) *ncol(train001))

############ The percentage of test data missing cells.
sum(is.na(test001)) / (nrow(test001) * ncol(test001))


doPlots(train_cont, fun = plotDen, ii = 7:12, ncol = 2)


# data cleaning

# partition
outcome <- train001$SalePrice

partition <- createDataPartition(y=outcome,p=0.8,list=F)
training <- train001[partition,]
testing <- train001[-partition,]

training002=training%>%select(SalePrice,YrSold,YearBuilt)

##A Linear Model
lm_model_15 <- lm(SalePrice ~ ., data=training002)
summary(lm_model_15)
##A Random Forest
##An xgboost



