#load xgboost
# XGBOOST

set.seed(1001)

getParamSet("classif.xgboost")

#make learner with inital parameters
xg_set = makeLearner("classif.xgboost", predict.type = "prob")
xg_set$par.vals = list(
  objective = "binary:logistic",
  eval_metric = "error",
  nrounds = 250
)

#define parameters for tuning
xg_ps = makeParamSet(
  makeIntegerParam("nrounds",lower=200,upper=600),
  makeIntegerParam("max_depth",lower=3,upper=20),
  makeNumericParam("lambda",lower=0.55,upper=0.60),
  makeNumericParam("eta", lower = 0.001, upper = 0.5),
  makeNumericParam("subsample", lower = 0.10, upper = 0.80),
  makeNumericParam("min_child_weight",lower=1,upper=5),
  makeNumericParam("colsample_bytree",lower = 0.2,upper = 0.8)
)

#define search function
rancontrol = makeTuneControlRandom(maxit = 100L) #do 100 iterations
#3 fold cross validation
set_cv = makeResampleDesc("CV",iters = 3L)
#tune parameters
xg_tune = tuneParams(learner = xg_set, task = trainTask, resampling = set_cv,
                     measures = acc, par.set = xg_ps, control = rancontrol)
#set parameters
xg_new = setHyperPars(learner = xg_set, par.vals = xg_tune$x)
#train model
xgmodel = train(xg_new, trainTask)
#test model
predict.xg = predict(xgmodel, testTask)

if(exists('xgmodel')){rm(xgmodel)}
#train model and manage error if needed
xgmodel = tryCatch({xgmodel = train(xg_new, trainTask)}, 
                  error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
#predict on test data if train set exist
if(!is.null(xgmodel)){
  predict.xg = predict(xgmodel, testTask)
  #create submission file
  write.csv(predict.xg$data, paste('../results/xgboost_test_',i,'_',compteur1,'.csv',sep=''), row.names = T)
  df_conti[compteur1,] = confu.mat(compteur1,'xgboost',
                                   i,Truth_Total_positif, Truth_Total_negativ, predict.xg$data$truth, predict.xg$data$response)
}else{
  df_conti[compteur1,] = confu.mat.null(compteur1, 'xgboost', i,Truth_Total_positif, Truth_Total_negativ)
}
compteur1 = compteur1 + 1
