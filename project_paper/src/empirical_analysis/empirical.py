"""Separate empirical data set into two parts. Use the training set 
to calculate estimators, respectively for Ichimura's, Klein and Spady's 
and the logistic model. Compare the accuracy of estimation with the testing 
set and save results for table.

"""
import sys
import pickle
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

    #import data
    voice=pd.read_csv(ppj("IN_EMPIRICAL", "voice.csv"))

    #convert y to binary values 1, 0
    y=(voice['label'].values=='male')*1

    #select independent x variables used in estimation from the dataset
    x=voice[['median','Q25']].values

    #scale x variables to betwen 0 and 1
    scaler = StandardScaler()
    scaler.fit(x)

    #split dataset to training sample and test sample based on a ration of 0.3
    x_train,x_test,y_train,y_test = train_test_split(x,y,test_size=0.3,random_state=42)

    #estimation using ichimura, KS and logistic regression methods
    b_ichimura=ichimura(x_train,y_train,.1,-1,1)
    b_KS=KS(x_train,y_train,.1,-1,1)
    log = LogisticRegression().fit(x,y)

    x_hat_ichimura=np.dot(x_train,[1,b_ichimura])
    x_hat_KS=np.dot(x_train,[1,b_KS])

    #interpolate the function to be applied to the single-index calculated from estimated beta and x variables
    #this is a simplified way to estimate the leave-one-out estimator in Ichimura (1993)
    f=interp1d(x_hat_ichimura, y_train)
    g=interp1d(x_hat_KS,y_train)

    #predict y using x variables and estimated leave-one-out estimator on the test sample and convert y to binary
    y_hat={}
    y_hat['ichimura']=f(np.dot(x_test,[1,b_ichimura]))>.5
    y_hat['KS']=g(np.dot(x_test,[1,b_KS]))>.5
    y_hat['log']=log.predict(x_test)

    #calculate rate of accurate prediction
    accuracy={}
    for name in 'ichimura','KS','log':
        accuracy[name]=sum((y_hat[name]-y_test)==0)/len(y_test)

    # Dump data to be used for table.
    with open(ppj("OUT_EMPIRICAL", "empirical.pickle"), "wb") as out_file:
        pickle.dump(accuracy, out_file)
