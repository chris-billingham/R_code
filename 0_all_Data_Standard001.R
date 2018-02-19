
##########   Data Standard ########################


#   1 Package    
#   2 Data import
#   3 Data EDA & visualization
#   4 Data Cleaning
#   5 Data Modeling
#   6 Model Vaildation
#   7 Model scoring
#   8 Data output &presentation

###################################################

a=1
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
########    2 Data import        ##########

# https://www.kaggle.com/c/titanic/data

train001=read.csv('C:/Users/tduan/Desktop/Mission/R/data/train.csv')
head(train001)
train001=as.tbl(train001)
train001

test001=read.csv('C:/Users/tduan/Desktop/Mission/R/data/test.csv')
head(test001)
test001=as.tbl(test001)
test001

getwd()
cat("file A\n", file = "A")
cat("file B\n", file = "B")
cat("file C\n", file = "C")
file.append("A", rep("B", 10))

file.show("A")

unlink("C")
file.remove("A", "B")





########    3 Data EDA        ##########
train001
head(train001)
str(train001)
dim(train001)
summary(train001)
names(train001)
################### 3.1 ID ############################

length(unique(train001$PassengerId))

length(unique(train001$Name))

length(unique(train001$Ticket))


n_occur <- data.frame(table(train001$Ticket))
n_occur[n_occur$Freq > 1,]
qc001=train001[train001$Ticket %in% n_occur$Var1[n_occur$Freq > 1],]
qc001=qc001[order(qc001$Ticket),] 

n_occur <- data.frame(table(train001$Cabin))
n_occur[n_occur$Freq > 1,]
qc002=train001[train001$Cabin %in% n_occur$Var1[n_occur$Freq > 1],]
qc002=qc002[order(qc002$Cabin,decreasing = TRUE),] 



############## 3.2 categorical   ####################

table(train001$Pclass)
prop.table(table(train001$Pclass))

table(train001$Sex)
prop.table(table(train001$Sex))

table(train001$SibSp)
prop.table(table(train001$SibSp))

table(train001$Parch)
prop.table(table(train001$Parch))

table(train001$Cabin)
prop.table(table(train001$Cabin))

table(train001$Embarked)
prop.table(table(train001$Embarked))

table(train001$Survived)
prop.table(table(train001$Survived))
############## 3.3 numerical   ####################

summary(train001$Fare)
quantile(train001$Fare, c(0,0.01,0.1,0.50,0.75,0.9,0.99,1),na.rm = TRUE)

summary(train001$Age)
quantile(train001$Age, c(0,0.01,0.1,0.50,0.75,0.9,0.99,1),na.rm = TRUE)

ggplot(train001, aes(x = Embarked, y = Fare)) +
  geom_boxplot()

ggplot(train001, aes(x = Fare,fill=Embarked)) +
  geom_histogram()

ggplot(train001, aes(x = Fare)) +
  geom_histogram()+
  facet_wrap(~ Embarked)

tapply(train001$Fare, train001$Embarked, summary)

##############  3.4 multi  #################

########    4 Data Cleaning        ##########


table(complete.cases(train001))
qc003=train001[!complete.cases(train001),]
train002=train001[complete.cases(train001),]
train002$Survived=as.factor(train002$Survived)
#train002$Pclass=as.factor(train002$Pclass)

Embarked_ = factor(train002$Embarked)
Embarked_dummies = model.matrix(~Embarked_)

train003=cbind(train002,Embarked_dummies)
train003=mutate(train003,male=ifelse(Sex =='male', 1,0))

############  4.1 mulit ##############

ggplot(train003,aes(x=Survived))+
  geom_bar()+
  facet_wrap(~ Sex)

ggplot(train003,aes(x=Sex,fill = Survived))+
  geom_bar()


train003%>%
  filter(Pclass < 2.5) %>%
ggplot(aes(x=Survived))+
  geom_bar()+
facet_wrap(~ Sex)


########    5 Data Modeling        ##########

########   data spliting 80%  20%  ###########

trainning_001=train003[ createDataPartition(train003$Survived, p = 0.8, list = FALSE, times = 1),]
testing_001=train003[ -createDataPartition(train003$Survived, p = 0.8, list = FALSE, times = 1),]


################# 5.1 linear regression  #####################

linear_fit=lm(Fare  ~ Pclass + male + Age+SibSp+Parch+Embarked_C+Embarked_Q+Embarked_S, data = trainning_001)

linear_fit=lm(Fare  ~ Pclass+SibSp+Parch+Embarked_C, data = trainning_001)


linear_fit$coefficients
summary(linear_fit)

Fare_p=predict(linear_fit,testing_001)


plot(testing_001$Fare,Fare_p)
abline(1,1,col='red')

res <- testing_001$Fare - Fare_p
rmse <- sqrt(mean(res ^ 2))
ss_res <- sum(res ^ 2)
ss_tot <- sum((testing_001$Fare - mean(testing_001$Fare)) ^ 2)
r_sq <- 1 - ss_res / ss_tot
r_sq



################# 5.2 logistic regression  #####################


################# 5.3 decision tree  #####################
prop.table(table(trainning_001$Survived))

fit <- rpart(Survived ~ Pclass + Sex + Age+SibSp+Parch+Fare+Embarked,
             method="class", data=trainning_001, control = rpart.control(cp=0.00001))

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

# plot tree 
fancyRpartPlot(fit)

pruned <- prune(fit, cp = 0.01)
fancyRpartPlot(pruned)


########    6 Model Vaildation        ##########

pred<- predict(fit, testing_001, type = "class")
conf_g <- table(testing_001$Survived, pred)
conf_g
acc_g <- sum(diag(conf_g)) / sum(conf_g)
acc_g


########    7 Model scoring   ##########
Prediction <- predict(fit, test001, type = "class")
########    8 Data output        ##########
submit <- data.frame(PassengerId = test001$PassengerId, Survived = Prediction)
write.csv(submit, file = "C:/Users/tduan/Desktop/Mission/R/output/myfirstdtree.csv", row.names = FALSE)
