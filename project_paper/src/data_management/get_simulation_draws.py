"""Draw simulation data formed of two independent variables drawn from 
uncorrelated standard normal distributions, error term drawn from differently 
specified distributions and the dependent variable following a binary choice 
model. Each sample corresponds to one parameter specification in *model specs*.

This data set is trimmed according to theoretical and computational restrictions 
for Ichimura's and Klein and Spady's methods.

The trimmed data set is stored seperately for X and Y, both of which are 
dictionaries containing the trial number as keys and trimmed data arrays 
(2-dimentional and 1-dimentional respectively) as arguments. 

"""

import sys
import json
import numpy as np
import pickle

from bld.project_paths import project_paths_join as ppj
from data_trim import data_trim

np.random.seed(12345)

if __name__ == "__main__":
    model_name = sys.argv[1]
    model = json.load(open(ppj("IN_MODEL_SPECS", "model_{}.json".format(model_name)), encoding="utf-8"))

    sample_size = model["sample_size"]
    trial = model["trial"]
    beta_true = model["beta_true"]
    h = model["bandwidth"]
    grid_start = model["grid_start"]
    grid_end = model["grid_end"]

    e_mean_1=model["e"]["mean_1"]
    e_mean_2=model["e"]["mean_2"]
    e_sd_1=model["e"]["sd_1"]
    e_sd_2=model["e"]["sd_2"]
    e_weight=model["e"]["weight"]


    X={}
    Y={}
    
    for i in range (trial):
        X[i]=np.zeros((sample_size,2))
        Y[i]=np.zeros(sample_size)
        x1=np.random.randn(sample_size, 1) 
        x2=np.random.randn(sample_size, 1) 
        e1=e_mean_1+np.random.randn(sample_size, 1)*e_sd_1
        e2=e_mean_2+np.random.randn(sample_size, 1)*e_sd_2
        e=e_weight*e1+(1-e_weight)*e2
        x=np.concatenate((x1,x2),axis=1)
        # Set the dependent variable to be binary.
        y=(np.dot(x,beta_true)>e.T).T*1
        y=y.reshape((sample_size,))

        x,y=data_trim(x,y,h,grid_start,grid_end)
        X[i]=x
        Y[i]=y

    with open(ppj("OUT_DATA", "x_model_{}.pickle".format(model_name)), "wb") as out_file:
        pickle.dump(X, out_file)

    with open(ppj("OUT_DATA", "y_model_{}.pickle".format(model_name)), "wb") as out_file:
        pickle.dump(Y, out_file)

    