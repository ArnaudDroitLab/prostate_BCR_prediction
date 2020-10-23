# random forest

#create a learner
rf <- makeLearner("classif.randomForest", predict.type = "prob", par.vals = list(ntree = 200, mtry = 3))
rf$par.vals <- list(importance = TRUE)
#set tunable parameters
#grid search to find hyperparameters
rf_param <- makeParamSet(
  makeIntegerParam("ntree",lower = 50, upper = 500),
  makeIntegerParam("mtry", lower = 3, upper = 10),
  makeIntegerParam("nodesize", lower = 10, upper = 50)
)

#let's do random search for 50 iterations
rancontrol <- makeTuneControlRandom(maxit = 50L)
#set 3 fold cross validation
set_cv <- makeResampleDesc("CV",iters = 3L)
#hypertuning
rf_tune <- tuneParams(learner = rf, resampling = set_cv, task = trainTask, par.set = rf_param, control = rancontrol, measures = acc)
#using hyperparameters for modeling
rf.tree <- setHyperPars(rf, par.vals = rf_tune$x)

if(exists('rforest')){rm(rforest)}
#train model and manage error if needed
rforest = tryCatch({rforest = train(rf.tree, trainTask)}, 
                   error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
#predict on test data if train set exist
if(!is.null(rforest)){
  rfmodel = predict(rforest, testTask)
  #create submission file
  write.csv(rfmodel$data, paste('../results/RF_test_',i,'_',compteur1,'.csv',sep=''), row.names = T)
  df_conti[compteur1,] = confu.mat(compteur1,'Random_forest',
                                   i,Truth_Total_positif, Truth_Total_negativ, rfmodel$data$truth, rfmodel$data$response)
}else{
  df_conti[compteur1,] = confu.mat.null(compteur1, 'Random_forest', i,Truth_Total_positif, Truth_Total_negativ)
}
compteur1 = compteur1 + 1