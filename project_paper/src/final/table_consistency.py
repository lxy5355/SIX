""" Create table that shows how the bias of beta hat changes with increasing
sample size for Klein and Spady's, Ichimura's and the logistic model.

"""

import pickle
import json

from bld.project_paths import project_paths_join as ppj





if __name__ == "__main__":

    model = json.load(open(ppj("IN_MODEL_SPECS", "model_2.json"), encoding="utf-8"))
    beta_true=model["beta_true"][1]

    model_name=['1','2','3']
    estimation = ['ichimura','KS','log']
    beta_hat={}

    for n in model_name:
        beta_hat[n]={}
        with open(ppj("OUT_ANALYSIS", "simulation_{}.pickle".format(n)), "rb") as in_file:
            beta_hat[n] = pickle.load(in_file)
    
     
    bias={}

    for n in model_name:
        bias[n]={}

    for n in model_name:
        for est in estimation:
             bias[n][est]=beta_hat[n][est].mean()-beta_true


    with open(ppj("OUT_TABLES","table_consistency.tex"), 'w') as tex_file:


        # # # Top of table.
        tex_file.write('\\begin{tabular}{l r r r }\n\\toprule\n')
            
        # Header row.   
        tex_file.write('\\textbf{} & \\textbf{(n=50)} & \\textbf{(n=150)} & \\textbf{(n=250)}')
        tex_file.write('\\tabularnewline\\midrule\n')

        for est, acro in zip(estimation, "Ichi, KS, Logit".split(", ")):
            b = []
            for n in model_name:
                b.append(bias[n][est])
            tex_file.write(" %s  & %.2f & %.2f& %.2f \\tabularnewline\n" %(acro,b[0],b[1], b[2] ))

        #Bottom of table.
        tex_file.write('\\bottomrule\n\\end{tabular}\n')
