


getwd()
mtcars

library(xlsx)


write.xlsx2(mtcars, 
           "df.xlsx", 
           sheetName="data_sheet1"
           )

data1=read.xlsx("df.xlsx", sheetIndex =1)


data2=read.xlsx("df.xlsx", sheetIndex =1,startRow=2, colIndex = 2)

df <- read.table("txt_data.txt", 
                 header = TRUE).

library(dplyr)
glimpse(iris)
summary(iris)

?datasets
iris

mtcars%>%filter(cyl==6 & (hp >120|hp<110))


mtcars%>%select(mpg,cyl)    
mtcars
mtcars[c(1:3),]

mtcars[c(3:5),]

left_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))

full_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))   # left join 

inner_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))    # left join 

t(mtcars)





#### lapply()
The output returned is a list 
A

lapply(MyList,"[", , 2)        # Get each dataframs second col
lapply(MyList,"[", 1, )        # Get each dataframs first row

class(sapply(MyList,"[", , 2))

sapply(MyList,"[", , 2)        # Get each dataframs second col
sapply(MyList,"[", 1, )        # Get each dataframs first row












install.packages("drat")       # easier repo access + creation
drat:::add("ghrr")             # make it known
install.packages("gtrendsR")   # install it








```{r eval=FALSE}
mtcars%>%select(mpg,cyl)                    # select mpg and cyl column
mtcars%>%select(-mpg)                       # select all but exclude mpg
```



#### summary and group by 

```{r eval=FALSE}
mtcars%>%group_by()%>%summarise(row_number=n(),cyl_number=n_distinct(cyl))   # sum row number and distinct cyl number
mtcars%>%group_by(cyl)%>%summarise(mpg_sum=sum(mpg),mpg_mean=mean(mpg))   # sum mpg and mean mpg for each cyl
```




#### order and transpose

```{r eval=FALSE}
mtcars%>%arrange(desc(cyl))   # order by cyl decreasing
t(mtcars)                     # transpose
```

#### join
```{r eval=FALSE}

left_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))   # left join 

full_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))   # full join 

inner_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))  # inner join 
```


### apply family 

#### apply()

for matrix

```{r eval=FALSE}
X <- matrix(rnorm(30), nrow=2, ncol=6) # Construct a 5x6 matrix
apply(X, 2, sum)  # Sum the values of each column with `apply()`  
apply(X, 1, mean)  # mean the values of each row with `apply()` 
```


#### lapply()
The output returned is a list 
```{r eval=FALSE}
A=as.data.frame(matrix(1:9,nrow=3,ncol=3))
B=as.data.frame(matrix(11:19,nrow=3,ncol=3))
C=as.data.frame(matrix(101:109,nrow=3,ncol=3))

MyList <- list(A,B,C)          # Put dataframe A B C to a list 
lapply(MyList,"[", , 2)        # Get each dataframs second col
lapply(MyList,"[", 1, )        # Get each dataframs first row
```

#### sapply()

The sapply() function works like lapply(), but it tries to simplify the output to the most elementary data structure that is possible. And indeed, sapply() is a ¡®wrapper¡¯ function for lapply().

```{r eval=FALSE}
A=as.data.frame(matrix(1:9,nrow=3,ncol=3))
B=as.data.frame(matrix(11:19,nrow=3,ncol=3))
C=as.data.frame(matrix(101:109,nrow=3,ncol=3))

MyList <- list(A,B,C)          # Put dataframe A B C to a list 
sapply(MyList,"[", , 2)        # Get each dataframs second col and put it into a matrix by col
sapply(MyList,"[", 1, )        # Get each dataframs first row  and put it into a matrix by col
```

#### mapply()

The mapply() function stands for 'multivariate apply'. Its purpose is to be able to vectorize arguments to a function that is not usually accepting vectors as arguments.








A=as.data.frame(matrix(1:9,nrow=3,ncol=3))
B=as.data.frame(matrix(11:19,nrow=3,ncol=3))
C=as.data.frame(matrix(101:109,nrow=3,ncol=3))

MyList <- list(A,B,C)          # Put dataframe A B C to a list 
sapply(MyList,"[", , 2)        # Get each dataframs second col and put it into a matrix by col
sapply(MyList,"[", 1, )        # Get each dataframs first row  and put it into a matrix by col



install.packages('PMassicotte/gtrendsR')
install.packages('reshape2')
library(gtrendsR)
library(reshape2)

user <- "verykoala@gmail.com"
psw <- "Gcqmygqwe123qwe!"
gconnect(user, psw,verbose = TRUE) 

install.packages('jsonlite')
library(devtools)
devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)

library(gtrendsR)
usr <- "verykoala@gmail.com"
psw <- "Gcqmygqwe123qwe!"
gconnect(usr, psw)

res <- gtrends(c("nhl", "nba"), geo = c("CA", "US"))
plot(res)

head(gtrends("NHL")$interest_over_time)


install.packages('curl')
library(curl)

library(gtrendsR)

??gtrendsR


a=data("countries")
a

res <- gtrends("nhl", geo = c("CA", "US"))
plot(res)
library(installr)
uninstall.packages('gtrendsR')


install.packages('rvest')
install.packages('curl')

library(rvest)
library(curl)

devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
res <- gtrends("sko", geo = "NO", cat = "18")
head(res$interest_over_time)



