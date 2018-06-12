# GCVM in R 
Get  Clean Visualize Model
# 0 Basic

## 0.1 install

## 0.2 enviourment

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





# 1 Get

## 1.1 connect with csv/txt
library(readr)

csv_df <- read_csv("zipcode.csv", header=TRUE)

input txt 
Read txt file:
```{r eval=FALSE}
txt_df <- read.table("txt_data.txt", 
                     header = TRUE)
```

## 1.2 connect with xlsx
read excel
readxl Package(without Java)
library(readxl)

xlsx Package(use Java)
library(xlsx)


tidyxl Package(imports non-tabular data from Excel)
library(tidyxl)


create excel

## 1.3 connect with sas/stat/matlab ect

## 1.4 connect with database(Mysql;sqlite;teradata;postgresql)

## 1.5 Get from Web crawler

## 1.6 Get from API

## 1.8 Get from Big data(Hadoop;Spark)


## 1.8 Get from Other  eg sound,picture,movie

# 2 Clean 


## 2.1 EDA



## 2.2 Data wrangling
[dplyr] package

filter row:
```{r eval=FALSE}
library(dplyr)
mtcars%>%filter(cyl==6)                    # filter cly==6
mtcars%>%filter(cyl==6 & (hp >120|hp<110)) # filter cly==6 and (hp >120 or hp<110)
```

select column:
```{r eval=FALSE}
mtcars%>%select(mpg,cyl)                    # select mpg and cyl column
mtcars%>%select(-mpg)                       # select all but exclude mpg
```

create new variable:
  ```{r eval=FALSE}
mtcars%>%mutate(mpg_2=mpg*2)                  # create mpg_2=mpg*2
mtcars%>%mutate(cyl=cyl-2)                    # change cyl=cyl-2
```

group by and Summary:
```{r eval=FALSE}
mtcars%>%group_by()%>%summarise(row_number=n(),cyl_number=n_distinct(cyl))   # sum row number and distinct cyl number
mtcars%>%group_by(cyl)%>%summarise(mpg_sum=sum(mpg),mpg_mean=mean(mpg))   # sum mpg and mean mpg for each cyl
```

order:
```{r eval=FALSE}
mtcars%>%arrange(desc(cyl))   # order by cyl decreasing
```

join:
```{r eval=FALSE}

left_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))   # left join 

full_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))   # full join 

inner_join(mtcars[c(1:3),],mtcars[c(3:5),],by=c('mpg'='mpg'))  # inner join 
```

transpose:
```{r eval=FALSE}
t(mtcars)                     # transpose
```

gather():long/short
library(tidyr)

[sqldf] package


## 2.3 Missing/Outlier




# 3 Visualization

## 3.1 ggplot2:scatter plot;line plot;histogram;bar chart
data;axis;plot



### 3.1.1 scatter plot
```{r eval=FALSE}
library(gapminder)
library(dplyr)
library(ggplot2)
# Create a scatter plot with pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point()

```


log scale
```{r eval=FALSE}
library(gapminder)
library(dplyr)
library(ggplot2)
# Create a scatter plot with pop on the x-axis(as log) and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point()+scale_x_log10()

```


color
```{r eval=FALSE}
library(gapminder)
library(dplyr)
library(ggplot2)
# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

```

size
```{r eval=FALSE}
# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()
```

Faceting
```{r eval=FALSE}
# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)

```

Faceting with free Y scales
```{r eval=FALSE}
# Scatter plot comparing pop and lifeExp, faceted by continent wiyh free y scales
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent,scales="free_y")
```


### 3.1.2 line plot
```{r eval=FALSE}
# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x = year, y = medianGdpPercap)) +
  geom_line() +
  expand_limits(y = 0)
```

### 3.1.3 Bar plot
```{r eval=FALSE}
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) +
  geom_col()
```

### 3.1.4 histograms
```{r eval=FALSE}
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop)
ggplot(gapminder_1952, aes(x = pop)) +
  geom_histogram()

```

histograms With 10 bins
```{r eval=FALSE}
# Create a histogram of population (pop) with 10 bins
ggplot(gapminder_1952, aes(x = pop)) +
  geom_histogram(bins=10)

```

