# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 13:04:15 2017

@author: lxy53
"""
import sys
import json
import numpy as np
import matplotlib.pyplot as plt
import pickle

from bld.project_paths import project_paths_join as ppj
from sklearn.linear_model import LogisticRegression
from src.model_code.ichimura import ichimura
from src.model_code.KS import KS



if __name__ == "__main__":
    model_name = sys.argv[1]
    model = json.load(open(ppj("IN_MODEL_SPECS", "model_{}.json".format(model_name)), encoding="utf-8"))

with open(ppj("OUT_DATA", "x_model_{}.pickle".format(model_name)), "rb") as in_file:
        X = pickle.load(in_file)

with open(ppj("OUT_DATA", "y_model_{}.pickle".format(model_name)), "rb") as in_file:
        Y = pickle.load(in_file)

sample_size = model["sample_size"]
h = model["bandwidth"]
grid_start = model["grid_start"]
grid_end = model["grid_end"]
trial = model["trial"]


beta_hat={}

beta_hat['ichimura']=np.zeros(trial)
beta_hat['KS']=np.zeros(trial)
beta_hat['log']=np.zeros(trial)



for i in range (trial):
    x=X[i]
    y=Y[i]
    beta_hat['ichimura'][i]=ichimura(x,y,h,grid_start,grid_end)
    beta_hat['KS'][i]=KS(x,y,h,grid_start,grid_end)

    log = LogisticRegression().fit(x,y)
    log_coef=log.coef_
    beta_hat['log'][i]=log_coef[0,1]/log_coef[0,0]

with open(ppj("OUT_ANALYSIS", "simulation_{}.pickle".format(model_name)), "wb") as out_file:
    pickle.dump(beta_hat, out_file)
