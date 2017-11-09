
# F4  run select

%reset -f   # remove all vairable

#################  01-intro
#################  02-Package
#################  03-Data_import
#################  04-Data_EDA_Visualization
#################  05-Data_Cleaning
#################  06-Data_Modeling
#################  07-Data_Validation_and_scoring
#################  08-Data_output


# get wd 
import os
os.getcwd()
#set wd 
os.chdir('C:/Users/User/Desktop/Mission/R/R_code/Get_Python/Book')




#################  03-Data_import

#train_url = "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv"
#test_url = "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"

# csv
#import 
import pandas as pd

titanic_train_001 = pd.read_csv('train.csv')

#export 
titanic_train_001.to_csv('train_out.csv')
# excel

#import 
execl001 = pd.read_excel('df.xlsx')

#export 
execl001.to_csv('df_out.xlsx')

#################  04-Data_EDA_Visualization

titanic_train_001.head()

titanic_train_001.head(10)


titanic_train_001.tail()

titanic_train_001.shape

titanic_train_001.columns

titanic_train_001.info()
titanic_train_001.describe()

titanic_train_001['Pclass'].value_counts(dropna=False)

######################      Matplotlib 

import seaborn.apionly as sns
iris = sns.load_dataset('iris')
iris.head()


import matplotlib.pyplot as plt
plt.plot(year, physical_sciences, color='blue')

# line
# scatter
# bar
# histogram
# box plot


###################         seaborn

###################         bokeh
# Import figure from bokeh.plotting
from bokeh.plotting import figure

# Import output_file and show from bokeh.io
from bokeh.io import output_file, show

# Create the figure: p
p = figure(x_axis_label='fertility (children per woman)', y_axis_label='female_literacy (% population)')

# Add a circle glyph to the figure p
p.circle(fertility, female_literacy)

# Call the output_file() function and specify the name of the file
output_file('fert_lit.html')

# Display the plot
show(p)





#################  05-Data_Cleaning

titanic_train_001



