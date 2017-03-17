"""Calculates the optimal values from the Monte Carlo simulation for beta hat 
for both Klein and Spady's (1993) and Ichimura's (1993) models. Additonally, it
compares these results with the pre-implemented logitstic's model.

"""
import sys
import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.cross_validation import train_test_split
from scipy.interpolate import interp1d
from bld.project_paths import project_paths_join as ppj

from sklearn.linear_model import LogisticRegression
from src.analysis.ichimura import ichimura
from src.analysis.KS import KS




if __name__ == "__main__":
    np.seed=123

    voice = pd.read_csv('voice.csv')

    y=(voice['label'].values=='male')*1
    x=voice[['median','Q25']].values

    scaler = StandardScaler()
    scaler.fit(x)


    x_train,x_test,y_train,y_test = train_test_split(x,y,test_size=0.3,random_state=42)

    b_ichimura=ichimura(x_train,y_train,.1,-1,1)
    b_KS=KS(x_train,y_train,.1,-1,1)
    log = LogisticRegression().fit(x,y)

    x_hat_ichimura=np.dot(x_train,[1,b_ichimura])
    x_hat_KS=np.dot(x_train,[1,b_KS])

    f=interp1d(x_hat_ichimura, y_train)
    g=interp1d(x_hat_KS,y_train)

    y_hat={}
    y_hat['ichimura']=f(np.dot(x_test,[1,b_ichimura]))>.5
    y_hat['KS']=g(np.dot(x_test,[1,b_KS]))>.5
    y_hat['log']=log.predict(x_test)


    accuracy={}
    for name in ['ichimura','KS','log']:
    accuracy[name]=sum((y_hat[name]-y_test)==0)/len(y_test)
    


    # Dump data to be used for tables and figures.
    with open(ppj("OUT_ANALYSIS", "empirical.pickle"), "wb") as out_file:
        pickle.dump(beta_hat, out_file)
