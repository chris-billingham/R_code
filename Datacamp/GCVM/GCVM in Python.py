
For Rtudio to run python:
install.packages("reticulate") 
library(reticulate)
repl_python()
exit 



# GCVM in Python
Get  Clean Visualize Model
print("hello world!")



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
#https://pythonprogramming.net/matplotlib-intro-tutorial/
#https://pandas.pydata.org/pandas-docs/stable/visualization.html
! pip install matplotlib
import matplotlib.pyplot as plt
plt.plot([1,2,3],[5,7,4])
plt.show()


#Legends, Titles, and Labels with Matplotlib
import matplotlib.pyplot as plt
x = [1,2,3]
y = [5,7,4]
x2 = [1,2,3]
y2 = [10,14,12]
plt.plot(x, y, label='First Line')
plt.plot(x2, y2, label='Second Line')
plt.xlabel('Plot Number')
plt.ylabel('Important var')
plt.title('Interesting Graph\nCheck it out')
plt.legend()
plt.show()

# Bar Charts
import matplotlib.pyplot as plt
plt.bar([1,3,5,7,9],[5,2,7,8,2], label="Example one")
plt.bar([2,4,6,8,10],[8,6,2,5,6], label="Example two", color='g')
plt.legend()
plt.xlabel('bar number')
plt.ylabel('bar height')
plt.title('Epic Graph\nAnother Line! Whoa')
plt.show()

#Histograms
import matplotlib.pyplot as plt
population_ages = [22,55,62,45,21,22,34,42,42,4,99,102,110,120,121,122,130,111,115,112,80,75,65,54,44,43,42,48]
bins = [0,10,20,30,40,50,60,70,80,90,100,110,120,130]
plt.hist(population_ages, bins, histtype='bar', rwidth=0.8)
plt.xlabel('x')
plt.ylabel('y')
plt.title('Interesting Graph\nCheck it out')
plt.legend()
plt.show()





### 3.1.1 scatter plot
import matplotlib.pyplot as plt
x = [1,2,3,4,5,6,7,8]
y = [5,2,4,2,1,4,5,2]
plt.scatter(x,y, label='skitscat', color='k', s=25, marker="o")
plt.xlabel('x')
plt.ylabel('y')
plt.title('Interesting Graph\nCheck it out')
plt.legend()
plt.show()

#Stack Plots
import matplotlib.pyplot as plt
days = [1,2,3,4,5]
sleeping = [7,8,6,11,7]
eating =   [2,3,4,3,2]
working =  [7,8,7,2,2]
playing =  [8,5,7,8,13]
plt.plot([],[],color='m', label='Sleeping', linewidth=5)
plt.plot([],[],color='c', label='Eating', linewidth=5)
plt.plot([],[],color='r', label='Working', linewidth=5)
plt.plot([],[],color='k', label='Playing', linewidth=5)
plt.stackplot(days, sleeping,eating,working,playing, colors=['m','c','r','k'])
plt.xlabel('x')
plt.ylabel('y')
plt.title('Interesting Graph\nCheck it out')
plt.legend()
plt.show()

# lines

import matplotlib.pyplot as plt
ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000', periods=1000))
ts = ts.cumsum()
ts.plot()

df = pd.DataFrame(np.random.randn(1000, 4), index=ts.index, columns=list('ABCD'))
df = df.cumsum()
plt.figure()
df.plot()








### 3.1.6 Other plot 


### 3.1.7 setting 


## 3.2 Seaborn
http://seaborn.pydata.org/introduction.html#introduction


## 3.3 plotly
https://plot.ly/python/
!pip install plotly --upgrade

import plotly
plotly.__version__

import plotly.plotly as py
import plotly.graph_objs as go
# Create random data with numpy
import numpy as np
N = 1000
random_x = np.random.randn(N)
random_y = np.random.randn(N)

# Create a trace
trace = go.Scatter(
    x = random_x,
    y = random_y,
    mode = 'markers'
)

data = [trace]

# Plot and embed in ipython notebook!
plotly.offline.plot(data, filename='basic-scatter')


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








