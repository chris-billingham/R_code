#install.packages("sparklyr")
#install.packages(c("nycflights13", "Lahman"))

#https://beta.rstudioconnect.com/content/1705/taxiDemo.nb.html

#########################################
library(sparklyr)
library(dplyr)
sc=spark_connect(master="local")

iris_tbl <- copy_to(sc, iris)
flights_tbl <- copy_to(sc, nycflights13::flights, "flights_123")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")
src_tbls(sc)

flights_tbl %>% filter(dep_delay == 2)
###########################################


install.packages("miniUI")
library(ggplot2)
library(leaflet)
library(geosphere)
library(tidyr)
library(shiny)
library(sparklyr)
library(dplyr)
library(miniUI)
library(DT)
# Configure cluster
Sys.setenv(SPARK_HOME="/usr/lib/spark")
config <- spark_config()
config$spark.driver.cores   <- 32
config$spark.executor.cores <- 32
config$spark.executor.memory <- "40g"
# Connect to cluster
sc <- spark_connect(master = "yarn-client", config = config, version = '1.6.1')


