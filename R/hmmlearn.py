import os
import numpy as np 
from hmmlearn import hmm
from hmmlearn.hmm import GaussianHMM

model = hmm.GaussianHMM(n_components=3, covariance_type="full")
model.startprob_ = np.array([1/3, 1/3, 1/3])
model.transmat_ = np.array([[0.5, 0.25, 0.25],
                            [0.3, 0.4, 0.3],
                            [0.25, 0.25, 0.5]])
model.means_ = np.array([0.87, 0.14, 0.39])
model.covars_ = np.array([0.9, 0.9, 0.9])