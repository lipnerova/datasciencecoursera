
complete <- function (directory, id) {
  
  # pre allocate the table
  rowCount <- length (id)
  myDF <- data.frame (x = numeric (rowCount), y = numeric (rowCount), stringsAsFactors = FALSE)
  col_headings <- c('id','nobs')
  names(myDF) <- col_headings
  
  for (i in seq_along (id)) {
    
    # create the proper number format
    myZeros  <- paste (rep('0', 3 - nchar (id[i])), collapse = '')
    myNumber <- paste (myZeros, id[i], sep = '')
    
    # open the file
    myPath <- paste('.\\', directory, '\\', myNumber, '.csv', sep = '')
    myTable <- read.csv (myPath, header = TRUE)
    
    # filter NA values
    good <- complete.cases (myTable)
    myData <- myTable [good, ]
    
    # populate the data frame
    myDF$id[i]   <- id[i]
    myDF$nobs[i] <- nrow (myData)
    
  }
  
  myDF
  
}

