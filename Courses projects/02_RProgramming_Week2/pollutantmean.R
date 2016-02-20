
pollutantmean <- function (directory, pollutant, id = 1:332) {
  
  pollutantSum   <- 0
  poluttantCount <- 0
  
  for (i in seq_along (id)) {
    
    # create the proper number format
    myZeros  <- paste (rep('0', 3 - nchar (id[i])), collapse = '')
    myNumber <- paste (myZeros, id[i], sep = '')
    
    # open the file
    myPath <- paste('.\\', directory, '\\', myNumber, '.csv', sep = '')
    myTable <- read.csv (myPath, header = TRUE)
    
    # filter NA values
    bad <- is.na (myTable [[pollutant]])
    myData <- myTable [!bad, ]

    pollutantSum   <- pollutantSum   + sum (myData [[pollutant]])
    poluttantCount <- poluttantCount + nrow (myData)
    
  }
  
  # return the pollutant mean
  if (poluttantCount == 0) { 0 }
  else { pollutantSum / poluttantCount } 
  
}
