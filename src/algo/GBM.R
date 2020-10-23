
# GBM

#load GBM
getParamSet("classif.gbm")
g.gbm = makeLearner("classif.gbm", predict.type = "prob")
#specify tuning method
rancontrol = makeTuneControlRandom(maxit = 50L)
#3 fold cross validation
set_cv = makeResampleDesc("CV",iters = 3L)
#parameters
gbm_par<- makeParamSet(
  makeDiscreteParam("distribution", values = "bernoulli"),
  makeIntegerParam("n.trees", lower = 100, upper = 1000), #number of trees
  makeIntegerParam("interaction.depth", lower = 2, upper = 10), #depth of tree
  makeIntegerParam("n.minobsinnode", lower = 10, upper = 80),
  makeNumericParam("shrinkage",lower = 0.01, upper = 1)
)
# n.minobsinnode refers to the minimum number of observations in a tree node. 
# shrinkage is the regulation parameter which dictates how fast / slow the algorithm should move.
#tune parameters
if(exists("tune_gbm")){rm(tune_gbm)}
tune_gbm = tryCatch({tune_gbm = tuneParams(learner = g.gbm, task = trainTask,resampling = set_cv,measures = acc,par.set = gbm_par,control = rancontrol)}, 
                  error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
if(!is.null(tune_gbm)){
  #set parameters
  final_gbm = setHyperPars(learner = g.gbm, par.vals = tune_gbm$x)
  #train
  to.gbm = train(final_gbm, traintask)
  #test
  pr.gbm = predict(to.gbm, testTask)
  
  if(exists('to.gbm')){rm(to.gbm)}
  #train model and manage error if needed
  to.gbm = tryCatch({to.gbm = train(final_gbm, traintask)}, 
                    error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  #predict on test data if train set exist
  if(!is.null('to.gbm')){
    pr.gbm  = predict(to.gbm, testTask)
    #create submission file
    write.csv(pr.gbm$data, paste('../results/GBM_test_',i,'_',compteur1,'.csv',sep=''), row.names = T)
    df_conti[compteur1,] = confu.mat(compteur1,'GBM',
                                     i,Truth_Total_positif, Truth_Total_negativ, qpredict$data$truth, qpredict$data$response)
  }else{
    df_conti[compteur1,] = confu.mat.null(compteur1, 'GBM', i,Truth_Total_positif, Truth_Total_negativ)
  }
}else{df_conti[compteur1,] = confu.mat.null(compteur1, 'GBM', i,Truth_Total_positif, Truth_Total_negativ)}
compteur1 = compteur1 + 1