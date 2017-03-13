"""Testing of functions from Klein and Spady's (1993) model.

"""

import numpy as np
from nose.tools import *
from numpy.testing.utils import assert_array_almost_equal
from src.analysis.KS import normal_kde, g_i_restrained, log_likelihood

def test_normal_ke():
    """Test the function for the normal kernel density estimator by comparing 
    actual and desired result.
    
    """
    h=0.5
    u=0.0000000001
    assert_almost_equal(normal_kde(u,h), 0.598413420602)   
    

def test_g_i_restrained():
    """Test the g function for the model by comparing actual and desired result.
    
    The allclose function is used in this particular case since the original 
    function returns an array.
    
    """
    
    beta=np.array([-3., -3.])
    X=np.array([
        [[ -2.04707659e-01,   6.98766888e-02]],
         [[  4.78943338e-01,   2.46674110e-01]],
         [[ -5.19438715e-01,  -1.18616011e-02]],
         [[ -5.55730304e-01,   1.00481159e+00]],
         [[  1.39340583e+00,  -9.19261558e-01]]
        ])
    Y=np.array([1, 1, 0, 0, 1])
    h=0.1
    np.testing.assert_allclose(g_i_restrained(beta,X,Y,h),
                        np.array([  2.220446e-16,
                                  9.975404e-01,
                                  1.000000e+00,
                                  1.000000e+00,
                                  4.713117e-13]),
                                  rtol=1e-07
                                                       )   
def test_log_likelihood():
    """Test the objective function of the model by comparing actual and desired
     result.
    
    The allclose function is used in this particular case since the original 
    function returns an array.
    
    """ 
        
    beta=np.array([-3., -3.])
    X=np.array([
        [[ -2.04707659e-01,   6.98766888e-02]],
         [[  4.78943338e-01,   2.46674110e-01]],
         [[ -5.19438715e-01,  -1.18616011e-02]],
         [[ -5.55730304e-01,   1.00481159e+00]],
         [[  1.39340583e+00,  -9.19261558e-01]]
        ])
    Y=np.array([1, 1, 0, 0, 1])
    h=0.1
                  
    np.testing.assert_allclose(log_likelihood(beta, X, Y, h), 136.51667958163955, rtol=1e-07)
    
if __name__ == '__main__':
    from nose.core import runmodule
    runmodule()