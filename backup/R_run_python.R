
#install.packages("devtools")
#(devtools)
#install("C:/Python27/Lib/rPython")
library(rPython)
python.load("C:/Users/User/Desktop/Mission/R/code/py_test001.py")
py_data <- python.get("a")
py_data
