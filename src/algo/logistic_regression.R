# Logistic regression

logistic.learner <- makeLearner("classif.logreg",predict.type = "prob")

#Clean memory
if(exists('fmodel')){rm(fmodel)}
#Train model and manage error if needed
fmodel  = tryCatch({fmodel = train(logistic.learner,trainTask)}, 
                   error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
#predict on test data if train set exist
if(!is.null(fmodel)){
  fpmodel = predict(fmodel, testTask)
  #create submission file
  write.csv(fpmodel$data, paste('../results/logistic_regression_test_',i,'_',compteur1,'.csv',sep=''),row.names = T)
  df_conti[compteur1,] = confu.mat(compteur1, 'Logistic_regression',
                                   i,Truth_Total_positif,Truth_Total_negativ, fpmodel$data$truth, fpmodel$data$response)
}else{
  df_conti[compteur1,] =  confu.mat.null(compteur1, 'Logistic_regression', i,Truth_Total_positif, Truth_Total_negativ)
}
compteur1 = compteur1 + 1