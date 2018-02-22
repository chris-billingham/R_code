
############   String #################

version
library(stringr)
str_trim("  sadf ff  ")

str_pad("12345",width=7,side="left",pad="0")
str_detect(c("haha","123"),"haha")
str_replace(c("haha","123"),"haha","go")
tolower("DASDF")
toupper("asdfas")



################### missing  ####################




#is.na(df)
#any(is.na(df))
#sum(is.na(df))

#complete.case(df)

#df[complete.case(df),]


class()
dim()
names()
str()
glimpse()
summary()

head()
tail()
print()

hist()
plot()

####################   type ############################

as.character()

as.numeric()

as.factor()

as.logical()



# Gather the columns
weather2 <- gather(weather, day, value, X1:X31, na.rm = TRUE)

# Spread the data
weather3 <- spread(weather2, measure , value)







