#!/usr/bin/env python
# a bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

N = 3
ind = np.arange(N)  # the x locations for the groups
width = 0.11       # the width of the bars

fig, ax = plt.subplots(3,1)
ax[1].set_ylabel('#Cpu Execution Time [second]',fontsize=16, fontweight='medium')
#ax[0].set_title('Runing Time of ChangeCorelation Compared with Other Algorithms',fontsize=14.0, fontweight='bold')
ax[2].set_xlabel('#Data Set',fontsize=16, fontweight='medium')

ax[0].yaxis.grid()
ax[1].yaxis.grid()
ax[2].yaxis.grid()
ax[0].set_ylim([1, 10000])
ax[1].set_ylim([1, 50000])
ax[2].set_ylim([1, 100000])

'''
for tick in ax[0].yaxis.get_major_ticks():
    tick.label1.set_fontsize(14.0)
    tick.label1.set_fontweight('bold')
for tick in ax[1].yaxis.get_major_ticks():
    tick.label1.set_fontsize(14.0)
    tick.label1.set_fontweight('bold')
for tick in ax[2].yaxis.get_major_ticks():
    tick.label1.set_fontsize(14.0)
    tick.label1.set_fontweight('bold')
'''

ChangeCorelationMeans = (2.33, 2.53, 3.91, 77.17, 79.47, 90.38, 400.49, 411.57, 453.65)
ChangeCorelationStd = (0.3, 0.3, 0.4, 7, 8, 9, 40, 41, 45)

rects00 = ax[0].bar(ind, ChangeCorelationMeans[0:3], width, color='white', hatch="////", yerr=ChangeCorelationStd[0:3],ecolor='black',log=True,linewidth=1)
rects01 = ax[1].bar(ind, ChangeCorelationMeans[3:6], width, color='white', hatch="////", yerr=ChangeCorelationStd[3:6],ecolor='black',log=True,linewidth=1)
rects02 = ax[2].bar(ind, ChangeCorelationMeans[6:9], width, color='white', hatch="////", yerr=ChangeCorelationStd[6:9],ecolor='black',log=True,linewidth=1)

L1Means = (9.86, 26.6, 66.04, 284.09, 426.51, 679.65, 1135.65, 2356.65, 2899.65)
L1Std = (1, 2.5, 6.6, 28.4, 42.6, 67.9, 113.5, 235.2, 289.6)
rects10 = ax[0].bar(ind + width*1, L1Means[0:3], width, color='white', yerr=L1Std[0:3], ecolor='black', hatch="xxxx")
rects11 = ax[1].bar(ind + width*1, L1Means[3:6], width, color='white', yerr=L1Std[3:6], ecolor='black', hatch="xxxx")
rects12 = ax[2].bar(ind + width*1, L1Means[6:9], width, color='white', yerr=L1Std[6:9], ecolor='black', hatch="xxxx")

L2Means = (12.23, 32.4, 80.56, 344.33, 559.56, 765.45, 1265.65, 3654.65, 4032.68)
L2Std = (1.2, 3, 7.5, 34.4, 55.9, 76.5, 126.5, 365.5, 403.2)
rects20 = ax[0].bar(ind + width*2, L2Means[0:3], width, color='white', yerr=L2Std[0:3], ecolor='black', hatch="++++")
rects21 = ax[1].bar(ind + width*2, L2Means[3:6], width, color='white', yerr=L2Std[3:6], ecolor='black', hatch="++++")
rects22 = ax[2].bar(ind + width*2, L2Means[6:9], width, color='white', yerr=L2Std[6:9], ecolor='black', hatch="++++")

DTWMeans = (617.00, 2680, 3600, 8500, 13500, 17500, 26500, 28500, 31000)
DTWStd = (60, 250, 360, 850, 1350, 1750, 2650, 2850, 3100)
rects30 = ax[0].bar(ind + width*3, DTWMeans[0:3], width, color='white', yerr=DTWStd[0:3], ecolor='black', hatch="....")
rects31 = ax[1].bar(ind + width*3, DTWMeans[3:6], width, color='white', yerr=DTWStd[3:6], ecolor='black',hatch="....")
rects32 = ax[2].bar(ind + width*3, DTWMeans[6:9], width, color='white', yerr=DTWStd[6:9], ecolor='black',hatch="....")

