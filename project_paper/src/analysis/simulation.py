# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 13:04:15 2017

@author: lxy53
"""
import sys
import json
import numpy as np
import pickle

from bld.project_paths import project_paths_join as ppj
from sklearn.linear_model import LogisticRegression
from src.model_code.ichimura import ichimura
from src.model_code.KS import KS

if __name__ == "__main__":
    model_name = sys.argv[1]
    model = json.load(open(ppj("IN_MODEL_SPECS", "sample_size_{}.json".format(model_name)), encoding="utf-8"))

sample_size = model["sample_size"]
h = model["bandwidth"]
grid_start = model["grid_start"]
grid_end = model["grid_end"]
trial = model["trial"]

beta_hat = {}
beta_hat['ichimura']={}
beta_hat['KS']={}
beta_hat['log']={}

x1 = np.loadtxt(ppj("OUT_DATA", "x1_sample_size_{}.csv".format(model_name)), delimiter=",")
x2 = np.loadtxt(ppj("OUT_DATA", "x2_sample_size_{}.csv".format(model_name)), delimiter=",")
y = np.loadtxt(ppj("OUT_DATA", "y_sample_size_{}.csv".format(model_name)), delimiter=",")

beta_hat['ichimura'][model_name]=np.zeros(trial)
beta_hat['KS'][model_name]=np.zeros(trial)
beta_hat['log'][model_name]=np.zeros(trial)
beta_true = model["beta_true"]

y=np.array(y,ndmin=2)
y=y.T
x1=np.array(x1,ndmin=2)
x2=np.array(x2,ndmin=2)

x=np.concatenate((x1,x2),axis=0)
x=np.transpose(x)
print(x.shape)

for i in range (trial):

    beta_hat['ichimura'][model_name][i]=ichimura(x,y,h,grid_start,grid_end)
    
    beta_hat['KS'][model_name][i]=KS(x,y,h,grid_start,grid_end)

    log = LogisticRegression().fit(x,y)
    log_coef=log.coef_
    beta_hat['log'][model_name][i]=log_coef[0,1]/log_coef[0,0]


with open(ppj("OUT_ANALYSIS", "simulation_{}.pickle".format(model_name)), "wb") as out_file:
    pickle.dump(beta_hat, out_file)
