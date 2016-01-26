
makeVector <- function (x = numeric()) {
  
  m <- NULL
  set <- function (y) {
    x <<- y
    m <<- NULL
  }
  
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)

}

cachemean <- function(x, ...) {
  
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
  
}

# set a vector. getmean() returns NULL as it is not set yet
v <- makeVector()
v$set (1:10)
v$getmean()

# we set the mean & cache it. Not getmean() returns 5.5
cachemean(v)
v$getmean()
cachemean(v)
