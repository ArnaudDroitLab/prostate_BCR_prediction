# Decision Tree

makeatree <- makeLearner("classif.rpart", predict.type = "prob")
#set 3 fold cross validation
set_cv <- makeResampleDesc("CV",iters = 3L)
#Search for hyperparameters
gs <- makeParamSet(
  makeIntegerParam("minsplit",lower = 10, upper = 50),
  makeIntegerParam("minbucket", lower = 5, upper = 50),
  makeNumericParam("cp", lower = 0.001, upper = 0.2)
)
#do a grid search
gscontrol <- makeTuneControlGrid()
#hypertune the parameters
stune <- tuneParams(learner = makeatree, resampling = set_cv, task = trainTask, par.set = gs, control = gscontrol, measures = acc)
#using hyperparameters for modeling
t.tree <- setHyperPars(makeatree, par.vals = stune$x)


#Clean memory
if(exists('t.rpart')){rm(t.rpart)}
#Train model and manage error if needed
t.rpart  = tryCatch({t.rpart = train(t.tree, trainTask)}, 
                    error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
#predict on test data if train set exist
if(!is.null(t.rpart)){
  tpmodel <- predict(t.rpart, testTask)
  #create submission file
  write.csv(tpmodel$data, paste('../results/decsion_tree_',i,'_',compteur1,'.csv',sep=''),row.names = T)
  df_conti[compteur1,] = confu.mat(compteur1, 'Decision_tree',
                                   i,Truth_Total_positif,Truth_Total_negativ, tpmodel$data$truth, tpmodel$data$response)
}else{
  df_conti[compteur1,] =  confu.mat.null(compteur1, 'Decision_tree', i,Truth_Total_positif, Truth_Total_negativ)
}

compteur1 = compteur1 + 1