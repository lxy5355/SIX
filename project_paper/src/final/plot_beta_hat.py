""" Plot hstograms for the estimator for three models defined in analysis.

"""
import sys
import pickle
import matplotlib.pyplot as plt

from bld.project_paths import project_paths_join as ppj


if __name__ == "__main__":
    model_name = sys.argv[1]

    with open(ppj("OUT_ANALYSIS", "simulation_{}.pickle".format(model_name)), "rb") as in_file:
        beta_hat = pickle.load(in_file)
                
    plt.figure()
    plt.hist(beta_hat['ichimura'][model_name],bins=10)
    plt.savefig(ppj("OUT_FIGURES", 'beta_hat_ichimura_{}.png'.format(model_name)))

    plt.figure()
    plt.hist(beta_hat['KS'][model_name],bins=10)
    plt.savefig(ppj("OUT_FIGURES", 'beta_hat_KS_{}.png'.format(model_name)))

    plt.figure()
    plt.hist(beta_hat['log'][model_name],bins=10)
    plt.savefig(ppj("OUT_FIGURES", 'beta_hat_log_{}.png'.format(model_name)))
