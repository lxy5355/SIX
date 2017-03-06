# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 13:04:15 2017

@author: lxy53
"""
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LogisticRegression
from ichimura import ichimura
from KS import KS
from data_trim import data_trim

sample_size=[100,200]
trial=2
beta_true=[1,-2]
h=.1
grid_start=-3
grid_end=2

beta_hat_ichimura={}
beta_hat_log={}
beta_hat_KS={}
for n in sample_size:
    beta_hat_log[n]=np.zeros(trial)
    beta_hat_ichimura[n]=np.zeros(trial)
    beta_hat_KS[n]=np.zeros(trial)
    for i in range (trial):
        x1=np.random.randn(n, 1) 
        x2=np.random.randn(n, 1) 
        e=np.random.randn(n, 1)
        x=np.concatenate((x1,x2),axis=1)
        y=(np.dot(x,beta_true)>1)*1
        x,y=data_trim(x,y,h,grid_start,grid_end)
        log = LogisticRegression().fit(x,y)
        log_coef=log.coef_
        beta_hat_log[n][i]=log_coef[0,1]/log_coef[0,0]
        beta_hat_ichimura[n][i]=ichimura(x,y,h,grid_start,grid_end)
        beta_hat_KS[n][i]=KS(x,y,h,grid_start,grid_end)
    plt.figure()
    hist(beta_hat_log[n],bins=5)
    savefig('beta_hat_log_{}.png'.format(n))
    plt.figure()
    hist(beta_hat_ichimura[n],bins=5)
    savefig('beta_hat_ichimura_{}.png'.format(n))
    plt.figure()
    hist(beta_hat_KS[n],bins=5)
    savefig('beta_hat_KS_{}.png'.format(n))
