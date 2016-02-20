## Put comments here that give an overall description of what your
## functions do 

#=============================================================================#
#                                                                             #
# the functions are very similar to the example                               #
#                                                                             #
# we cache the invert of a matrix after we calculate it once, so it can be    #
# easily accessed in the future without additional computation                #
#                                                                             #
#=============================================================================#

## Write a short comment describing this function

# 0. we assign our makeCacheMatrix() function to a variable: myVariable <- makeCacheMatrix ()
# 1. we first have to set the matrix we want to manipulate:  myVariable$set(mySquareMatrix)
# 2. we can access both our matrix & its invert using get & getInvert
# 3. at first, the invert matrix iM has not been calculated yet, so myVariable$getInvert() returns NULL
# 4. each time we set a new matrix, the iM is reset to NULL

makeCacheMatrix <- function (x = matrix()) {
  
  iM <- NULL
  set <- function (y) {
    x <<- y
    iM <<- NULL
  }
  
  get <- function() x
  setInvert <- function(invertMatrix) iM <<- invertMatrix
  getInvert <- function() iM
  
  list(set = set, get = get,
       setInvert = setInvert,
       getInvert = getInvert)
  
}

  
## Write a short comment describing this function

# 1. we check if the invert of our matrix has already been calculated 
# 2. if not, we get the cached value
# 3. otherwise, we calculate it & store it using setInvert()

cacheSolve <- function(x, ...) {
  
  iM <- x$getInvert()
  if(!is.null(iM)) {
    message("getting cached data")
    return(iM)
  }
  data <- x$get()
  iM <- solve(data, ...)
  x$setInvert(iM)
  iM
  
}