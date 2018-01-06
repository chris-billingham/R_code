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
