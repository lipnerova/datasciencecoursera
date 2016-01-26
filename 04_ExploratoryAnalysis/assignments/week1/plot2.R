
# ------------------------- READING THE FILE ------------------------------------------ #

# Note: this part is the same for all the four .R files

# we use the dplyr library to filter the required dates
library (dplyr)


dataFile <- 'household_power_consumption.txt'

# we identify the classes of a small sample to increase the load speed of the full table
initial <- read.table (dataFile, sep = ';', nrows = 100, header = TRUE, na.strings = '?')
classes <- sapply (initial, class)
tabAll  <- read.table (dataFile, sep = ';', header = TRUE, na.strings = '?', colClasses = classes)

# we create a new variable with the proper date format
tabAll <- mutate (tabAll, cleanDate = as.Date (Date, '%d/%m/%Y'))

# we keep only the two relevant days
workingData <- filter (tabAll, cleanDate == '2007-02-01' | cleanDate == '2007-02-02')

# we concatenate date & time then transform it into a time object, in orderto have a clean plot
workingData <- mutate (workingData, cleanTime = as.POSIXct (paste (cleanDate, Time, sep = ' ')))



# ------------------------- BUILDING THE PLOT ----------------------------------------- #

png (file = "plot2.png") 

plot  (workingData$cleanTime, workingData$Global_active_power, type='l', xlab = '', ylab = 'Global Active Power (kilowatts)')

dev.off() 
