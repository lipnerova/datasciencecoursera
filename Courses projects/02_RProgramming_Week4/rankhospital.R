
# ------------------------- BEST HOSPITALS BY STATE ----------------------------------- #

# function returning the best hospital of a given state for a given outcome
rankhospital <- function (state, outcome, num='best') {
  
  # preparing state & outcome lists
  states <- levels(factor (outcomeData[, 7]))
  outcomes <- c('heart attack' = 11, 'heart failure' = 17, 'pneumonia' = 23)
  
  # modify input to remove case
  state <- toupper (state)
  outcome <- tolower (outcome)
  
  # check that state & outcome are valid
  if (!(state %in% states)) stop("invalid state")
  if (!(outcome %in% names (outcomes))) stop("invalid outcome")
  if (!(num %in% c ('best', 'worst') | is.numeric(num))) stop("invalid rank")
  
  # read outcome data
  subset <- outcomeData [outcomeData$State == state,   # keep only the rows with a matching state
                         c(2, 7, outcomes [outcome])]  # keep only 3 columns: name of the hospital, state & outcome 30-day mortality rate (DMR)
  
  subset <- subset [complete.cases(subset), ]          # keep only the complete cases
  
  names (subset) <- c ('name', 'state', 'DMR')         # rename columns for easier manipulation
  subset <- arrange (subset, DMR, name)                # sort by decr. 30DMR then by asc. name

  # return hospital name in that state with lowest 30-day death
  if (num == 'best')  num <- 1
  if (num == 'worst') num <- nrow (subset)
  print (subset[num, 1])
  
}

