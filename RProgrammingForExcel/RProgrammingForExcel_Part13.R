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
# This R source code file corresponds to video 13 of the YouTube series
# "R Programming for Excel Users" located at the following URL:
#      https://youtu.be/OQLV-79GUJY     
#


# Load the data and take a look at the structure
# NOTE - Be sure to set your working directory!
titanic_train <- read.csv("C:/Users/User/Desktop/Mission/R/data/titanic_train.csv"
                          ,stringsAsFactors = FALSE)



str(titanic_train)



# Use the mighty stringr package.
#install.packages("stringr")
library(stringr)


# Look at the help for the stringr package.
help(package = "stringr")


# Look at the passenger name feature.
titanic_train$Name[1:10]


# Split the first name on the comma to understand what's
# going to happen.
braund <- str_split(titanic_train$Name[1], ",")
str(braund)
braund[1]
braund[[1]]

# Split all the names on the comma.
surnames <- str_split(titanic_train$Name, ",")
str(surnames)
surnames[1]
surnames[[1]]

# OK, what we need to do is go through each element in 
# the list and filter the character vector of each 
# element to get the first string.
titanic_train$Surname <- lapply(surnames, "[", 1) 
View(titanic_train)


# Remove spaces.
titanic_train$Surname = str_replace_all(titanic_train$Surname,
                                         " ",
                                         "")
View(titanic_train)


# Lower case all the surnames.
titanic_train$Surname <- tolower(titanic_train$Surname)
View(titanic_train)


# Remove non-letters from all the surnames.
titanic_train$Surname <- str_replace_all(titanic_train$Surname,
                                         "\\W",
                                         "")
View(titanic_train)


# Perform the same operation, but in two lines of code.
titanic_train$Surname2 <- str_extract(titanic_train$Name, "^[a-zA-Z\\s\\'\\-]+")
titanic_train$Surname2 <- tolower(str_replace_all(titanic_train$Surname2, "\\W", ""))
View(titanic_train)


# Extract titles from names.
surnames[1:10]

titles <- lapply(surnames, "[", 2)  
titles[1:10]

titles <- str_split(titles, " ")
titles[1:10]

titanic_train$Title <- unlist(lapply(titles, "[", 2))
View(titanic_train)
str(titanic_train)
unique(titanic_train$Title)


# Perform the same operation in one line of code
titanic_train$Title2 <- str_extract(titanic_train$Name, "[a-zA-Z]+\\.") 
View(titanic_train)
str(titanic_train$Title2)
unique(titanic_train$Title2)


# Useful function, detect characters in strings.
has_hyphen <- str_detect(titanic_train$Name, "-")
has_hyphen


# The following website is super useful for crafting 
# regular expression (regex):
#      http://regex101.com
titanic_train$Name[2]
regex <- "[a-zA-Z]+\\."
cat(regex)

