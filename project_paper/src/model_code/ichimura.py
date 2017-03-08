""" Definition of the nonlinear least squares minimization problem from 
Ichimura (1993).

"""


import numpy as np
from scipy import optimize

#define Gaussian fourth order kernel 
def normal_kde(u,h):
    res = (1/2)*(3-u**2)*((1/np.sqrt(2 *np.pi)) * np.exp(-0.5 * ((u/h)**2)))
    return res
    
#define leave one out estimator
def g_i(beta_hat,X,y,h):
    nrow=X.shape[0]
    g_i=np.empty(nrow)
    g_i.fill(np.nan)
    for i in range (nrow):
        u_temp = np.subtract(X,np.dot(np.ones((1,nrow)).T,X[[i]]))
        u = np.dot(np.delete(u_temp,i,0),beta_hat)      
        kde = normal_kde(u,h)
        estimate = np.dot(np.delete(y,i),kde) / np.sum(kde)
        g_i[i] = estimate
    return g_i

#define loss function 
def loss(beta_hat,*params):
    X,y,h=params
    loss=np.subtract(y,g_i(beta_hat,X,y,h))
    loss_sqr=np.dot(loss.T,loss)
    return loss_sqr
 
#minimize loss function  
def ichimura(X,y,h,grid_start, grid_end):
    params=(X,y,h)
    ranges=(slice(grid_start, grid_end, 0.1), slice(grid_start, grid_end, 0.1))
    opt_temp=optimize.brute(loss, ranges, params,finish=optimize.fmin)
    opt=opt_temp[1]/opt_temp[0]
    return opt
