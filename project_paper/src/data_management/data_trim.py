""" Definition of a trimming function that excludes observations whose x 
variables have a relatively low density.
"""

import numpy as np

def normal_kde(u,h):
    res = (1/2)*(3-u**2)*((1/np.sqrt(2 *np.pi)) * np.exp(-0.5 * ((u/h)**2)))
    return res
    
def data_trim(X,y,h,grid_start,grid_end):
    grid=np.arange(grid_start, grid_end, 0.1)
    for beta in grid:
        beta_vec=[1,beta]
        nrow=X.shape[0]
        i=0
        while i <= nrow-1:
            u_temp = np.subtract(X,np.dot(np.ones((1,nrow)).T,X[[i]]))
            argument = np.delete(u_temp,i,0)
            u = np.dot(argument, beta_vec)      
            kde = normal_kde(u,h)
            if np.sum(kde)<np.finfo(float).eps:
                X=np.delete(X,i,0)
                y=np.delete(y,i,0)
                nrow = nrow-1
            else:
                i=i+1
    return X,y
    
