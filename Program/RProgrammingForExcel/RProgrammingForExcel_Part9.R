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
# This R source code file corresponds to video 8 of the YouTube series
# "R Programming for Excel Users" located at the following URL:
#      https://youtu.be/IsCBLP-HGJk     
#


#===========================================================================
# Numeric Vectors
#

# Create a vector of integer values
my_vector <- 1:10
my_vector
my_vector_v2 <- c("a","bc","def")
my_vector_v2

# Inspect the vector more closely
class(my_vector)
class(my_vector_v2)
str(my_vector)
summary(my_vector)
summary(my_vector_v2)

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






