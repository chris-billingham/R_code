#https://www.kaggle.com
#jcwinning@163.com
#https://www.kaggle.com/c/titanic
#https://www.kaggle.com/c/titanic/data
#https://www.kaggle.com/headsortails/pytanic
#%reset   #clen all var


import os 
print(os.getcwd())

os.chdir("C:\\Users\\tduan\\Desktop\\Mission\\R\\R_code\\Python\\titanic")

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
gender_submission=pd.read_csv('gender_submission.csv')
test001=test000
train001=train000
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
train001['Survived'].value_counts(dropna=0)
train001['Cabin'].value_counts(dropna=0)
train001['Ticket'].value_counts(dropna=0)
train001['Embarked'].value_counts(dropna=0)

# PLot 1  with seaborn

# category vs target 
sns.countplot(x="Survived", data=train001)
sns.countplot(x="Sex",hue="Survived", data=train001)
sns.countplot(x="Embarked",hue="Survived", data=train001)
sns.countplot(x="Pclass",hue="Survived", data=train001)

sns.barplot(x="Sex", y="Survived", hue="Pclass", data=train001);

# numeric vs target 

sns.swarmplot( x="Survived",y="Fare" ,data=train001)
sns.boxplot( x="Survived",y="Fare" ,data=train001)



##############################################


########### data cleaning  ##################
train002=train001
#full_data = [train002, test001]

# check missing 
print(train002.isnull().sum())


# clear and new features 

# Name_length
train002['Name_length'] = train002['Name'].apply(len)
#Has_Cabin
train002['Has_Cabin'] = train002["Cabin"].apply(lambda x: 0 if type(x) == float else 1)

# Embarked
train002["Embarked"] = train002["Embarked"].fillna("S")
train002['Embarked'].value_counts(dropna=0)
train002['Embarked'] = train002['Embarked'].map( {'S': 0, 'C': 1, 'Q': 2} ).astype(int)
# Create new feature FamilySize as a combination of SibSp and Parch
train002['FamilySize'] = train002['SibSp'] + train002['Parch'] + 1

# Create new feature IsAlone from FamilySize
train002['IsAlone'] = 0
train002.loc[train002['FamilySize'] == 1, 'IsAlone'] = 1

# Fare:Remove all NULLS in the Fare column and create a new feature CategoricalFare

train002['Fare'] = train002['Fare'].fillna(train002['Fare'].median())
train002['CategoricalFare'] = pd.qcut(train002['Fare'], 4)

train002.loc[ train002['Fare'] <= 7.91, 'Fare']  = 0
train002.loc[(train002['Fare'] > 7.91) & (train002['Fare'] <= 14.454), 'Fare'] = 1
train002.loc[(train002['Fare'] > 14.454) & (train002['Fare'] <= 31), 'Fare']   = 2
train002.loc[ train002['Fare'] > 31, 'Fare'] 	 = 3
train002['Fare'] = train002['Fare'].astype(int)
    
# Age:Create a New feature CategoricalAge and clear missing age random from age_avg - age_std, age_avg + age_std

age_avg = train002['Age'].mean()
age_std = train002['Age'].std()
age_null_count = train002['Age'].isnull().sum()
age_null_random_list = np.random.randint(age_avg - age_std, age_avg + age_std, size=age_null_count)
train002['Age'][np.isnan(train002['Age'])] = age_null_random_list
train002['Age'] = train002['Age'].astype(int)
train002['CategoricalAge'] = pd.cut(train002['Age'], 5)

train002.loc[ train002['Age'] <= 16, 'Age'] = 0
train002.loc[(train002['Age'] > 16) & (train002['Age'] <= 32), 'Age'] = 1
train002.loc[(train002['Age'] > 32) & (train002['Age'] <= 48), 'Age'] = 2
train002.loc[(train002['Age'] > 48) & (train002['Age'] <= 64), 'Age'] = 3
train002.loc[ train002['Age'] > 64, 'Age'] = 4 


# Sex
train002['Sex'] = train002['Sex'].map( {'female': 0, 'male': 1} ).astype(int)



#title
train002['Title'] = train002.Name.str.extract(' ([A-Za-z]+)\.', expand=False)

train002['Title'] = train002['Title'].replace(['Lady', 'Countess','Capt', 'Col',\
 	'Don', 'Dr', 'Major', 'Rev', 'Sir', 'Jonkheer', 'Dona'], 'Rare')

