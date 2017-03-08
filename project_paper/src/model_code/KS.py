# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 21:59:23 2017

@author: lxy53
"""

import numpy as np
from scipy import optimize

#define Gaussian fourth order kernel 
def normal_kde(u,h):
    res = (1/2)*(3-u**2)*((1/np.sqrt(2 *np.pi)) * np.exp(-0.5 * ((u/h)**2)))
    return res
    
#define log-likelihood loss function based on leave one out estimator, 
#values too close to 0 are replaced by machine epsilon to ensure no 0 inside the log funciton

def log_likelihood(beta_hat,*params):
    X,y,h=params
    nrow=X.shape[0]
    g_i=np.empty(nrow)
    g_i.fill(np.nan)
    
    for i in range (nrow):
        u_temp = np.subtract(X,np.dot(np.ones((1,nrow)).T,X[[i]]))
        u = np.dot(np.delete(u_temp,i,0),beta_hat)      
        kde = normal_kde(u,h)
        estimate = np.dot(np.delete(y,i),kde) / np.sum(kde)
        estimate = max (estimate, np.finfo(float).eps)
        estimate = min (estimate, 1-np.finfo(float).eps)
        g_i[i] = estimate
    L = np.dot(np.log(g_i),y) + np.dot(np.log(1-g_i),(1-y)) 
    return -L
    
def KS(X,y,h,grid_start,grid_end):
    params=(X,y,h)
    ranges=(slice(grid_start, grid_end, 0.1), slice(grid_start, grid_end, 0.1))
    opt_temp=optimize.brute(log_likelihood, ranges, params,finish=optimize.fmin)
    opt=opt_temp[1]/opt_temp[0]
    return opt

