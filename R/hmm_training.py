import os
from pomegranate import *
import csv
import pandas as pd 
import numpy as np 


mfcc = pd.read_csv("mfcc/Bach/Bach_A_flat_major_BWV862_prelude.csv")

print(len(mfcc.values[0]))
model = HiddenMarkovModel.from_samples(NormalDistribution, n_components=9, X=mfcc)