train002['Title'] = train002['Title'].replace('Mlle', 'Miss')
train002['Title'] = train002['Title'].replace('Ms', 'Miss')
train002['Title'] = train002['Title'].replace('Mme', 'Mrs')

title_mapping = {"Mr": 1, "Miss": 2, "Mrs": 3, "Master": 4, "Rare": 5}
train002['Title'] = train002['Title'].map(title_mapping)
train002['Title'] = train002['Title'].fillna(0)


# QC  
train002["CategoricalAge"].value_counts(dropna=0)
train002["Title"].value_counts(dropna=0)
train002["CategoricalAge"].value_counts(dropna=0)
train002["Embarked"].value_counts(dropna=0)
train002["Fare"].value_counts(dropna=0)


# drop var
drop_elements = ['PassengerId', 'Name', 'Ticket', 'Cabin', 'SibSp','CategoricalAge', 'CategoricalFare']
train002 = train002.drop(drop_elements, axis = 1)


#QC
train002.info()
train002.describe()
train002.head(3)




# PLot 2 
#Pearson Correlation Heatmap
colormap = plt.cm.RdBu
plt.figure(figsize=(14,12))
plt.title('Pearson Correlation of Features', y=1.05, size=15)
sns.heatmap(train002.astype(float).corr(),linewidths=0.1,vmax=1.0, 
            square=True, cmap=colormap, linecolor='white', annot=True)

#Pairplots
g = sns.pairplot(train002[[u'Survived', u'Pclass', u'Sex', u'Age', u'Parch', u'Fare', u'Embarked',
       u'FamilySize']], hue='Survived', palette = 'seismic',size=1.2,diag_kind = 'kde',diag_kws=dict(shade=True),plot_kws=dict(s=10) )

#g.set(xticklabels=[])

##############################################

###################   Model #######################
# Splitting up the Training Data
from sklearn.model_selection import train_test_split

X_all = train002.drop(['Survived'], axis=1)
y_all = train002['Survived']

num_test = 0.20
X_train, X_test, y_train, y_test = train_test_split(X_all, y_all, test_size=num_test, random_state=23,stratify=y_all)

# Logistic Regression
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_score
from sklearn.metrics import roc_auc_score
cols = (X_all.columns.values)
cols
clf_log = LogisticRegression()
clf_log = clf_log.fit(X_train,y_train)
score_log = cross_val_score(clf_log, X_train,y_train, cv=5).mean()
score_log2 = cross_val_score(clf_log, X_test, y_test, cv=5).mean()
print(score_log)
print(score_log2)


# ROC
# Import necessary modules
from sklearn.metrics import roc_curve

# Compute predicted probabilities: y_pred_prob
y_pred_prob = clf_log.predict_proba(X_train)[:,1]

# Generate ROC curve values: fpr, tpr, thresholds
fpr, tpr, thresholds = roc_curve(y_train, y_pred_prob)

# Plot ROC curve
plt.plot([0, 1], [0, 1], 'k--')
plt.plot(fpr, tpr)
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('ROC Curve')
plt.show()

print("AUC: {}".format(roc_auc_score(y_train, y_pred_prob)))


#K Nearest Neighbours:

from sklearn.neighbors import KNeighborsClassifier
clf_knn = KNeighborsClassifier(
    n_neighbors=10,
    weights='distance'
    )
clf_knn = clf_knn.fit(X_train,y_train)
score_knn = cross_val_score(clf_knn, X_train, y_train, cv=5).mean()
score_knn2 = cross_val_score(clf_knn, X_test, y_test, cv=5).mean()
print(score_knn)
print(score_knn2)

####
# Setup arrays to store train and test accuracies
neighbors = np.arange(1, 15)
train_accuracy = np.empty(len(neighbors))
test_accuracy = np.empty(len(neighbors))

# Loop over different values of k
for i, k in enumerate(neighbors):
    # Setup a k-NN Classifier with k neighbors: knn
    knn = KNeighborsClassifier(n_neighbors=k)
    # Fit the classifier to the training data
    knn.fit(X_train, y_train)    
    #Compute accuracy on the training set
    train_accuracy[i] = knn.score(X_train, y_train)
    #Compute accuracy on the testing set
    test_accuracy[i] = knn.score(X_test, y_test)

# Generate plot
sns.tsplot(data=train_accuracy)
sns.tsplot(data=test_accuracy)



