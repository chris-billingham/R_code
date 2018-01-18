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
# This R source code file corresponds to video 10 of the YouTube series
# "R Programming for Excel Users" located at the following URL:
#      https://youtu.be/pMfTSxkMbyw     
#


#===========================================================================
# Numeric Vectors
#

# Create a vector of integer values
my_vector <- 1:10
my_vector


# Inspect the vector more closely
class(my_vector)
str(my_vector)
summary(my_vector)


# Add 1 to each value of the vector
my_vector_plus1 <- my_vector + 1
my_vector_plus1


# Divide each value of the vector by 2
half_my_vector <- my_vector / 2
half_my_vector


# Make the vector whole again
whole_my_vector <- half_my_vector + half_my_vector
whole_my_vector


# Square the value of each vector
my_vector_squared1 <- my_vector * my_vector
my_vector_squared1


# Square the value of each vector
my_vector_squared2 <- my_vector ^ 2
my_vector_squared2


# Take the square root of each value
sqrt_my_vector <- sqrt(my_vector)
sqrt_my_vector


# More vectorized functions
sum(my_vector)
mean(my_vector)
sd(my_vector)


#===========================================================================
# Logical Vectors
#

# Which values are greater than 3.5?
larger_than_3.5 <- my_vector > 3.5
larger_than_3.5


# Inspect vector more closely
class(larger_than_3.5)
str(larger_than_3.5)
summary(larger_than_3.5)


# Grab only the values larger than 3.5
my_vector2 <- my_vector[larger_than_3.5]
my_vector2


# Grab only the values larger than 3.5
my_vector3 <- my_vector[my_vector > 3.5]
my_vector3


# Grow the vector
my_bigger_vector <- c(my_vector, 11:15, 16, 17, 18, 19, 20)
my_bigger_vector


# How big is it now?
length(my_bigger_vector)
dim(my_bigger_vector)


#===========================================================================
# String Vectors
#

# Create a vector of strings
force_users <- c("Yoda", "Darth Vader", "Obi Wan", "Mace Windu", 
                 "Darth Maul", "Luke Skywalker", "Darth Sidious")


# Inspect vector more closely
class(force_users)
str(force_users)
summary(force_users)


# Add 1 to string vector
force_users + 1


# Add another force user
force_users <- force_users + "Kylo Ren"


# Add more force users
more_force_users <- c(force_users, "Qui-Gon Jinn", "Darth Tyranus")
more_force_users


# How big is the vector?
length(more_force_users)


# How long is each string in the vector?
name_lengths <- nchar(more_force_users)
name_lengths


#===========================================================================
# Missing Values
#

# Build a vector with missing values
birthplaces <- c(NA, "Tatooine", "Stewjon", "Haruun Kal", "Dathomir",
                 "Polis Massa", "Naboo", "Coruscant", "Serenno")

birthplaces002 <- c(NA, 3,4,5)
birthplaces002
is.na(birthplaces002)
birthplaces


# Inspect closer
class(birthplaces)
str(birthplaces)
summary(birthplaces)


# Vectorized operation
is.na(birthplaces)
nchar(birthplaces)
nchar("")


# Logical operations
birthplaces[!is.na(birthplaces)]

10000*(1+0.0005)^60

