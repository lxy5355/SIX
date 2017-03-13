""" Definition of the nonlinear least squares minimization problem from 
Klein and Spady (1993).

"""

import numpy as np
from scipy import optimize

def normal_kde(u,h):
    """Calculation of a fourth order kernel."""
    
    res = (1/2)*(3-u**2)*((1/np.sqrt(2 *np.pi)) * np.exp(-0.5 * ((u/h)**2)))
    return res

def g_i_restrained(beta_hat,X,y,h):
    """Calculation of the g function for the KS model that sets any estimate 
    smaller than the lower bound of square root of machine double epsilon to 
    this value. 
    
    """
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
    return g_i

def log_likelihood(beta_hat, *params):
    """Calculates minus ones multiplied by the the maximum likelihood objective
    function.
    
    """
    
    X,y,h = params
    L = np.dot(np.log(g_i_restrained(beta_hat,X,y,h)),y) + np.dot(np.log(1-g_i_restrained(beta_hat,X,y,h)),(1-y)) 
    return -L
    
def KS(X,y,h,grid_start,grid_end):
    """Solves the maximum likelihood problem from Klein and Spady's model.
    
    As the first component of beta is set to one throughout the study, we are
    only interested in the second component.
    
    """
    
    params=(X,y,h)
    ranges=(slice(grid_start, grid_end, 0.1), slice(grid_start, grid_end, 0.1))
    opt_temp=optimize.brute(log_likelihood, ranges, params,finish=optimize.fmin)
    opt=opt_temp[1]/opt_temp[0]
    return opt