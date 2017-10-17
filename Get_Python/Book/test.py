
# F4  run select

a=1

print(a)
import os 
print(os.getcwd())

#http://pandas.pydata.org/

import pandas as pd

a=pd.read_csv('multiTimeline001.csv')

# excel object
xl = pd.ExcelFile('df.xlsx')
print(xl.sheet_names)
# Load a sheet into a DataFrame by name: df1
df1 = xl.parse('data_sheet1')
# Load a sheet into a DataFrame by index: df2
df2 = xl.parse(0)

df1
print(df1.head())

import sklearn
import quandl
import pandas as pd
import seaborn.apionly as sns

from sklearn.datasets import load_iris
iris = load_iris()
data = iris.data
column_names = iris.feature_names
column_names
df = pd.DataFrame(iris.data)
df

import seaborn.apionly as sns
iris = sns.load_dataset('iris')
iris.head()

df=quandl.get('WIKI/GOOGL')

df.head()

df.info()
df.describe()






