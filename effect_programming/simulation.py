# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 13:04:15 2017

@author: lxy53
"""
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LogisticRegression
from ichimura import ichimura

sample_size=[100,200]
trial=10
beta_true=[1,-2]
h=.1

beta_hat_ichimura={}
beta_hat_log={}
for n in sample_size:
    beta_hat_log[n]=np.zeros(trial)
    beta_hat_ichimura[n]=np.zeros(trial)
    for i in range (trial):
        x1=np.random.randn(n, 1) 
        x2=np.random.randn(n, 1) 
        e=np.random.randn(n, 1)
        x=np.concatenate((x1,x2),axis=1)
        y=(np.dot(x,beta_true)>1)*1
        log = LogisticRegression().fit(x,y)
        log_coef=log.coef_
        beta_hat_log[n][i]=log_coef[0,1]/log_coef[0,0]
        beta_hat_ichimura[n][i]=ichimura(x,y,h)
        
        
plt.subplot(3, 1, 1)	      
hist(beta_hat_log[100],bins=5)
plt.subplot(3, 1, 2)
hist(beta_hat_log[200],bins=5)
plt.subplot(3, 1, 3)
hist(beta_hat_ichimura[200],bins=5)