import scipy.io
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
from scipy.interpolate import spline

#Datafile = 1

plt.figure()
data = scipy.io.loadmat('VarDataTopK.mat')
X = data['TimeList']
Y = data['SizeList']

markers = ['D','o','h','H','8','d','p'] ;
lines = ['-','--','-.',':',':','--','-'] ;
labels = ['ChangeCorrelation','L1','L2','DTW','Pearson', 'Kendall','Spearman'] ;

for i in range(0,7):
#	linestyle='--', marker='o', color='b'
	x_sm = np.array(Y[:,0])
	y_sm = np.array(X[:,i])
		#x_smooth = np.linspace(x_sm.min(), x_sm.max(), 200)
	#y_smooth = spline(Y[:,i], X[:,i], x_smooth)
	plt.plot(x_sm, y_sm,linewidth=1.41,label=labels[i],marker=markers[i],markeredgewidth=0.0) ;
	plt.legend(loc='best') ;
	plt.xlabel('#Ranking Length',fontsize=16,fontweight='medium')

plt.ylabel('#Cpu Execution Time [Second]',fontsize=16,fontweight='medium')
plt.tick_params(axis='x', labelsize=16)
plt.tick_params(axis='y', labelsize=16)
#plt.title('Sythetic-T'+Datafile, fontsize=30,fontweight='medium')
plt.savefig('VarDataTopK.eps')
plt.show()
