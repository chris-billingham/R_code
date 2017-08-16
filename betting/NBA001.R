
################################### ballr  #############################
#packages = c("shiny", "ggplot2", "hexbin", "dplyr", "httr", "jsonlite")
#install.packages(packages, repos = "https://cran.rstudio.com/")
#library(shiny)
runGitHub("ballr", "toddwschneider")

#######################      nbastat###############################
#install.packages("DiagrammeR")
#install.packages("curl")
#install.packages("glue")
install.packages("gmum.r")
library(curl)
library(DiagrammeR)
library(glue)
library(curlconverter)
library(gmum.r)
#devtools::install_github("hrbrmstr/curlconverter")
devtools::install_github("abresler/nbastatR")
library("nbastatR") # note requires a bunch of other packages which are listed in the import

