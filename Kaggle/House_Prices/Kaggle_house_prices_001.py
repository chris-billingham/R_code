#https://www.kaggle.com
#jcwinning@163.com
#https://www.kaggle.com/c/house-prices-advanced-regression-techniques
#https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data
#https://www.kaggle.com/bsivavenu/house-price-calculation-methods-for-beginners
#%reset  # clen all var


import os 
print(os.getcwd())

os.chdir("C:\\Users\\tduan\\Desktop\\Mission\\R\\R_code\\Python\\House_Prices")

########################## package ##############################

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from bokeh.plotting import figure, output_file, show
#url="https://www.kaggle.com/c/titanic/download/test.csv"
#c=pd.read_csv(url)
############################################################


###########  import  data ####################################
test000=pd.read_csv('test.csv')
train000=pd.read_csv('train.csv')
sample_submission=pd.read_csv('sample_submission.csv')


train001=train000
test001=test000

################################################################


########### EDA ##################
train001.shape
print(train001.columns.values)
train001.info()

train001.head()
train001.sample(5)

#numeric
train001.describe()


#category
train001.describe(include=['O'])
#train001['Survived'].value_counts(dropna=0)


# target 
#histogram
sns.distplot(train001['SalePrice']);
#skewness and kurtosis
print("Skewness: %f" % train001['SalePrice'].skew())
print("Kurtosis: %f" % train001['SalePrice'].kurt())

# target vs category
sns.countplot(x="Survived", data=train001)
sns.countplot(x="Sex",hue="Survived", data=train001)
sns.countplot(x="Embarked",hue="Survived", data=train001)
sns.countplot(x="Pclass",hue="Survived", data=train001)

sns.barplot(x="Sex", y="Survived", hue="Pclass", data=train001);

# target vs numeric
sns.swarmplot( x="Survived",y="Fare" ,data=train001)
sns.boxplot( x="Survived",y="Fare" ,data=train001)


#correlation matrix
corrmat = train001.corr()
f, ax = plt.subplots(figsize=(12, 9))
sns.heatmap(corrmat, vmax=.8, square=True);


#saleprice correlation matrix
k = 10 #number of variables for heatmap
cols = corrmat.nlargest(k, 'SalePrice')['SalePrice'].index
cm = np.corrcoef(train001[cols].values.T)
sns.set(font_scale=1.25)
hm = sns.heatmap(cm, cbar=True, annot=True, square=True, fmt='.2f', annot_kws={'size': 10}, yticklabels=cols.values, xticklabels=cols.values)

#scatterplot
sns.set()
cols = ['SalePrice', 'OverallQual', 'GrLivArea', 'GarageCars', 'TotalBsmtSF', 'FullBath', 'YearBuilt']
sns.pairplot(train001[cols], size = 2.5)



##############################################


########### data cleaning  ##################

# check missing 
#missing data
total = train001.isnull().sum().sort_values(ascending=False)
percent = (train001.isnull().sum()/train001.isnull().count()).sort_values(ascending=False)
missing_data = pd.concat([total, percent], axis=1, keys=['Total', 'Percent'])
missing_data.head(20)


# clear and new features 
categorical_features = train001.select_dtypes(include=['object']).columns
numerical_features = train001.select_dtypes(exclude = ["object"]).columns
# Differentiate numerical features (minus the target) and categorical features
numerical_features = numerical_features.drop("SalePrice")
print("Numerical features : " + str(len(numerical_features)))
print("Categorical features : " + str(len(categorical_features)))
train_num = train001[numerical_features]
train_cat = train001[categorical_features]

# Handle remaining missing values for numerical features by using median as replacement
print("NAs for numerical features in train : " + str(train_num.isnull().values.sum()))
train_num = train_num.fillna(train_num.median())
print("Remaining NAs for numerical features in train : " + str(train_num.isnull().values.sum()))
train_cat.shape
train_cat = pd.get_dummies(train_cat)
train_cat.shape
str(train_cat.isnull().values.sum())



#Now after transformation(preprocessing) we'll join them to get the whole train set back.
train001 = pd.concat([train_cat,train_num],axis=1)
train001.shape





##############################################

###################   Model #######################
# Splitting up the Training Data
from sklearn.model_selection import train_test_split

X_train_all=train001.drop(['SalePrice'], axis=1)
y_train_all=train001['SalePrice']


#split the data to train the model 
num_test = 0.20
X_train,X_test,y_train,y_test = train_test_split(X_train_all,y_train_all,test_size = num_test,random_state= 0)

X_train.head(3)

#Linear model without Regularization
from sklearn.linear_model import LinearRegression, RidgeCV, LassoCV,Lasso,ElasticNetCV
from sklearn.model_selection import cross_val_score, train_test_split
from sklearn.metrics import mean_squared_error
lr = LinearRegression()
lr.fit(X_train,y_train)
y_pred = lr.predict(X_train)
R2=lr.score(X_train, y_train)
R2
rmse = np.sqrt(mean_squared_error(y_train, y_pred))
rmse

lr_cv_scores = cross_val_score(lr, X_train, y_train, cv=5).mean()
lr_cv_scores2 = cross_val_score(lr, X_test, y_test, cv=5).mean()

print(lr_cv_scores)
print(lr_cv_scores2)


#Regularization Linear model

#ridge 
ridge = RidgeCV(alphas = [0.01, 0.03, 0.06, 0.1, 0.3, 0.6, 1, 3, 6, 10, 30, 60])
ridge.fit(X_train,y_train)
alpha = ridge.alpha_
print('best alpha',alpha)

print("Try again for more precision with alphas centered around " + str(alpha))
ridge = RidgeCV(alphas = [alpha * .6, alpha * .65, alpha * .7, alpha * .75, alpha * .8, alpha * .85, 
                          alpha * .9, alpha * .95, alpha, alpha * 1.05, alpha * 1.1, alpha * 1.15,
                          alpha * 1.25, alpha * 1.3, alpha * 1.35, alpha * 1.4],cv = 5)
ridge.fit(X_train, y_train)
alpha = ridge.alpha_
print("Best alpha :", alpha)
rmse = np.sqrt(-cross_val_score(ridge,X_train,y_train,scoring ="neg_mean_squared_error",cv=5)).mean()
rmse2 = np.sqrt(-cross_val_score(ridge,X_test,y_test,scoring ="neg_mean_squared_error",cv=5)).mean()
rmse
rmse2

R_sq=ridge.score(X_train, y_train)
R_sq2=ridge.score(X_test, y_test)
R_sq
R_sq2

y_train_rdg = ridge.predict(X_train)
y_test_rdg = ridge.predict(X_test)





