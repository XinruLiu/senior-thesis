import os
#import pandas
import librosa
import librosa.display
import glob
import errno
import scipy as sklearn
import csv
import sklearn.preprocessing
from sklearn.cluster import KMeans
from sklearn import mixture
import numpy as np
from numpy import array
import scipy.cluster.vq
from scipy.cluster.vq import vq
from scipy.cluster.vq import whiten
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
import re

folder_array = ['../audio/Bach_Fugue/wav/*.wav', '../audio/Beethoven_sonata/wav/*.wav', '../audio/Chopin_nocturne_waltz/wav/*.wav','../audio/Debussy/wav/*.wav', '../audio/Schubert/wav/*.wav','../audio/Schoenberg/wav/*.wav','../audio/Schumann/wav/*.wav' ]
mfcc_array = ['Bach', 'Beethoven', 'Chopin', 'Debussy', 'Schubert', 'Schoenberg','Schumann']

i=0
for folder in folder_array:
	files = glob.glob(folder)
	for piece in files:
		piece_name = piece[piece.find('\\')+1:piece.find('.wav')]
		print(piece_name)
		y, sr = librosa.load(piece)
		mfcc = librosa.feature.mfcc(y=y, sr=sr, hop_length=int(0.025*sr), n_fft=int(0.025*sr), n_mfcc=20)
		mfcc = whiten(mfcc) #scale the MFCC such that each coefficient dimension has zero mean and unit variance
		mfcc = mfcc[:12]
		#print(len(mfcc))
		for j in range(0,12):
			x = np.arange(0,len(mfcc[j]))
			plt.plot(x, mfcc[j])
		plt.show()

		for k in range(0,12):

			x = mfcc[k]

			plt.hist(x, density=True, bins=200)
			plt.xlabel('MFCC'+ str(k+1) )
			plt.ylabel("density")
			plt.title("MFCC" + str(k+1) + " from Bach_A_flat_major_BWV862_fugue")
			plt.show()
		mfcc_transpose = mfcc.transpose()
		sequence = mfcc_transpose

		with open("../mfcc/" + mfcc_array[i] + '/'+ piece_name + '.csv', 'w') as outfile:
			writer = csv.writer(outfile)
			for j in range(0,len(sequence)):
				writer.writerow(sequence[j])
	i+=1

#print(len(sequence))
# S = np.abs(librosa.stft(y))
# chroma = librosa.feature.chroma_stft(S=S, sr=sr)
# plt.figure(figsize=(10, 4))
# librosa.display.specshow(chroma, y_axis='chroma', x_axis='time')
# plt.colorbar()
# plt.title('Chromagram')
# plt.tight_layout()
# plt.show()
# chroma_sequence = chroma.transpose()
#print(len(chroma.transpose()))
#with open("Debussy/wav/Debussymfcc" + str(i) + ".csv", "w") as outfile:
# with open("Schubertmfcc2.csv", "w") as outfile:
# 	writer = csv.writer(outfile)
# 	for j in range(0,len(sequence)):
# 	    writer.writerow(sequence[j])
# 	    #sns.distplot(sequence[i])
# 	#plt.show()
# #i+=1
# with open("Schubertchroma2.csv", "w") as outfile:
# 	writer = csv.writer(outfile)
# 	for j in range(0,len(chroma_sequence)):
# 	    writer.writerow(chroma_sequence[j])

	