histograms With width 5 for each bins
```{r eval=FALSE}
# Create a histogram of population (pop) with 10 bins
ggplot(gapminder_1952, aes(x = pop)) +
  geom_histogram(binwidth =5)

```

### 3.1.5 Boxplot
```{r eval=FALSE}
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10()

```
### 3.1.6 Other plot 


### 3.1.7 setting 



## 3.2 plotly
simple: 
  ```{r message=FALSE,warning=FALSE}
plot_ly(data=mtcars, x = ~wt , y =~mpg,mode='markers')
```

group by numeric:
  ```{r message=FALSE,warning=FALSE}
plot_ly(data=mtcars, x = ~wt , y =~mpg,mode='markers',color = ~cyl)
```

group by factor:
  ```{r message=FALSE,warning=FALSE}
plot_ly(data=mtcars, x = ~wt , y =~mpg,mode='markers',color = ~as.factor(cyl))
```

group by factor + hp as dot size: 
  ```{r message=FALSE,warning=FALSE}
plot_ly(data=mtcars, x = ~wt , y =~mpg,mode='markers',color = ~as.factor(cyl),size=~hp)
```

3D scatter:
  ```{r message=FALSE,warning=FALSE}
plot_ly(data=mtcars, x = ~wt , y =~mpg,z=~hp,type="scatter3d",mode='markers',color = ~as.factor(cyl))
```


line chart:
  
  line:
  ```{r message=FALSE,warning=FALSE}
plot_ly(x=~time(airmiles),y=~airmiles,mode='lines')
```

Multi line chart:
  ```{r message=FALSE,warning=FALSE}
library(plotly)
library(tidyr)
library(dplyr)
data("EuStockMarkets")
stocks <- as.data.frame(EuStockMarkets) %>%
  gather(index, price) %>%
  mutate(time = rep(time(EuStockMarkets), 4))
plot_ly(stocks, x = ~time, y = ~price, color = ~index)
```


histogram:
  ```{r message=FALSE,warning=FALSE}
library(plotly)
plot_ly(x = ~precip, type = "histogram")
```

bar chart
pie chart(not important)

boxplot:
  ```{r message=FALSE,warning=FALSE}
plot_ly(iris, y = ~Petal.Length, color = ~Species, type = "box")
```



## 3.3 Map


## 3.4 Shiny


# 4 Model

## 4.1 relaction


### 4.1.1 two group one numeric variable on one numeric variable

T test
use when the variable to compare is countinuous
if P-value <0.05 then two group are different


### 4.1.2 two group one categorical variale on one categorical variable
Chi squared test
use when the variable to compare is categoriacal
if P-value <0.05 then two group are different

### 4.1.3 one group one numeric variable on one numeric variable



## 4.2 classification


## 4.3 scoring



## 4.4 ranking

## 4.5 clustering

## 4.6 Time series

## 4.7 Model API

## 4.8 Kaggle


## 4.9 Sample

## 4.10 A/B testing






#5 resource 
## 5.1 Book list:
1.The Lady Tasting Tea by David Salsburg
2.The Art of R Programming by Norman Matloff 
3.R for Data Science by Hadley Wickham and Garrett Grolemund
4.Introduction to Statistical Learning(ISLR) by Gareth James,Daniela Witten and Trevor Hastie Robert Tibshirani
5.ggplot2 - Elegant Graphics for Data Analysis  by Hadley Wickham
6.Deep Learning with R by François Chollet with J. J. Allaire
## 5.2 talk:
Introduction to Big O Notation and Time Complexity
https://www.youtube.com/watch?v=D6xkbGLQesk  


The State of Artificial Intelligence by Andrew Ng
https://www.youtube.com/watch?v=NKpuX_yzdYs

Data Structures & Algorithms
https://www.youtube.com/watch?v=bum_19loj9A
  

## 5.3 The Giants
"If I have seen further, it is by standing on the shoulders of giants" by Isaac Newton.

Hadley Wickham
Joe Cheng
Yihui Xie 

## 5.4 Case study:  








