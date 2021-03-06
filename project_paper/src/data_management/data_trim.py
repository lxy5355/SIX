""" Definition of a trimming function that excludes observations whose x 
variables have a relatively low density.

"""

import numpy as np

def normal_kde(u,h):
    """Calculation of a fourth order kernel. This should be changed to other kernels 
    in further studies that exmine optimal kernel selection for data trimming"""
    
    res = (1/2)*(3-u**2)*((1/np.sqrt(2 *np.pi)) * np.exp(-0.5 * ((u/h)**2)))
    return res
    
def data_trim(X,y,h,grid_start,grid_end):
    """Eliminates observations that have a low density of X, i.e., the density
    is smaller than np.finfo(float).eps. This is done by passing all possible values 
    of beta defined by the grid to the single index part of the model and apply the kernel. 
    All data points with smaller than np.finfo(float).eps kernel estimation results are removed from the dataset
    
    """
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