#Support Vector Machine:
from sklearn import svm
clf_svm = svm.SVC(
    class_weight='balanced'
    )
clf_svm.fit(X_train, y_train)
score_svm = cross_val_score(clf_svm, X_train, y_train, cv=5).mean()
score_svm2 = cross_val_score(clf_svm, X_test, y_test, cv=5).mean()
print(score_svm)
print(score_svm2)

#Naive Bayes
from sklearn.naive_bayes import GaussianNB
clf_bay = GaussianNB()
clf_bay.fit(X_train,y_train)
score_bay = cross_val_score(clf_bay, X_train,y_train, cv=5).mean()
score_bay2 = cross_val_score(clf_bay, X_test,y_test, cv=5).mean()
print(score_bay)
print(score_bay2)


#Bagging with K Nearest Neighbours
from sklearn.ensemble import BaggingClassifier

bagging = BaggingClassifier(
    KNeighborsClassifier(
        n_neighbors=2,
        weights='distance'
        ),
    oob_score=True,
    max_samples=0.5,
    max_features=1.0
    )
clf_bag = bagging.fit(X_train,y_train)
score_bag = clf_bag.oob_score_
print(score_bag)


#Decision Tree
from sklearn import tree
clf_tree = tree.DecisionTreeClassifier(
    #max_depth=3,\
    class_weight="balanced",\
    min_weight_fraction_leaf=0.01\
    )
clf_tree = clf_tree.fit(X_train,y_train)
score_tree = cross_val_score(clf_tree, X_train, y_train, cv=5).mean()
score_tree2 = cross_val_score(clf_tree, X_test, y_test, cv=5).mean()
print(score_tree)
print(score_tree2)


#Random Forest
from sklearn.ensemble import RandomForestClassifier
clf_rf = RandomForestClassifier(
    n_estimators=1000, \
    max_depth=None, \
    min_samples_split=10 \
    #class_weight="balanced", \
    #min_weight_fraction_leaf=0.02 \
    )
clf_rf = clf_rf.fit(X_train,y_train)
score_rf = cross_val_score(clf_rf, X_train, y_train, cv=5).mean()
score_rf2 = cross_val_score(clf_rf, X_test, y_test, cv=5).mean()
print(score_rf)
print(score_rf2)


#Gradient Boosting:
from sklearn.ensemble import GradientBoostingClassifier
import warnings
warnings.filterwarnings("ignore")

clf_gb = GradientBoostingClassifier(
            #loss='exponential',
            n_estimators=1000,
            learning_rate=0.1,
            max_depth=3,
            subsample=0.5,
            random_state=0).fit(X_train, y_train)
clf_gb.fit(X_train,y_train)
score_gb = cross_val_score(clf_gb, X_train, y_train, cv=5).mean()
score_gb2 = cross_val_score(clf_gb, X_test, y_test, cv=5).mean()
print(score_gb)
print(score_gb2)


#Ada Boost:
from sklearn.ensemble import AdaBoostClassifier
clf_ada = AdaBoostClassifier(n_estimators=400, learning_rate=0.1)
clf_ada.fit(X_train,y_train)
score_ada = cross_val_score(clf_ada, X_train, y_train, cv=5).mean()
score_ada2 = cross_val_score(clf_ada, X_test, y_test, cv=5).mean()
print(score_ada)
print(score_ada2)

#eXtreme Gradient Boosting - XGBoost
import xgboost as xgb

clf_xgb = xgb.XGBClassifier(
    max_depth=2,
    n_estimators=500,
    subsample=0.5,
    learning_rate=0.1
    )
clf_xgb.fit(X_train,y_train)

score_xgb = cross_val_score(clf_xgb, X_train, y_train, cv=5).mean()
score_xgb2 = cross_val_score(clf_xgb, X_test, y_test, cv=5).mean()
print(score_xgb)
print(score_xgb2)



##############  final model with all tran data ######################
###########  import  data ####################################
test000=pd.read_csv('test.csv')
train000=pd.read_csv('train.csv')
gender_submission=pd.read_csv('gender_submission.csv')

train001=train000
test001=test000
################################################################
full_data = [train001, test001]

# clear and new features 

# Name_length
for data in full_data:
    data['Name_length'] = data['Name'].apply(len)
   
#Has_Cabin
    data['Has_Cabin'] = data["Cabin"].apply(lambda x: 0 if type(x) == float else 1)

