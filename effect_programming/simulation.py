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
from ichimura import ichimura
from KS import KS
from data_trim import data_trim

if __name__ == "__main__":
    model = json.load(open(ppj("IN_MODEL_SPECS", "baseline.json"), encoding="utf-8"))

sample_size = model["sample_size"]
h = model["bandwidth"]
grid_start = model["grid_start"]
grid_end = model["grid_end"]

beta_hat_ichimura={}
beta_hat_log={}
beta_hat_KS={}


for n in sample_size:
    simulation_data = np.loadtxt(ppj("OUT_DATA", "simulation_data_sample_size_{}.csv".format(n)), delimiter=",")
    trial = simulation_data.shape[0]
    beta_hat_log[n]=np.zeros(trial)
    beta_hat_ichimura[n]=np.zeros(trial)
    beta_hat_KS[n]=np.zeros(trial)

    for i in range (trial):
        x = simulation_data[i-1][:2]
        y = simulation_data[i-1][2]
        log = LogisticRegression().fit(x,y)
        log_coef=log.coef_
        beta_hat_log[n][i]=log_coef[0,1]/log_coef[0,0]
        beta_hat_ichimura[n][i]=ichimura(x,y,h,grid_start,grid_end)
        beta_hat_KS[n][i]=KS(x,y,h,grid_start,grid_end)


    plt.figure()
    hist(beta_hat_log[n],bins=5)
    savefig('beta_hat_log_{}.png'.format(n))
    plt.figure()
    hist(beta_hat_ichimura[n],bins=5)
    savefig('beta_hat_ichimura_{}.png'.format(n))
    plt.figure()
    hist(beta_hat_KS[n],bins=5)
    savefig('beta_hat_KS_{}.png'.format(n))
