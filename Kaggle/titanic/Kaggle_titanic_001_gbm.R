#https://www.kaggle.com/c/titanic

#https://www.r-bloggers.com/automating-basic-eda/  :packages("RtutoR")

#package
#install.packages("randomForest")
#install.packages("RtutoR")
#install.packages("gbm")
library(tidyverse)
library(gbm)
library(caret)
library(RtutoR)
#################    import data    ###################
getwd()
setwd('C:/Users/User/Desktop/Mission/R/R_code/Kaggle/titanic')

train=read.csv('train.csv')
test=read.csv('test.csv')

test$Survived <- NA;
test$Set  <- "Test";
train$Set <- "Train";
comb <- rbind(train, test);
test_index <- comb %>% filter(Set=="Test") %>% .$PassengerId # test PassengerId

comb$Survived <- factor(comb$Survived)


############  EDA #################

res = generate_exploratory_analysis_ppt(train,target_var = "Survived",
                                        output_file_name = "titanic_exp_report.pptx")


gen_exploratory_report_app(train)

############  clearing ############


fea <- comb
fea$Age[is.na(fea$Age)] <- -1
fea$Fare[is.na(fea$Fare)] <- median(fea$Fare, na.rm=TRUE)
fea$Embarked[fea$Embarked==""] = "S"
fea$Sex      <- as.factor(fea$Sex)
fea$Embarked <- as.factor(fea$Embarked)



extractFeatures <- function(data){
  
  features <- c("Pclass",
                "Age",
                "Sex",
                "Parch",
                "SibSp",
                "Fare",
                "Embarked",
                "Survived"
  )
  fea <- data[ , features]
  return(fea)
}


###################  train_a 80%  train_b 20%   test #################
train=fea%>%filter(Set=='Train')
test=fea%>%filter(Set=='Test')

set.seed(123)
trainIndex <- createDataPartition(train$PassengerId, p = .8,list = FALSE)

train_a=train[ trainIndex,]
train_b=train[-trainIndex,]

############  train_a GBM model #################
fitControl <- trainControl(method = 'repeatedcv',
                           number = 3,
                           repeats = 3)

newGrid <- expand.grid(n.trees = c(1000), 
                       interaction.depth = c(6),
                       shrinkage = 0.01,
                       n.minobsinnode = 10
)
train_a_gbm <- train(Survived ~., data=extractFeatures(train_a), 
                 method = 'gbm', 
                 trControl = fitControl,
                 tuneGrid =  newGrid,
                 bag.fraction = 0.5,
                 verbose = FALSE)
train_a_gbm$bestTune
train_a_gbm$results


############  train_a confusion matrix  ##########
pred_gbm <- predict(train_a_gbm, extractFeatures(train_a))
confusionMatrix(pred_gbm, train_a$Survived)
############  train_b confusion matrix  ##########
pred_gbm <- predict(train_a_gbm, extractFeatures(train_b))
confusionMatrix(pred_gbm, train_b$Survived)




############  train GBM model #################
fitControl <- trainControl(method = 'repeatedcv',
                           number = 3,
                           repeats = 3)

newGrid <- expand.grid(n.trees = c(1000), 
                       interaction.depth = c(6),
                       shrinkage = 0.01,
                       n.minobsinnode = 10
)
train_gbm <- train(Survived ~., data=extractFeatures(train), 
                     method = 'gbm', 
                     trControl = fitControl,
                     tuneGrid =  newGrid,
                     bag.fraction = 0.5,
                     verbose = FALSE)
train_gbm$bestTune
train_gbm$results



##########  predction ######################
submission <- data.frame(PassengerId = test$PassengerId)
submission$Survived <- predict(train_gbm, extractFeatures(test))
write.csv(submission, file = "1_GBM_r_submission.csv", row.names=FALSE)




