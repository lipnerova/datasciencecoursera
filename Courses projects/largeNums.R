
# we define the classes that will be used for formatting
largeNum <- function(x, digits=3, unit=NULL) {
  
  # we only handle K, M and B
  if( !(digits %in% c(3,6,9)) ) stop('only digits allowed are 3, 6 and 9')
  if(!is.null(unit)) if(unit=="") unit=NULL
  
  # we set the digit class
  digitClass <- ifelse(digits == 3, "lNumDigitk",
                ifelse(digits == 6, "lNumDigitM", 
                                    "lNumDigitB"))
  
  # we prepare the classes to append
  largeNumClasses <-  digitClass
  if (!is.null(unit)) largeNumClasses <- c(largeNumClasses,paste0("lNumUnit",unit))
    
  # we set the unit class
  class(x) <- 'lNum'
  class(x) <- append(class(x), largeNumClasses)
  return(x)
  
}

## format: useful in data frames
format.lNum <- function(x,...) {

  # digits
  digitClass <- class(x)[which(grepl("lNumDigit",class(x)))]
  digitLetter <- substr(digitClass, nchar(digitClass), nchar(digitClass))
  digit <- ifelse(digitLetter == "k", 10^3,
           ifelse(digitLetter == "M", 10^6, 
                                      10^9))

  # unit if relevant
  if(any(grepl("lNumUnit",class(x)))) {
    unitClass <- class(x)[which(grepl("lNumUnit",class(x)))]
    unit <- substr(unitClass, 9, nchar(unitClass))
    return(paste0(round(unclass(x) / digit, 1), paste(digitLetter,unit)))
  }

  return(paste0(round(unclass(x) / digit, 1),digitLetter))

}

as.data.frame.lNum <- base:::as.data.frame.numeric


# print: useful when returning largeNum(x, ...)
print.lNum <- function(x,...) {
  x <- format.lNum(x)
  NextMethod(x, quote = FALSE, ...)
}

# pander (only for vectors)
pander.lNum <- function(x,...) {

  # digits
  digitClass <- class(x)[which(grepl("lNumDigit",class(x)))]
  digitLetter <- substr(digitClass, nchar(digitClass), nchar(digitClass))
  digit <- ifelse(digitLetter == "k", 10^3,
                  ifelse(digitLetter == "M", 10^6, 
                         10^9))
  
  # unit if relevant
  if(any(grepl("lNumUnit",class(x)))) {
    unitClass <- class(x)[which(grepl("lNumUnit",class(x)))]
    unit <- substr(unitClass, 9, nchar(unitClass))
    pander(paste0(round(unclass(x) / digit, 1), paste(digitLetter,unit)))
  }
  else {
    pander(paste0(round(unclass(x) / digit, 1),digitLetter))
  }
  
}



?sum


?pander.data.frame











x <- c(6e+06, 75000400, 743450000, 340000, 4300000)

x <- largeNum(x,6,"USD")
x

y<-data.frame(x)
y

pander(largeNum(sum(x),6,"USD"))
pander(y)

pander.data.frame.lNum <- pander:::pander.lNum

pander(data.frame(largeNum(x,6)))

?pander.data.frame
