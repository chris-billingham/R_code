#
# Copyright 2017 Dave Langer
#    
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 


#
# This R source code file corresponds to video 6 of the YouTube series
# "R Programming for Excel Users" located at the following URL:
#      https://youtu.be/Wam5xSsGVn8     
#


# Load the data and take a look at the structure
# NOTE - Be sure to set your working directory!
titanic_train <- read.csv("C:/Users/User/Desktop/Mission/R/data/titanic_train.csv")
str(titanic_train)


# Subset the data for the Age variable (i.e., the 6th column)
titanic_train[7, 6]
titanic_train[1:10, 6]


# Subset the data for the Age, SibSp, and Parch variables 
# (i.e., the 6th, 7th, and 8th columns)
titanic_train[2:25, 6:8]


# Perform vector-based summation first 10 Age values
sum(titanic_train[1:10, 6], na.rm = TRUE)


# Perform vector-based summation on all Age values,
# the second parameter is required to ignore missing values!
sum(titanic_train$Age, na.rm = TRUE)


# Add a new column for the size of the family using a 
# vectorized calculation
titanic_train$FamilySize <- 1 + titanic_train$SibSp + titanic_train$Parch
View(titanic_train)


# Add a new column to the data frame
titanic_train$AgeMissing <- ""
View(titanic_train)


# Update the new column to reflect reality
titanic_train$AgeMissing <- ifelse(is.na(titanic_train$Age),
                                   "Y",
                                   "N")
View(titanic_train)


# Start investigating the nature of the Age column
summary(titanic_train$Age)


# More summary statistics for Age column
sd(titanic_train$Age, na.rm = TRUE)
median(titanic_train$Age, na.rm = TRUE)
var(titanic_train$Age, na.rm = TRUE)
sum(titanic_train$Age, na.rm = TRUE)
length(titanic_train$Age)
AgeTemp <- titanic_train$Age[!is.na(titanic_train$Age)]
length(AgeTemp)


# Slice Age data by Gender
FemaleAge <- titanic_train$Age[titanic_train$Sex == "female"]
summary(FemaleAge)
sd(FemaleAge, na.rm = TRUE)


MaleAge <- titanic_train$Age[titanic_train$Sex == "male"]
summary(MaleAge)
sd(MaleAge, na.rm = TRUE)


# Slice entire data frame by Sex
female_train <- titanic_train[titanic_train$Sex == "female",]
View(female_train)

male_train <- titanic_train[titanic_train$Sex == "male",]
View(male_train)


# Further slice data frame by Pclass of 1
female_1st_train <- female_train[female_train$Pclass == 1,]
View(female_1st_train)
summary(female_1st_train$Age)

male_1st_train <- male_train[male_train$Pclass == 1,]
View(male_1st_train)
summary(male_1st_train$Age)


# Can combine in a single step
female_1st_train <- titanic_train[(titanic_train$Sex == "female" & titanic_train$Pclass == 1),]
male_1st_train <- titanic_train[titanic_train$Sex == "male" &
                                titanic_train$Pclass == 1,]


# Subset to only the columns I'm interested in by column position
names(titanic_train)
my_subset_1 <- titanic_train[, c(2, 3, 5, 6, 7, 8, 10, 13, 14)]
View(my_subset_1)


# The following code is equivalent to the my_subset_1 code
my_subset_2 <- titanic_train[, c(2:3, 5:8, 10, 13:14)]
View(my_subset_2)


# I can also filter rows and columns by position
my_rows <- c(1:50, 67, 69, 84, 100:891)
my_features <- c(2:3, 5:8, 10, 13:14)
my_subset_3 <- titanic_train[my_rows, my_features]
View(my_subset_3)


# Subset to only the columns I'm interested in by column name
my_features <- c("Survived", "Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "FamilySize", "AgeMissing")
my_subset_4 <- titanic_train[, my_features]
View(my_subset_4)


# The following code is equivalent to the my_subset_4 code
my_features <- names(titanic_train)
my_features <- my_features[-c(1, 4, 9, 11, 12)]
my_features
my_subset_5 <- titanic_train[, my_features]
View(my_subset_5)


# Subset to only the columns I'm interested in
my_rows <- c(51:66, 68, 70:83, 85:99)
my_features <- names(titanic_train)[-c(1, 4, 9, 11, 12)]
my_features
my_subset_6 <- titanic_train[-my_rows, my_features]
View(my_subset_6)

