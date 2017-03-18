""" Plot histograms for the estimator for three models defined in analysis.

"""
import sys
import pickle
import matplotlib.pyplot as plt
import numpy as np

from bld.project_paths import project_paths_join as ppj


if __name__ == "__main__":
    model_name = sys.argv[1]

    with open(ppj("OUT_ANALYSIS", "simulation_{}.pickle".format(model_name)), "rb") as in_file:
        beta_hat = pickle.load(in_file)
        
    bins = np.linspace(-5, 0, 50, endpoint=True)

    plt.figure()
    plt.hist(beta_hat['ichimura'], bins)
    plt.savefig(ppj("OUT_FIGURES", 'beta_hat_ichimura_{}.png'.format(model_name)))

    plt.figure()
    plt.hist(beta_hat['KS'], bins)
    plt.savefig(ppj("OUT_FIGURES", 'beta_hat_KS_{}.png'.format(model_name)))

    plt.figure()
    plt.hist(beta_hat['log'], bins)
    plt.savefig(ppj("OUT_FIGURES", 'beta_hat_log_{}.png'.format(model_name)))


