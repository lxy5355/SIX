"""Draw simulated samples from two uncorrelated uniform variables
(locations in two dimensions) for two types of agents and store
them in a 3-dimensional NumPy array.

*Note:* In principle, one would read the number of dimensions etc.
from the "IN_MODEL_SPECS" file, this is to demonstrate the most basic
use of *run_py_script* only.

"""
import sys
import json
import numpy as np

from bld.project_paths import project_paths_join as ppj
from data_trim import data_trim

np.random.seed(12345)

if __name__ == "__main__":
    model_name = sys.argv[1]
    model = json.load(open(ppj("IN_MODEL_SPECS", "sample_size_{}.json".format(model_name)), encoding="utf-8"))

    sample_size = model["sample_size"]
    trial = model["trial"]
    beta_true = model["beta_true"]
    h = model["bandwidth"]
    grid_start = model["grid_start"]
    grid_end = model["grid_end"]

    for i in range (trial):
        x1=np.random.randn(sample_size, 1) 
        x2=np.random.randn(sample_size, 1) 
        e=np.random.randn(sample_size, 1)
        y=np.ones(sample_size)
        x=np.concatenate((x1,x2),axis=1)
        for j in range(sample_size):
            y[j]=(np.dot(x[j],beta_true) - e[j] > 0)*1
###problem here. need to find a way for it to depend on the trial!!
        x,y=data_trim(x,y,h,grid_start,grid_end)
        x1 = np.array(x[:,0],ndmin=2)
        x2 = np.array(x[:,1],ndmin=2)
        y = np.array(y,ndmin=2)

        
        x1.tofile(ppj("OUT_DATA","x1_sample_size_{}.csv".format(model_name)), sep=",")
        x2.tofile(ppj("OUT_DATA","x2_sample_size_{}.csv".format(model_name)), sep=",")
        y.tofile(ppj("OUT_DATA","y_sample_size_{}.csv".format(model_name)), sep=",")
           
