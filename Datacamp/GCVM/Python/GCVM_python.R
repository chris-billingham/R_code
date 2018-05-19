# GCVM in Python

# 0 Basic

## 0.1 install

## 0.2 enviourment

# 1 Get

## 1.1 Get from csv/txt

## 1.2 Get from xlsx

## 1.3 Get from sas/stat/matlab ect

## 1.4 Get from database

## 1.5 Get from Web crawler

## 1.6 Get from API

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



## 2.3 Missing/Outlier




# 3 Visualization

## 3.1 ggplot2:scatter plot;line plot;histogram;bar chart
data;axis;plot



scatter plot
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
# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()


Faceting
 
## 3.2 plotly

## 3.3 Map

# 4 Model

## 4.1 relaction

## 4.2 classification


## 4.3 scoring



## 4.4 ranking

## 4.5 clustering



Book








