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


    with open(ppj("OUT_EMPIRICAL", "empirical.pickle"), "rb") as in_file:
        accuracy_rate = pickle.load(in_file)

    with open(ppj("OUT_TABLES","table_empirical.tex"), 'w') as tex_file:

        # Top of table.
        tex_file.write('\\begin{tabular}{l r r r }\n\\toprule\n')
            
        # Header row.   
        tex_file.write('\\textbf{} & \\textbf{(Ichimura)} & \\textbf{(KS)} & \\textbf{(Log)}')
        tex_file.write('\\tabularnewline\\midrule\n')

        names = ['ichimura','KS','log']
        rate=[]
        for n in names:
            rate.append(accuracy_rate[n])
        tex_file.write(" %s  & %.3f & %.3f& %.3f  \\tabularnewline\n" %('accuracy rate',rate[0],rate[1], rate[2] ))
                    
        # Bottom of table.
        tex_file.write('\\bottomrule\n\\end{tabular}\n')
