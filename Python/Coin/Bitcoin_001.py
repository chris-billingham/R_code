

import os 
print(os.getcwd())

os.chdir("C:\\Users\\tduan\\Desktop\\Mission\\R\\R_code\\Python\\Coin")





####################  bitcoin  price ################################

import requests

import pandas as pd
import json

r=requests.get("https://api.coindesk.com/v1/bpi/currentprice.json")

r.json()['bpi']['USD']['rate']

# 2017-01-30 to  2017-09-05
hist=requests.get('https://api.coindesk.com/v1/bpi/historical/close.json?start=2017-01-30&end=2017-09-05')

a=hist.json()['bpi']
a
b=pd.Series(a)
b
c=pd.Series.to_frame(b)
c['date'] = c.index
c.columns = ['price','date']
c

############################  bitcoin trend ###################################

# Import packages
#https://www.facebook.com/726282547396228/videos/1889229141101557/
#https://github.com/datacamp/datacamp_facebook_live_ny_resolution
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline
sns.set()

df = pd.read_csv('multiTimeline.csv', skiprows=1)
df.head()
df.info()
df.columns = ['Week', 'Bitcoin', 'Ethereum', 'Python']
df.head()

df.Week = pd.to_datetime(df.Week)
df.set_index('Week', inplace=True)

df.plot(figsize=(20,10), linewidth=5, fontsize=20)
plt.xlabel('Year', fontsize=20);
