#install.packages('benchmarkme')
library(Rtsne)
library(doParallel)
library(benchmarkme)


getwd()
setwd('C:/Users/User/Desktop/Mission/R/R_code/Datacamp')

## Return the machine CPU
cat("Machine:     "); print(get_cpu()$model_name)

## Return number of true cores
cat("Num cores:   "); print(detectCores(logical = FALSE))

## Return number of threads
cat("Num threads: "); print(detectCores(logical = TRUE))

## Return the machine RAM
cat("RAM:         "); print (get_ram()); cat("\n")

## Return train.csv size
cat("file size:         "); print (file.size('train.csv')/1000000000); cat("GB")


