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
# This R source code file corresponds to video 2 of the YouTube series
# "R Programming for Excel Users" located at the following URL:
#      https://youtu.be/VOZ9zmgSduc     
#


# Load the data and take a look at the structure
# NOTE - Be sure to set your working directory!
titanic_train <- read.csv("C:/Users/User/Desktop/Mission/R/data/titanic_train.csv")

str(titanic_train)
head(titanic_train)

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


