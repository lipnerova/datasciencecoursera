
## set wd
setwd('D:\\datascience\\04_ExploratoryAnalysis\\assignments\\week4')

# -------------------- LOADING DATA --------------------------------------------------- #

NEI <- readRDS(".\\data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\data\\Source_Classification_Code.rds", stringAsFactor)

## NEI file
# fips:       A five-digit number (represented as a string) indicating the U.S. county
# SCC:        The name of the source as indicated by a digit string (see source code classification table)
# Pollutant:  A string indicating the pollutant
# Emissions:  Amount of PM2.5 emitted, in tons
# type:       The type of source (point, non-point, on-road, or non-road)
# year:       The year of emissions recorded


## SCC file: provides a mapping between the SCC code & the actual source


# -------------------- FIRST LOOK AT THE DATA ----------------------------------------- #

str (NEI)
str (SCC)

str (unique (NEI$fips))
str (unique (NEI$SCC))

unique (NEI$Pollutant)
unique (NEI$type)
unique (NEI$year)

unique (SCC$EI.Sector)
unique (SCC$Option.Group)
unique (SCC$SCC.Level.One)

sapply(NEI, function(x) {sum(is.na(x))}) # no NA values

test <- subset (SCC, SCC=='10100101')
test
unique(as.character(test$Data.Category))
unique(as.character(test$Short.Name))
unique(as.character(test$EI.Sector))
unique(as.character(test$Option.Group))
unique(as.character(test$Option.Set))
unique(as.character(test$SCC.Level.One))

SCC_EI.Sector <- unique (SCC$EI.Sector)
coal <- grepl("Coal", SCC_EI.Sector)
SCC_EI.Sector [coal]
 
