
library(tidyverse)

#############   Correlation   ##################################

mtcars001=mtcars
glimpse(mtcars001)


# numeric  vs numeric
ggplot(data = mtcars001, aes(x = hp, y = mpg)) + 
  geom_point()

# numeric  vs character
ggplot(data = mtcars001, aes(x = cut(hp, breaks = 5), y = mpg)) + 
  geom_point()


##########   Outlier #########################################















#############   Regression    ####################################