

##########  SQLite  #####################


#install.packages("RSQLite")
#install.packages("dbplyr")
library(RSQLite)
library(dbplyr)
library(dplyr)


#Create a database
db <- dbConnect(SQLite(), dbname="Test.sqlite")
dbListTables(db)

#create a table into database
dbWriteTable(db, "first_table_mtcars", mtcars)

#write append a table into old table
dbWriteTable(db, "first_table_mtcars", mtcars,append=TRUE)

# show table
dbListTables(db)

#show column
dbListFields(db, "first_table_mtcars")

#read table
dbReadTable(db, "first_table_mtcars")

# table reference:
mtcars_db <- tbl(db, "first_table_mtcars")
mtcars_db
mtcars_db %>% select(mpg:hp, am, carb)
mtcars_db_002=mtcars_db %>% select(mpg:hp, am, carb)%>%filter(hp>100)
mtcars_db_002
mtcars_db_002%>%show_query()
# download into dataframe
mtcars_df=mtcars_db_002%>%collect()




