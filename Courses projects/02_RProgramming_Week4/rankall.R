
# ------------------------- LIST OF BEST HOSPITALS BY STATE --------------------------- #

# function returning the best hospital of a given state for a given outcome
rankall <- function (state='ALL', outcome, num='best') {
  
  # preparing state & outcome lists
  states <- levels(factor (outcomeData[, 7]))
  outcomes <- c('heart attack' = 11, 'heart failure' = 17, 'pneumonia' = 23)
  
  # modify input to remove case
  state <- toupper (state)
  outcome <- tolower (outcome)
  
  # check that state & outcome are valid
  if (!(state == 'ALL' | state %in% states)) stop("invalid state")
  if (!(outcome %in% names (outcomes))) stop("invalid outcome")
  if (!(num %in% c ('best', 'worst') | is.numeric(num))) stop("invalid rank")
  
  # read outcome data
  subset <- outcomeData [, c(2, 7, outcomes [outcome])]  # keep only 3 columns: name of the hospital, state & outcome 30-day mortality rate (DMR)
  
  names (subset) <- c ('name', 'state', 'DMR')  # rename columns for easier manipulation
  subset <- split (subset, subset$state)        # split: one data frame per state
  subset <- Map (na.omit, subset)               # complete cases for each data frame
  
  subset <- lapply (subset, function(x) arrange (x, DMR, name))  # sort by decr. 30DMR then by asc. name
  
  # return hospital name in that state with lowest 30-day death
  if (num == 'best')  num <- 1
  
  if (num == 'worst') {
    result <- sapply (subset, function(x) x [nrow (x), 1]) # returns a named vector
  }
  else {
    result <- sapply (subset, function(x) x [num, 1]) # returns a named vector
  }
  
  result <- data.frame(hospital = result, state = names (result), row.names = names (result))

  if (state != 'ALL') {
    return (result [result$state == state, ])
  }
  return (result)
  
}

