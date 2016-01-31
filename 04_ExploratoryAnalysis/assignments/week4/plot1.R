
# -------------------- LOADING DATA --------------------------------------------------- #

NEI <- readRDS(".\\data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\data\\Source_Classification_Code.rds")


# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008 ?


# we group the data
pm25year <- with(NEI, tapply(Emissions, year, sum))


# plotting
png (file = "plot1.png") 

years <- seq (1999, 2008, by = 1)

par (mar=c(5,6,5,4))
plot (names(pm25year), pm25year, type='l', lty=2,
      xaxt = "n",
      xlab = NA, ylab = 'PM25 emissions (in tons)')

points(names(pm25year), pm25year, type='p', pch=19, col='red3')

axis (side=1, at=years)
title ('Evolution of PM2.5 emissions in the US\n from 1999 to 2008')
legend ('topright', legend=c('Available Data', 'Extrapolated trend'), lty=c(0,2), pch=c(19, NA), col=c('red3', 'black'))

dev.off() 
