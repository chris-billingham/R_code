
#https://www.youtube.com/playlist?list=PLQVvvaa0QuDfKTOs3Keq_kaG2P55YRn5v
#https://pythonprogramming.net/features-labels-machine-learning-tutorial/

import quandl
import pandas as pd
import math
import numpy as np


from sklearn import preprocessing, cross_validation, svm
from sklearn.linear_model import LinearRegression

df=quandl.get('WIKI/GOOGL')

df.head()

df.info()
df.describe()


list(df)

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


df002=df
df002.dropna(inplace=True)

df002.info()

X = np.array(df002.drop(['label'], 1))
y = np.array(df002['label'])

X = preprocessing.scale(X)

X_train, X_test, y_train, y_test = cross_validation.train_test_split(X, y, test_size=0.2)
#########################################
clf = LinearRegression()

clf.fit(X_train, y_train)

confidence = clf.score(X_test, y_test)
confidence
###########################################
clf = svm.SVR()

clf.fit(X_train, y_train)

confidence = clf.score(X_test, y_test)
confidence

###########################################
clf = LinearRegression(n_jobs=-1)
for k in ['linear','poly','rbf','sigmoid']:
    clf = svm.SVR(kernel=k)
    clf.fit(X_train, y_train)
    confidence = clf.score(X_test, y_test)
    print(k,confidence)






