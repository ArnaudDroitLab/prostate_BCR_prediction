# LDA

lda.learner = makeLearner("classif.lda", predict.type = "prob")
ldamodel = train(lda.learner, task)
ldapred = predict(ldamodel, task = task)

# Clean memory
if(exists('ldamodel')){rm(ldamodel)}
#train model and manage error if needed
ldamodel = tryCatch({ldamodel = train(lda.learner, trainTask)}, 
                  error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
#predict on test data if train set exist
if(!is.null(ldamodel)){
  ldapredict = predict(ldamodel, testTask)
  #create submission file
  write.csv(ldapredict$data, paste('../results/LDA_test_',i,'_',compteur1,'.csv',sep=''), row.names = T)
  df_conti[compteur1,] = confu.mat(compteur1,'lda',
                                   i,Truth_Total_positif, Truth_Total_negativ, ldapredict$data$truth, ldapredict$data$response)
}else{
  df_conti[compteur1,] = confu.mat.null(compteur1, 'lda', i,Truth_Total_positif, Truth_Total_negativ)
}
compteur1 = compteur1 + 1