# Embarked
    data["Embarked"] = data["Embarked"].fillna("S")
    print(data['Embarked'].value_counts(dropna=0))
    data['Embarked'] = data['Embarked'].map( {'S': 0, 'C': 1, 'Q': 2} ).astype(int)
# Create new feature FamilySize as a combination of SibSp and Parch
    data['FamilySize'] = data['SibSp'] + data['Parch'] + 1

# Create new feature IsAlone from FamilySize
    data['IsAlone'] = 0
    data.loc[data['FamilySize'] == 1, 'IsAlone'] = 1

# Fare:Remove all NULLS in the Fare column and create a new feature CategoricalFare

    data['Fare'] = data['Fare'].fillna(data['Fare'].median())
    data['CategoricalFare'] = pd.qcut(data['Fare'], 4)

    data.loc[ data['Fare'] <= 7.91, 'Fare']  = 0
    data.loc[(data['Fare'] > 7.91) & (data['Fare'] <= 14.454), 'Fare'] = 1
    data.loc[(data['Fare'] > 14.454) & (data['Fare'] <= 31), 'Fare']   = 2
    data.loc[ data['Fare'] > 31, 'Fare'] 	 = 3
    data['Fare'] = data['Fare'].astype(int)
    
# Age:Create a New feature CategoricalAge and clear missing age random from age_avg - age_std, age_avg + age_std

    age_avg = data['Age'].mean()
    age_std = data['Age'].std()
    age_null_count = data['Age'].isnull().sum()
    age_null_random_list = np.random.randint(age_avg - age_std, age_avg + age_std, size=age_null_count)
    data['Age'][np.isnan(data['Age'])] = age_null_random_list
    data['Age'] = data['Age'].astype(int)
    data['CategoricalAge'] = pd.cut(data['Age'], 5)

    data.loc[ data['Age'] <= 16, 'Age'] = 0
    data.loc[(data['Age'] > 16) & (data['Age'] <= 32), 'Age'] = 1
    data.loc[(data['Age'] > 32) & (data['Age'] <= 48), 'Age'] = 2
    data.loc[(data['Age'] > 48) & (data['Age'] <= 64), 'Age'] = 3
    data.loc[ data['Age'] > 64, 'Age'] = 4 


# Sex
    data['Sex'] = data['Sex'].map( {'female': 0, 'male': 1} ).astype(int)



#title
    data['Title'] = data.Name.str.extract(' ([A-Za-z]+)\.', expand=False)

    data['Title'] = data['Title'].replace(['Lady', 'Countess','Capt', 'Col','Don', 'Dr', 'Major', 'Rev', 'Sir', 'Jonkheer', 'Dona'], 'Rare')

    data['Title'] = data['Title'].replace('Mlle', 'Miss')
    data['Title'] = data['Title'].replace('Ms', 'Miss')
    data['Title'] = data['Title'].replace('Mme', 'Mrs')

    title_mapping = {"Mr": 1, "Miss": 2, "Mrs": 3, "Master": 4, "Rare": 5}
    data['Title'] = data['Title'].map(title_mapping)
    data['Title'] = data['Title'].fillna(0)


# drop var

drop_elements = ['PassengerId', 'Name', 'Ticket', 'Cabin', 'SibSp','CategoricalAge', 'CategoricalFare']

train001 = train001.drop(drop_elements, axis = 1)
test001 = test001.drop(drop_elements, axis = 1)

#QC
train001.info()
test001.info()

X_train_all=train001.drop(['Survived'], axis=1)
y_train_all=train001['Survived']


#Ada Boost:
from sklearn.ensemble import AdaBoostClassifier
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import roc_curve
clf_ada = AdaBoostClassifier(n_estimators=400, learning_rate=0.1)
clf_ada.fit(X_train_all,y_train_all)
y_pred = clf_ada.predict(X_train_all)
score_ada = cross_val_score(clf_ada, X_train_all, y_train_all, cv=5).mean()
print(score_ada) #0.823819636022
print("Mean score = %.3f, Std deviation = %.3f"%(np.mean(score_ada),np.std(score_ada)))

#confusion matrix
# Generate the confusion matrix and classification report
print(confusion_matrix(y_train_all, y_pred))
print(classification_report(y_train_all, y_pred))
1-y_train_all.sum()/y_train_all.count()


#Predict the Actual Test Data

submit = pd.DataFrame({'PassengerId' : test000.loc[:,'PassengerId'],'Survived': y_pred.T})

submit.to_csv("submit.csv", index=False)













