#https://www.youtube.com/playlist?list=PL998lXKj66MpNd0_XkEXwzTGPxY2jYM2d

#https://www.youtube.com/playlist?list=PLgJhDSE2ZLxYlhQx0UfVlnF1F7OWF-9rp

#https://www.youtube.com/playlist?list=PLE50-dh6JzC7X8VFX40yoIXnhctF2bR8F

import os
os.chdir("C:\\Users\\User\\Desktop\\Mission\\R\\R_code\\Datacamp")

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


df=pd.read_csv('battles.csv')
df.dtypes
df.head(6)
