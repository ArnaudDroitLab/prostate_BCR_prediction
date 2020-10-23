 # Functions

confu.mat = function(item, algo, reroll,Truth_Total_positif, Truth_Total_negativ, ref, pred){
  
  tmp = as.matrix(table(ref, pred))
  Total = length(pred)
  TN = tmp[1,1]
  FN = tmp[1,2]
  FP = tmp[2,1]
  TP = tmp[2,2]
  TPR = TP/Truth_Total_positif
  FPR = FP/Truth_Total_positif
  TNR = TN/Truth_Total_negativ
  FNR = FN/Truth_Total_negativ
  Sensibility = TP/(TP + FN)
  Sensitivity = TN/(TN + FP)
  Accuracy = (TP+TN)/Total
  AUC = auc(as.numeric(ref)-1, as.numeric(pred)-1)
  
  vec = c(item, algo, reroll, Total, Truth_Total_positif, Truth_Total_negativ, NA, AUC, TN, FN, FP, TP,
          TPR, FNR, FPR, TNR, Sensibility, Sensitivity, Accuracy)
  
  return(vec)
}

confu.mat.null = function(item, algo, reroll,Truth_Total_positif, Truth_Total_negativ, pred){
  vec = c(item, algo, reroll, NA, Truth_Total_positif, Truth_Total_negativ, rep(NA, 13))
  return(vec)
}

create_train = function(df_toWork_0,df_toWork_1 ){
  
  train_0 = df_toWork_0[sample(1:dim(df_toWork_0)[1], size = round((nb_train)*dim(df_toWork_0)[1])),]
  train_1 = df_toWork_1[sample(1:dim(df_toWork_1)[1], size = round((nb_train)*dim(df_toWork_1)[1])),]
  train = rbind(train_0,train_1)
  return(train)
}

create_test = function(df_toWork_0, df_toWork_1){
  
  test_0 = df_toWork_0[sample(1:dim(df_toWork_0)[1], size = round((nb_test)*dim(df_toWork_0)[1])),]
  test_1 = df_toWork_1[sample(1:dim(df_toWork_1)[1], size = round((nb_test)*dim(df_toWork_1)[1])),]
  test = rbind(test_0,test_1)
  return(test)
}
