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
# "Data Wrangling & Feature Engineering with dplyr" located at the following URL:
#     https://youtu.be/NXVSh6gxoJc     
#



#======================================================================
# Load libraries and take a look at the help files
#
library(dplyr)
library(stringr)

help(package = "dplyr")
help(package = "stringr")



#======================================================================
# Load the data and take a first look
#
train <- read.csv("titanic_train.csv", stringsAsFactors = FALSE)
str(train)

View(train)



#======================================================================
# What about those zero fares?
#
zero.fare <- train %>%
  filter(Fare == 0.0)
View(zero.fare)

# Let's get the totals by Pclass
zero.fare.pclass <- zero.fare %>%
  group_by(Pclass) %>%
  summarize(Total = n()) %>%
  arrange(desc(Total))
zero.fare.pclass

