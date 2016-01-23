
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

png (file = "plot4.png") 

par(mfrow = c(2,2)) # all plots on one page (2x2)

# 1,1
plot  (workingData$cleanTime, workingData$Global_active_power, type='l', xlab = '', ylab = 'Global Active Power (kilowatts)')

# 1,2
plot  (workingData$cleanTime, workingData$Voltage, type='l', xlab = 'datetime', ylab = 'Voltage')

# 2,1
plot  (workingData$cleanTime, workingData$Sub_metering_1, type='l', xlab = '', ylab = 'Energy Sub metering')
lines (workingData$cleanTime, workingData$Sub_metering_2, type='l', col = 'red')
lines (workingData$cleanTime, workingData$Sub_metering_3, type='l', col = 'blue')

legend("topright", legend = c ('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c ('black', 'red', 'blue'), lty=1) 

# 2,2
plot  (workingData$cleanTime, workingData$Global_reactive_power, type='l', xlab = 'datetime', ylab = 'Global_reactive_power')

dev.off() 
