"""Draw simulated samples from two uncorrelated uniform variables
(locations in two dimensions) for two types of agents and store
them in a 3-dimensional NumPy array.

*Note:* In principle, one would read the number of dimensions etc.
from the "IN_MODEL_SPECS" file, this is to demonstrate the most basic
use of *run_py_script* only.

"""

import numpy as np
from bld.project_paths import project_paths_join as ppj


np.random.seed(12345)
if __name__ == "__main__":
    model = json.load(open(ppj("IN_MODEL_SPECS", "baseline.json"), encoding="utf-8"))

sample_size = model["sample_size"]
trial = model["trial"]
beta_true = model["beta_true"]
h = model["bandwidth"]
grid_start = model["grid_start"]
grid_end = model["grid_end"]

for n in sample_size:
	sample = np.zeros((trial,n,2))
    for i in range (trial):
        x1=np.random.randn(n, 1) 
        x2=np.random.randn(n, 1) 
        e=np.random.randn(n, 1)
        x=np.concatenate((x1,x2),axis=1)
        y=(np.dot(x,beta_true)>1)*1
        x,y=data_trim(x,y,h,grid_start,grid_end)
        x1 = np.array(x[:,0],ndmin=2)
    	x2 = np.array(x[:,1],ndmin=2)
    	y = np.array(y,ndmin=2)
    	sample[i-1] = np.concatenate((x1,x2,y))
    sample.tofie(ppj("OUT_DATA","simulation_data_sample_size_{}.csv".format(n)), sep=",")
        
