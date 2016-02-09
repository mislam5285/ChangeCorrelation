import scipy.io
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
from scipy.interpolate import spline

#Datafile = 1
for i in range(0,9):
	plt.figure()
	Datafile = str(i)
	data = scipy.io.loadmat(Datafile+'.mat')
	X = data['PrecisionList']
	Y = data['RecallList']

	markers = ['.','v','>','>','*','x','D'] ;
	lines = ['-','--','-.',':',':','--','-'] ;
	labels = ['ChangeCorrelation','L1','L2','DTW','Pearson', 'Kendall','Spearman'] ;

	for i in range(0,7):
	#	linestyle='--', marker='o', color='b'
		x_sm = np.array(Y[:,i])
		y_sm = np.array(X[:,i])

		#x_smooth = np.linspace(x_sm.min(), x_sm.max(), 200)
		#y_smooth = spline(Y[:,i], X[:,i], x_smooth)
		plt.plot(x_sm, y_sm,lines[1],linewidth=4,label=labels[i]) ;
		plt.legend(loc='best',frameon=False) ;

	plt.xlabel('#Recall',fontsize=20,fontweight='medium')
	plt.ylabel('#Precision',fontsize=20,fontweight='medium')
	plt.tick_params(axis='x', labelsize=20)
	plt.tick_params(axis='y', labelsize=20)
	plt.title('Sythetic-T'+Datafile, fontsize=30,fontweight='medium')
	plt.savefig('PRC'+Datafile+'.eps')
	#plt.show()
