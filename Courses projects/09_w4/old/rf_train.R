
trainML <- function (method, dataset, outcome, ntree=10, cv=FALSE, ncv=10, pca=FALSE, thresh=0.95) {

  # handling Cross Validation
  if (cv == TRUE) {
    fitControl <- trainControl(method = "cv", number = ncv, preProcOptions = list(thresh = thresh))
  }
  else {
    fitControl <- trainControl(preProcOptions = list(thresh = thresh))
  }
  
  # handling pca
  if (pca == TRUE) {
    fitPreProc <- "pca"
  }
  else {
    fitPreProc <- NULL
  }
  
  
  # predictors & outcome vector
  outcomeVector <- dataset[ ,outcome]
  predictors <- dataset[ , -which(names(dataset)==outcome)]
  
  set.seed(1)
  if (method=="rf") {
    train(outcomeVector ~ .,
          method=method, ntree = ntree, data=predictors, importance=TRUE,
          trControl = fitControl, preProcess = fitPreProc)
  }
  
  else if (method=="rpart") {
    train(outcomeVector ~ .,
          method=method, data=predictors,
          trControl = fitControl, preProcess = fitPreProc)
  }
  
  else {
    gbmGrid <- expand.grid(interaction.depth = c(1, 7, 9),
                           n.trees = (1:3)*ntree,
                           shrinkage = 0.1,
                           n.minobsinnode = 10)
    train(outcomeVector ~ .,
          method=method, data=predictors,
          trControl = fitControl, preProcess = fitPreProc, tuneGrid = gbmGrid, verbose = FALSE)
  }
  
}

