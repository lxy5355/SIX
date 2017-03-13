"""Testing of the data trimming function for Klein and Spady's (1993) and 
Ichimura's (1993) model.

"""

import numpy as np
from nose.tools import *
from numpy.testing.utils import assert_array_almost_equal
from src.data_management.data_trim import normal_kde, data_trim

def test_normal_ke():
    """Test the function for the normal kernel density estimator by comparing 
    actual and desired result.
    
    """
    
    h=0.5
    u=0.0000000001
    assert_almost_equal(normal_kde(u,h), 0.598413420602)   

def test_data_trim_X():
    """Test the data trimming function. As this function returns two objects,
    here we test just the first, i.e., X. 
    
    """
    
    grid_start=-3
    grid_end=2
    X=np.array([
        [[ -2.04707659e-01,   6.98766888e-02]],
         [[  4.78943338e-01,   2.46674110e-01]],
         [[ -5.19438715e-01,  -1.18616011e-02]],
         [[ -5.55730304e-01,   1.00481159e+00]],
         [[  1.39340583e+00,  -9.19261558e-01]]
        ])
    Y=np.array([1, 1, 0, 0, 1])
    h=0.1
    
    np.testing.assert_allclose(data_trim(X, Y, h, grid_start, grid_end)[0], np.array([[[-0.204708,  0.069877]],[[-0.519439, -0.011862]]]), rtol=1e-04)

def test_data_trim_Y():
    """Test the data trimming function. As this function returns two objects,
    here we test just the second, i.e., Y. 
    
    """
    grid_start=-3
    grid_end=2
    X=np.array([
        [[ -2.04707659e-01,   6.98766888e-02]],
         [[  4.78943338e-01,   2.46674110e-01]],
         [[ -5.19438715e-01,  -1.18616011e-02]],
         [[ -5.55730304e-01,   1.00481159e+00]],
         [[  1.39340583e+00,  -9.19261558e-01]]
        ])
    Y=np.array([1, 1, 0, 0, 1])
    h=0.1
    
    np.testing.assert_allclose(data_trim(X, Y, h, grid_start, grid_end)[1], np.array([1, 0]), rtol=1e-04)

if __name__ == '__main__':
    from nose.core import runmodule
    runmodule()