PearsonMeans = (17.89, 18, 184.68, 336.3, 335.6, 3635.4, 6425.6, 6545.5, 9354.5)
PearsonStd = (1.7, 1.8, 18.4, 33.6, 33.5, 363.3, 664.2, 654.5, 935.4)
rects40 = ax[0].bar(ind + width*4, PearsonMeans[0:3], width, color='white', yerr=PearsonStd[0:3], ecolor='black',hatch="----")
rects41 = ax[1].bar(ind + width*4, PearsonMeans[3:6], width, color='white', yerr=PearsonStd[3:6], ecolor='black',hatch="----")
rects42 = ax[2].bar(ind + width*4, PearsonMeans[6:9], width, color='white', yerr=PearsonStd[6:9], ecolor='black',hatch="----")

KendallMeans = (1615.89, 3645, 4268, 8500, 16500, 18500, 28500, 29500, 32700)
KendallStd = (100, 300, 400, 850, 1600, 1800, 2850, 2950, 3270)
rects50 = ax[0].bar(ind + width*5, KendallMeans[0:3], width, color='white', yerr=KendallStd[0:3], ecolor='black')
rects51 = ax[1].bar(ind + width*5, KendallMeans[3:6], width, color='white', yerr=KendallStd[3:6], ecolor='black')
rects52 = ax[2].bar(ind + width*5, KendallMeans[6:9], width, color='white', yerr=KendallStd[6:9], ecolor='black')

SpearmanMeans = (368.89, 674.28, 6703, 8500, 12500, 13500, 18500, 19500, 22700)
SpearmanStd = (38.89, 64.8, 603, 800, 1250, 1300, 1500, 1900, 2270)
rects60 = ax[0].bar(ind + width*6, SpearmanMeans[0:3], width, color='black', yerr=SpearmanStd[0:3], ecolor='black')
rects61 = ax[1].bar(ind + width*6, SpearmanMeans[3:6], width, color='black', yerr=SpearmanStd[3:6], ecolor='black')
rects62 = ax[2].bar(ind + width*6, SpearmanMeans[6:9], width, color='black', yerr=SpearmanStd[6:9], ecolor='black')

# add some text for labels, title and axes ticks
 
ax[0].set_xticks(ind + 4*width)
ax[1].set_xticks(ind + 4*width)
ax[2].set_xticks(ind + 4*width)
ax[0].set_xticklabels(('Sythetic-T0', 'Sythetic-T1', 'Sythetic-T2'),fontsize=14.0)
ax[1].set_xticklabels(('Sythetic-T3', 'Sythetic-T4', 'Sythetic-T5'),fontsize=14.0)
ax[2].set_xticklabels(('Sythetic-T6', 'Sythetic-T7', 'Sythetic-T8'),fontsize=14.0)

box = ax[0].get_position()
ax[0].set_position([box.x0, box.y0, box.width, box.height * 0.9])
box = ax[1].get_position()
ax[1].set_position([box.x0, box.y0, box.width, box.height * 0.9])
box = ax[2].get_position()
ax[2].set_position([box.x0, box.y0, box.width, box.height * 0.9])


plt.figlegend((rects00[0], rects10[0], rects20[0], rects30[0], rects40[0], rects50[0], rects60[0]), 
	('ChangeCorrelation', 'L1', 'L2', 'DTW', 'Pearson', 'Kendall', 'Spearman'),
	loc='upper center', bbox_to_anchor=(0.5, 0.99),fancybox=True, shadow=True, ncol=4,frameon=False)

#leg = plt.gca().get_legend()
#ltext = leg.get_texts()
#plt.setp(ltext, fontsize=14.0,fontweight='bold')


'''
def autolabel(rects):
    # attach some text labels
    for rect in rects:
        height = rect.get_height()
        ax.text(rect.get_x() + rect.get_width()/2., 1.05*height,
                '%d' % int(height),
                ha='center', va='bottom')

autolabel(rects0)
autolabel(rects1)
autolabel(rects2)
autolabel(rects3)
autolabel(rects4)
autolabel(rects5)
autolabel(rects6)
'''

plt.show()