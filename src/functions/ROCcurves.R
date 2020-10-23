# ROC curve

tmp = generateThreshVsPerfData(ldapredict, measures = list(fpr, tpr, mmce))
plotROCCurves(tmp)

par(new=F)

tmp = generateThreshVsPerfData(fpmodel, measures = list(fpr, tpr, mmce))
plotROCCurves(tmp)


df = generateThreshVsPerfData(list(lda = ldapredict, reg = fpmodel), measures = list(fpr, tpr))
plotROCCurves(df)


