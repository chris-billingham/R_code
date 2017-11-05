
#https://www.youtube.com/watch?v=oYbVFhK_olY&list=PLQVvvaa0QuDfKTOs3Keq_kaG2P55YRn5v&index=43
#https://pythonprogramming.net/features-labels-machine-learning-tutorial/
#http://selfdrivingcars.mit.edu/resources/

#https://www.tensorflow.org/get_started/get_started

#Deep Learning   2017/11/05 P3


#delete all variable
#%reset 

#conda install tensorflow


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

import tensorflow as tf


############  TF test #################
hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
print(sess.run(hello))



###############     TF sample       ###################################

x1 = tf.constant(5)
x2 = tf.constant(6)

result = tf.multiply(x1,x2)
print(result)



# runs
with tf.Session() as sess:
    output = sess.run(result)
    print(output)

    
########################################################    
import sys
print (sys.version)
    
    
    
    






