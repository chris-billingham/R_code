a=1
b=2

import sys
print (sys.version)

#in command line:
#conda version:conda --v
#anaconda version:conda info

#update conda :conda update conda
#update anaconda :conda update anaconda

import os
os.chdir("C:\\Users\\User\\Desktop\\Mission\\R\\R_code\\Get_Python\\Book")

import os 
print(os.getcwd())


import pandas as pd
df_csv = pd.read_csv('zipcode.csv')
print(df_csv.head())



