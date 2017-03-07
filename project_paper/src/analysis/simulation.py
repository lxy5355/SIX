# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 13:04:15 2017

@author: lxy53
"""
import json
import numpy as np
import matplotlib.pyplot as plt

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

beta_hat = {}
beta_hat['ichimura']={}
beta_hat['KS']={}
beta_hat['log']={}

simulation_data = np.loadtxt(ppj("OUT_DATA", "simulation_data_sample_size_{}.csv".format(model_name)), delimiter=",")
trial = simulation_data.shape[0]
beta_hat['ichimura'][model_name]=np.zeros(trial)
beta_hat['KS'][model_name]=np.zeros(trial)
beta_hat['log'][model_name]=np.zeros(trial)

for i in range (trial):
    x = simulation_data[:2]
    y = simulation_data[2]

    beta_hat['ichimura'][model_name][i]=ichimura(x,y,h,grid_start,grid_end)
    
    beta_hat['KS'][model_name][i]=KS(x,y,h,grid_start,grid_end)

    log = LogisticRegression().fit(x,y)
    log_coef=log.coef_
    beta_hat['log'][model_name][i]=log_coef[0,1]/log_coef[0,0]

with open(ppj("OUT_ANALYSIS", "simulation_{}.pickle".format(model_name)), "wb") as out_file:
    pickle.dump(beta_hat, out_file)

plt.figure()
hist(beta_hat_log[n],bins=5)
savefig('beta_hat_log_{}.png'.format(n))
plt.figure()
hist(beta_hat_ichimura[n],bins=5)
savefig('beta_hat_ichimura_{}.png'.format(n))
plt.figure()
hist(beta_hat_KS[n],bins=5)
savefig('beta_hat_KS_{}.png'.format(n))
