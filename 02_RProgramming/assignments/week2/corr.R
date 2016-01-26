
corr <- function (directory, threshold = 0) {
  
  fileRange <- 1:332
  myIndexTable <- complete (directory, fileRange)
    
  corVector <- numeric (0)
  
  for (i in seq_along (fileRange)) {
    
    if (myIndexTable$nobs[fileRange[i]] >= threshold) {
      
      currentID = myIndexTable$id[fileRange[i]]
      
      # create the proper number format
      myZeros  <- paste (rep('0', 3 - nchar (currentID)), collapse = '')
      myNumber <- paste (myZeros, currentID, sep = '')
      
      # open the file
      myPath <- paste('.\\', directory, '\\', myNumber, '.csv', sep = '')
      myTable <- read.csv (myPath, header = TRUE)
      
      # filter NA values
      good <- complete.cases (myTable)
      myData <- myTable [good, ]
      
      corVector <- c(corVector, cor (myData [['nitrate']], myData [['sulfate']]))

    }
    
  }
  
  corVector
  
}


