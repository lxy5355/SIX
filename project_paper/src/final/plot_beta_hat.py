# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 13:04:15 2017

@author: lxy53
"""

import pickle
import matplotlib.pyplot as plt

from bld.project_paths import project_paths_join as ppj


if __name__ == "__main__":
    model_name = sys.argv[1]

    with open(ppj("OUT_ANALYSIS", "simulation_{}.pickle".format(model_name)), "rb") as in_file:
        beta_hat = pickle.load(in_file)

    plt.figure()
    hist(beta_hat['ichimura'][model_name],bins=5)
    savefig(ppj("OUT_FIGURES", 'beta_hat_ichimura_{}.png'.format(model_name)))

    plt.figure()
    hist(beta_hat['KS'][model_name],bins=5)
    savefig(ppj("OUT_FIGURES", 'beta_hat_KS_{}.png'.format(model_name)))

    plt.figure()
    hist(beta_hat['log'][model_name],bins=5)
    savefig(ppj("OUT_FIGURES", 'beta_hat_log_{}.png'.format(model_name)))
