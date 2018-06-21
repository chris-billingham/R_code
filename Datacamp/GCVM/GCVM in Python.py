# GCVM in Python
Get  Clean Visualize Model
# 0 Basic

## 0.1 install

## 0.2 enviourment

get current working loaction:
```{python}
import os 
print(os.getcwd())
```

Set current working loaction:
```{python eval=FALSE}
import os
os.chdir("C:\\Users\\tduan\\Desktop\\Mission\\R\\R_code\\Get_Python\\Book")
```

Get computer info:
```{python}
import platform
print(platform.machine())
print(platform.platform())
print(platform.system())
print(platform.processor())
print(platform.python_version())
```
Show location files:
```{python}
import os
print(os.listdir())
```


## 0.3 package
Check all installed package:

!conda list
check package version:
import pkg_resources
pkg_resources.get_distribution("pandas").version

update package on Shell:
pip install [package_name] --upgrade
# 1 Get

## 1.1 Get from csv/txt
import pandas as pd
import numpy as np

url = 'https://raw.github.com/pandas-dev/pandas/master/pandas/tests/data/tips.csv'
tips = pd.read_csv(url)
tips.head()
tips.info()
tips.describe()
tips.to_csv('output_csv.csv')


## 1.2 Get from xlsx

xl = pd.ExcelFile("output_xlsx.xlsx")
xl.sheet_names

xlsx_data = xl.parse("Sheet1")

writer = pd.ExcelWriter('output_xlsx.xlsx')
xlsx_data.to_excel(writer,'Sheet1',index=False)
writer.save()

## 1.3 Get from sas/stat/matlab ect

## 1.4 Get from database(Mysql;sqlite;teradata;postgresql)

Teradata:
    
import pyodbc # pip install pyodbc
import pandas as pd

usr = 'xxxxx'
pwd = 'xxxxx'
conn = pyodbc.connect('DRIVER=Teradata;DBCNAME=mozart.vip.ebay.com;UID=%s;PWD=%s;QUIETMODE=YES' % (usr, pwd), autocommit=True,unicode_results=True)
    
df = pd.read_sql('select top 10 * from dw_countries', conn)
df.head()
    
    
## 1.5 Get from Web crawler

## 1.6 Get from API

## 1.8 Get from Big data(Hadoop;Spark)


## 1.8 Get from Other  eg sound,picture,movie



























# 2 Clean 
import pandas as pd
import matplotlib.pyplot as plt

import seaborn.apionly as sns
iris = sns.load_dataset('iris')

## 2.1 EDA
print(iris.head())


## 2.2 Data wrangling

select column:
tips[['total_bill', 'tip', 'smoker', 'time']].head(5)

filter:
tips[tips['time'] == 'Dinner'].head(5)    
tips[(tips['time'] == 'Dinner') & (tips['tip'] > 5.00)]    
tips[(tips['size'] >= 5) | (tips['total_bill'] > 45)]

frame = pd.DataFrame({'col1': ['A', 'B', np.NaN, 'C', 'D'],'col2': ['F', np.NaN, 'G', 'H', 'I']})
frame
frame[frame['col2'].isna()]
frame[frame['col1'].notna()]

group by and Summary:
tips.groupby('sex').size()
    
tips.groupby('day').agg({'tip': np.mean, 'day': np.size})    
    
arrange:
    
tips.sort_values(by=['tip']) 

arrange  by multiple columns

tips.sort_values(by=['tip','total_bill']) 

Sort Descending
tips.sort_values(by='tip', ascending=False)

Putting NAs first   
tips.sort_values(by='tip', ascending=False, na_position='first')


join:
df1 = pd.DataFrame({'key': ['A', 'B', 'C', 'D'],
   ....:                     'value': np.random.randn(4)})
    
df2 = pd.DataFrame({'key': ['B', 'D', 'D', 'E'],
   ....:                     'value': np.random.randn(4)})
    
inner join:
    
pd.merge(df1, df2, on='key')    
    
left join:    
pd.merge(df1, df2, on='key', how='left')  

full join:
pd.merge(df1, df2, on='key', how='outer')    

union(set and remove duplicate rows):
pd.concat([df1, df2]).drop_duplicates()    
uinon all(set without remove duplicate rows):    
pd.concat([df1, df2])    
  
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

## 2.3 Missing/Outlier















# 3 Visualization

## 3.1 matplotlib


#https://www.youtube.com/watch?v=q7Bo_J8x_dw&list=PLQVvvaa0QuDfefDfXb9Yf0la1fPDKluPF

import matplotlib.pyplot as plt

plt.plot([1,2,3],[5,7,4])

plt.show()








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

## 3.3 Map


## 3.4 Bokeh vs Dash


# 4 Model

## 4.1 relaction


### 4.1.1 two group one variable

T test
use when the variable to compare is countinuous
if P-value <0.05 then two group are different

Chi squared test
use when the variable to compare is categoriacal
if P-value <0.05 then two group are different



### 4.1.2 one group one variable in differect setting



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








