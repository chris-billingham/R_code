#https://www.kaggle.com/c/titanic

#package
#install.packages("randomForest")

library(tidyverse)
library(randomForest)
library(caret)

#################    import data    ###################
getwd()

train=read.csv('train.csv')
test=read.csv('test.csv')

test$Survived <- NA;
test$Set  <- "Test";
train$Set <- "Train";
comb <- rbind(train, test);
test_index <- comb %>% filter(Set=="Test") %>% .$PassengerId # test PassengerId

comb$Survived <- factor(comb$Survived)


############  EDA #################
############  clearing ############


fea <- comb
fea$Age[is.na(fea$Age)] <- -1
fea$Fare[is.na(fea$Fare)] <- median(fea$Fare, na.rm=TRUE)
fea$Embarked[fea$Embarked==""] = "S"
fea$Sex      <- as.factor(fea$Sex)
fea$Embarked <- as.factor(fea$Embarked)


features <- c("Pclass",
              "Age",
              "Sex",
              "Parch",
              "SibSp",
              "Fare",
              "Embarked"
              )


train=fea%>%filter(Set=='Train')
test=fea%>%filter(Set=='Test')
############  model #################

rf <- randomForest(train[,features], as.factor(train$Survived), ntree=100, importance=TRUE)
########  feature chart 
imp <- importance(rf, type=1)
featureImportance <- data.frame(Feature=row.names(imp), Importance=imp[,1])

p <- ggplot(featureImportance, aes(x=reorder(Feature, Importance), y=Importance)) +
  geom_bar(stat="identity", fill="#53cfff") +
  coord_flip() + 
  theme_light(base_size=20) +
  xlab("") +
  ylab("Importance") + 
  ggtitle("Random Forest Feature Importance\n") +
  theme(plot.title=element_text(size=18))

ggsave("2_feature_importance.png", p)
##########  predction ######################
submission <- data.frame(PassengerId = test$PassengerId)
submission$Survived <- predict(rf, test[,features])
write.csv(submission, file = "1_random_forest_r_submission.csv", row.names=FALSE)




