
# one to one decode function
decode <- function(x, search, replace, default = NULL) {
  
  # build a nested ifelse function by recursion
  decode.fun <- function(search, replace, default = NULL) {
    
    # replace all remaining x values by the default value (or x if not specified)
    if (length(search) == 0) {
      function(x) if (is.null(default)) x else rep(default, length(x))
    } 
    
    # recursive function
    else {
      
      function(x) {
        ifelse(x == search[1], replace[1],
                    decode.fun(tail(search, -1), tail(replace, -1), default)(x)) # recursive call
      }
    }
    
  }
  
  return(decode.fun(search, replace, default)(x))

}

# many to one decode function
decodeList <- function(x, default = NULL, searchNreplace) {
  
  # split vector in two
  search <- searchNreplace[seq(1, length(searchNreplace), 2)]
  replace <- searchNreplace[seq(2, length(searchNreplace), 2)]
  
  # build a nested ifelse function by recursion
  decode.fun <- function(search, replace, default = NULL) {

    # replace all remaining x values by the default value (or x if not specified)
    if (length(search) == 0) {
      function(x) if (is.null(default)) x else rep(default, length(x))
    } 
    
    # recursive function
    else {
      
      function(x) {
        ifelse(apply(sapply(search[[1]], grepl, x),1,any), replace[[1]],
               decode.fun(tail(search, -1), tail(replace, -1), default)(x)) # recursive call
      }
    }
    
  }
  
  return(decode.fun(search, replace, default)(x))
  
}

# source: http://www.r-bloggers.com/search-and-replace-are-you-tired-of-nested-ifelse/