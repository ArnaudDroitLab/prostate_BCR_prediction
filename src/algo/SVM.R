# SVM

#load svm
getParamSet("classif.ksvm") #do install kernlab package 
ksvm = makeLearner("classif.ksvm", predict.type = "prob")
#Set parameters
pssvm = makeParamSet(
  makeDiscreteParam("C", values = 2^c(-8,-4,-2,0)), #cost parameters
  makeDiscreteParam("sigma", values = 2^c(-8,-4,0,4)) #RBF Kernel Parameter
)
#specify search function
ctrl = makeTuneControlGrid()
#tune model
res = tuneParams(ksvm, task = trainTask, resampling = set_cv, par.set = pssvm, control = ctrl,measures = acc)
#set the model with best params
t.svm = setHyperPars(ksvm, par.vals = res$x)
#train
par.svm = train(ksvm, trainTask)
#test
predict.svm = predict(par.svm, testTask)

if(exists('par.svm')){rm(par.svm)}
#train model and manage error if needed
par.svm = tryCatch({par.svm = train(ksvm, trainTask)}, 
                   error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
#predict on test data if train set exist
if(!is.null(par.svm)){
  predict.svm = predict(par.svm, testTask)
  #create submission file
  write.csv(predict.svm$data, paste('../results/SVM_test_',i,'_',compteur1,'.csv',sep=''), row.names = T)
  df_conti[compteur1,] = confu.mat(compteur1,'SVM',
                                   i,Truth_Total_positif, Truth_Total_negativ, predict.svm$data$truth, predict.svm$data$response)
}else{
  df_conti[compteur1,] = confu.mat.null(compteur1, 'SVM', i,Truth_Total_positif, Truth_Total_negativ)
}
compteur1 = compteur1 + 1