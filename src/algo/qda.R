# QDA

#load qda
qda.learner <- makeLearner("classif.qda", predict.type = "prob")
# Clean memory
if(exists('qmodel')){rm(qmodel)}
#train model and manage error if needed
qmodel = tryCatch({qmodel = train(qda.learner, trainTask)}, 
                  error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
#predict on test data if train set exist
if(!is.null(qmodel)){
  qpredict = predict(qmodel, testTask)
  #create submission file
  write.csv(qpredict$data, paste('../results/QDA_test_',i,'_',compteur1,'.csv',sep=''), row.names = T)
  df_conti[compteur1,] = confu.mat(compteur1,'qda',
                                   i,Truth_Total_positif, Truth_Total_negativ, qpredict$data$truth, qpredict$data$response)
}else{
  df_conti[compteur1,] = confu.mat.null(compteur1, 'qda', i,Truth_Total_positif, Truth_Total_negativ)
}
compteur1 = compteur1 + 1