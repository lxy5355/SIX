""" Create table with values for bias and RMSE of beta hat for Klein and Spady's,
Iichimura's and logistic model.

"""

import sys
import pickle
import json
import matplotlib.pyplot as plt
import numpy as np

from bld.project_paths import project_paths_join as ppj

if __name__ == "__main__":

    model = json.load(open(ppj("IN_MODEL_SPECS", "model_3.json"), encoding="utf-8"))
    trial = model["trial"]
    beta_true = model["beta_true"][1]

    with open(ppj("OUT_ANALYSIS", "simulation_3.pickle"), "rb") as in_file:
        beta_hat_3 = pickle.load(in_file)

    with open(ppj("OUT_ANALYSIS", "simulation_4.pickle"), "rb") as in_file:
        beta_hat_4 = pickle.load(in_file)
 
    names = ['ichimura','KS','log']

    bias={}
    RMSE={}

    for n in names:
        bias[n]={}
        RMSE[n]={}

    for n in names:
        bias[n]['normal']=beta_hat_3[n].mean()-beta_true
        RMSE[n]['normal']=np.sqrt(np.sum(np.square(beta_hat_3[n]-beta_true))/trial)
        bias[n]['joint_normal']=beta_hat_4[n].mean()-beta_true
        RMSE[n]['joint_normal']=np.sqrt(np.sum(np.square(beta_hat_4[n]-beta_true))/trial)
  
    with open(ppj("OUT_TABLES","table_bias.tex"), 'w') as tex_file:

        # Top of table.
        tex_file.write('\\begin{tabular}{l r r r r}\n\\toprule\n')
            
        # Header row.   
        tex_file.write('\\textbf{} &\\multicolumn{2}{c}{ \\textbf{(normal)}}&\\multicolumn{2}{c}{\\textbf{(joint normal)}}') 
        tex_file.write('\\tabularnewline\\midrule\n')
        
        tex_file.write('\\textbf{(Estimator)} & \\textbf{(bias)} & \\textbf{(RMSE)} & \\textbf{(bias)}& \\textbf{(RMSE)}')
        tex_file.write('\\tabularnewline\\midrule\n')

        for n, acro in zip(names, "Ichi, KS, Logit".split(", ")):
            b = []
            r = []
            for i in["normal","joint_normal"]:
                b.append(bias[n][i])
                r.append(RMSE[n][i])
            tex_file.write(" %s  & %.2f & %.2f& %.2f &%.2f \\tabularnewline\n" %(acro,b[0],r[0], b[1],r[1] ))
                    
        # Bottom of table.
        tex_file.write('\\bottomrule\n\\end{tabular}\n')
