
# -------------------- LOADING DATA --------------------------------------------------- #

NEI <- readRDS(".\\data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\data\\Source_Classification_Code.rds")


# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City VS LosAngeles County ?


# we identify motors combustion-related EI Sectors
SCC_EI.Sector <- unique (SCC$EI.Sector)  # we list the EI Sectors
motors <- grepl("Mobile", SCC_EI.Sector)     # we look for motors related sectors
motors.EI.Sectors <- SCC_EI.Sector [motors]  # we keep only the motors related sectors           

# we identify the SCC codes in motors related sectors & keep only the relevant columns
motors.SCC <- unique(subset (SCC, EI.Sector %in% motors.EI.Sectors))
motors.SCC <- motors.SCC [, c('SCC', 'EI.Sector')]

# we convert the SCC & EI Sectors to strings
motors.SCC$SCC <- sapply(motors.SCC$SCC, as.character)
motors.SCC$EI.Sector <- sapply(motors.SCC$EI.Sector, as.character)


# we filter & group the data
NEIComp <- subset(NEI, fips == '24510' | fips == '06037')
NEIComp.motors <- subset (NEIComp, SCC %in% motors.SCC$SCC)
NEIComp.motors <- merge  (NEIComp.motors, motors.SCC, by = 'SCC')

emissions <- with(NEIComp.motors, tapply(Emissions, list(fips, year), sum))  # emissions by year by county
emissionsRelative <- t(apply (emissions, 1, function(x) x/x[1]))


# plotting
png (file = "plot6.png", height=540, width = 540) 
  
  years <- seq (1999, 2008, by = 1)
  par (mar=c(2,2,3,2), oma=c(1,2,4,2))
  layout(matrix(c(1,2,3,3), ncol=2, byrow=TRUE), heights=c(6, 1))
  
  # first graph
  rng <- range(emissions[1, ], emissions[2, ])
  
  plot (colnames(emissions), emissions[1, ], ylim = rng, type='o',
        xaxt = "n",
        xlab = NA, ylab = NA)
  
  points(colnames(emissions), emissions[2, ], ylim = rng, type='o', pch=19, col='red3')
  axis (side=1, at=years); title ('in tons')
 
  # second graph
  rng <- c (0, 1.5)
  
  plot (colnames(emissionsRelative), emissionsRelative[1, ], ylim = rng, type='o',
        xaxt = "n",
        xlab = NA, ylab = NA)
  
  points(colnames(emissionsRelative), emissionsRelative[2, ], ylim = rng, type='o', pch=19, col='red3')
  axis (side=1, at=years); title ('in % of 1999 value')

  mtext(expression(bold("Evolution of motors-related PM2.5 emissions\nBaltimore City VS Los Angeles, 1999 - 2008")), outer = TRUE, cex=1.2)
  
  plot.new()
  legend (x="center", ncol=2, legend=c('Baltimore', 'Los Angeles'), lty=2, pch=c(19, 1), col=c('red3', 'black'))
  
dev.off() 



