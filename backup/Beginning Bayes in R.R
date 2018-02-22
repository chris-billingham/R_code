#install.packages("TeachBayes")
library(TeachBayes)
library(dplyr)
areas=c(2,1,2,1,2)
spinner_plot(areas)
df=data.frame(Region=1:5,areas,Probability=areas/sum(areas))
df
sum(df$Probability)
