
#https://www.youtube.com/playlist?list=PLQVvvaa0QuDfKTOs3Keq_kaG2P55YRn5v
#https://pythonprogramming.net/features-labels-machine-learning-tutorial/


#Machine Learning 2017/11/04 P12

#Deep Learning   2017/11/04 P2


#delete all variable
#%reset 
#####  get wd 
import os
os.getcwd()
#####  set wd 
os.chdir('C:/Users/User/Desktop/Mission/R/R_code/Get_Python/Book')


################ import package ####################
import quandl
import pandas as pd
import math
import numpy as np


from sklearn import preprocessing, cross_validation, svm
from sklearn.linear_model import LinearRegression


import datetime
import matplotlib.pyplot as plt
from matplotlib import style

import pickle




################  Download data ############################
df=quandl.get('WIKI/EBAY')

#save_df=df

df.head()
df.tail()
df.info()
df.describe()# 3328 days


list(df) #variable name

df['Adj. Close'].plot()



##############   data cleaning ###########################
df['HL_PCT'] = (df['Adj. High'] - df['Adj. Low']) / df['Adj. Close'] * 100.0


df['PCT_change'] = (df['Adj. Close'] - df['Adj. Open']) / df['Adj. Open'] * 100.0


df = df[['Adj. Close', 'HL_PCT', 'PCT_change', 'Adj. Volume']]
print(df.head())


forecast_col = 'Adj. Close'
df.fillna(value=-99999, inplace=True)
forecast_out = int(math.ceil(0.01 * len(df)))
forecast_out

df['label'] = df[forecast_col].shift(-forecast_out)
df.info()

########################################################


df.dropna(inplace=True)   # drop last predict day



#######  x is input 
X = np.array(df.drop(['label'], 1))

#######  y is the label 
y = np.array(df['label'])


##########  scale 
X = preprocessing.scale(X)

##########  random split to  80%  x train y train ;20%  x test y test 

X_train, X_test, y_train, y_test = cross_validation.train_test_split(X, y, test_size=0.2)


################     fit  LinearRegression  with train data          #########################
# define method
clf = LinearRegression()
# tran the model
clf.fit(X_train, y_train)


##############  score the test data[in sample testing] ################
confidence = clf.score(X_test, y_test)
confidence
###############       fit  SVR  with train data                    ############################
clf = svm.SVR()

clf.fit(X_train, y_train)

##############  score the test data ################
confidence = clf.score(X_test, y_test)
confidence

#############       try 4 method             ##############################
clf = LinearRegression(n_jobs=-1) # -1: as many as we can  default:1 
for k in ['linear','poly','rbf','sigmoid']:
    clf = svm.SVR(kernel=k)
    clf.fit(X_train, y_train)
    confidence = clf.score(X_test, y_test)
    print(k,confidence)


#########################   out sample testing            ###############################################
df=quandl.get('WIKI/GOOGL')
########### data clean
df = df[['Adj. Open',  'Adj. High',  'Adj. Low',  'Adj. Close', 'Adj. Volume']]
df['HL_PCT'] = (df['Adj. High'] - df['Adj. Low']) / df['Adj. Close'] * 100.0
df['PCT_change'] = (df['Adj. Close'] - df['Adj. Open']) / df['Adj. Open'] * 100.0

df = df[['Adj. Close', 'HL_PCT', 'PCT_change', 'Adj. Volume']]
forecast_col = 'Adj. Close'
df.fillna(value=-99999, inplace=True)
forecast_out = int(math.ceil(0.01 * len(df)))
forecast_out
df['label'] = df[forecast_col].shift(-forecast_out)

##########   Scatter plot between today close and future predict close 
df.head()
plt.scatter(df['Adj. Close'],df['label'],color='#003F72')
plt.show()



###########  make X and y 
X = np.array(df.drop(['label'], 1))
X = preprocessing.scale(X)
X_lately = X[-forecast_out:]
X = X[:-forecast_out]

df.dropna(inplace=True)

y = np.array(df['label'])


##########  random split to  80%  x train y train ;20%  x test y test 
X_train, X_test, y_train, y_test = cross_validation.train_test_split(X, y, test_size=0.2)

#############  Linear Regression model #############
# define the method
clf = LinearRegression(n_jobs=-1)
# train the model
clf.fit(X_train, y_train)

# save the trained model
with open('linearregression.pickle','wb') as f:
    pickle.dump(clf, f)

# load  the trained model
pickle_in = open('linearregression.pickle','rb')
clf = pickle.load(pickle_in)

confidence = clf.score(X_test, y_test)
confidence


#############  socre the out sample data ################
forecast_set = clf.predict(X_lately)
df['Forecast'] = np.nan

last_date = df.iloc[-1].name
last_unix = last_date.timestamp()
one_day = 86400
next_unix = last_unix + one_day

for i in forecast_set:
    next_date = datetime.datetime.fromtimestamp(next_unix)
    next_unix += 86400
    df.loc[next_date] = [np.nan for _ in range(len(df.columns)-1)]+[i]

df['Adj. Close'].plot()
df['Forecast'].plot()
plt.legend(loc=4)
plt.xlabel('Date')
plt.ylabel('Price')
plt.show()

################      find the best fit line              #########################################

from statistics import mean
import numpy as np

xs = np.array([1,2,3,4,5], dtype=np.float64)
ys = np.array([5,4,6,5,6], dtype=np.float64)

def best_fit_slope_and_intercept(xs,ys):
    m = (((mean(xs)*mean(ys)) - mean(xs*ys)) /
         ((mean(xs)*mean(xs)) - mean(xs*xs)))
    
    b = mean(ys) - m*mean(xs)
    
    return m, b

m, b = best_fit_slope_and_intercept(xs,ys)

print(m,b)

   
regression_line = []
for x in xs:
    regression_line.append((m*x)+b)
    
regression_line

import matplotlib.pyplot as plt
from matplotlib import style
style.use('ggplot')


plt.scatter(xs,ys,color='#003F72',label='data')
plt.plot(xs, regression_line, label='regression line')
plt.legend(loc=4)
plt.show()


predict_x = 7
predict_y = (m*predict_x)+b





