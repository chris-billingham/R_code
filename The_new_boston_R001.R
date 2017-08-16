# 
#https://www.youtube.com/playlist?list=PL6gx4Cwl9DGCzVMGCPi1kwvABu7eWv08P
#setwd("C:/Users/User/Desktop/Mission/R/The New Botson")
#getwd()
# 
#rm(list=ls())
# comment Ctrl+Shift+C
# 12+8
# 10/3
# R Programming Tutorial - 4 - Variables
# a=3
# a
# rm(a)
# a
# R Programming Tutorial - 5 - Different Data Types
# a=3
# class(a)
# b='gogo'
# class(b)
# c=3.4
# class(c)
# is.numeric(a)
# is.numeric(b)
# is.numeric(c)

# R Programming Tutorial - 6 - Working with Dates
# name='Tony Fly'
# nchar(name)
# 
# date001=as.Date("2016-12-12")
# date001
# class(date001)
# 
# R Programming Tutorial - 7 - Logical Operators
# 12==12
# 12!=14
# 
# R Programming Tutorial - 8 - Vectors
# b1=c(1,2,3,4)
# b2=c('apple','banana','blueberry')

# R Programming Tutorial - 9 - Awesome Vector Tips
# b1=1:5

# total_list=c()
# 
# for (n in c(1:20000)){
#   a=sample(0:1,1)
#   b=sample(0:1,1)
#   c=sample(0:1,1)
#   d=sample(0:1,1)
#   e=sample(0:1,1)
#   f=sample(0:1,1)
#   total=(a+b+c+d+e+f)*5
#   #print(total)
#   total_list=c(total_list,total)
# }
# 
# hist(total_list)
# table(total_list)
# prop.table(table(total_list))

# R Programming Tutorial - 10 - Getting Specific Items from a Vector
# a=1:10
# a
# a[1]
# R Programming Tutorial - 11 - Data Frame
# id <- 1:15
# age <- c(18,13,66,32,3,43,54,656,87,323,7,2,9,34,65)
# name <-c("bucky","tom","bobby","henry","emily","baby","hannah","joe","cathy","sandY","lesley","emma","ann","old dan","eric")
# x=data.frame(id,age,name)
# x
# dim(x)
# nrow(x)
# ncol(x)
# names(x)
# names(x)[1]
# head(x)
# tail(x)
# class(x)
# # R Programming Tutorial - 12 - More on Data Frames
# x[2]
# x$age
# x["age"]
# class(x$age)
# class(x["age"])
# class(x[2])
# class(x[,2])
# x[2,3]
# x[3,1]
# x[3,1:3]
# x[3,]
# x[,2]
# x[2]

# R Programming Tutorial - 13 - Lists
# Tony_list=list(71,"hello",x)
# class(Tony_list)  
# names(Tony_list)=c('num','word','thisisdata') 
  
# R Programming Tutorial - 14 - Matrix
# matrix001=matrix(1:50,nrow=5)
# matrix001

# R Programming Tutorial - 15 - How to Read CSV Files

# getwd()
# tuna=read.csv("brUsers.csv")
# class(tuna)
# head(tuna)
# R Programming Tutorial - 16 - How to Install Packages


# library(XML)
# item=readHTMLTable("http://www.w3schools.com/html/html_tables.asp",which=1)
# item
# R Programming Tutorial - 17 - Charts and Graphics
# data=read.csv("brUsers.csv")
# head(data)
# hist(data$age,main="ages",ylab="users",xlab='age')
# hist(data$age)
# plot(data$age,data$income)
# boxplot(data$age)

# R Programming Tutorial - 18 - Creating Scatterplots with ggplot2

# library(ggplot2)
# head(diamonds)
# class(diamonds)
# diamonds[3]
# data=as.data.frame(diamonds)
# head(data)
# 
# qplot(data$carat,data$price,data)
# 
# qplot(data$carat,data$price,data,color=data$clarity)

#################################################################################

# https://www.youtube.com/playlist?list=PLOU2XLYxmsIK9qQfztXeybpHvru-TrqAP

# Intro to R by Google Developers

# R 1.4 - Character and Boolean Vectors
v=c('asdfasasdfsadffd','aa','bbb')
nchar(v)<10
v[nchar(v)<10]



