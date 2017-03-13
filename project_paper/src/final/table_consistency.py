# """ Plot hstograms for the estimator for three models defined in analysis.

# """
import sys
import pickle
import json
import matplotlib.pyplot as plt
import numpy as np

from bld.project_paths import project_paths_join as ppj



# if __name__ == "__main__":
#     model_name = sys.argv[1]

#     with open(ppj("OUT_ANALYSIS", "bias.pickle"), "rb") as in_file:
#         bias = pickle.load(in_file)


#     with open(ppj("OUT_ANALYSIS", "RMSE.pickle"), "rb") as in_file:
#         RMSE = pickle.load(in_file)


#     plt.figure()
#     plt.hist(bias['log']['3'])
#     plt.savefig(ppj("OUT_FIGURES", 'b.png'))
            
#     #table_row = '{par} & {val_100:.3f} & {val_1000:.3f}& {val_10000:.3f}\\tabularnewline\n' 

#     with open(ppj("OUT_TABLES","table_bias.tex"), 'w') as tex_file:

#         tex_file.write("{}".format(bias['ichimura']['3']))

#     # # # Top of table.
#     #     tex_file.write('\\begin{tabular}{l r r r r}\n\\toprule\n')
            
#     #     # Header row.    
        
#     #     tex_file.write('\\textbf{(Estimator)} & \\textbf{(bias)} & \\textbf{(RMSE)} & \\textbf{(bias)}& \\textbf{(RMSE)}')
#     #     tex_file.write('\\tabularnewline\\midrule\n')

#     #     names = ['ichimura','KS','log']
#     #     for n, acro in zip(names, "Ichi, KS, Logit".split(", ")):
#     #         b = []
#     #         r = []
#     #         for i in model_name:
#     #             b.append(bias[n][i])
#     #             r.append(RMSE[n][i])
#     #         tex_file.write("{} & {} & {} & {} &{} \\tabularnewline\n".format(acro,b[0],r[0], b[1],r[1] ))
        
    
            
#     #     # Bottom of table.
#     #     tex_file.write('\\bottomrule\n\\end{tabular}\n')


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
