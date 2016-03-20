library(dplyr)
library(pander)

# read archive (takes a while)
storm <- read.csv(".\\stormData.bz2")

# selecting fields relevant to the analysis
stormSelect <- select (storm, 
                       BGN_DATE, END_DATE, 
                       STATE, 
                       LATITUDE, LONGITUDE,
                       EVTYPE, 
                       FATALITIES, INJURIES,
                       PROPDMG, PROPDMGEXP, 
                       CROPDMG, CROPDMGEXP)

# cleaning up property damages: we count them only if they have a proper unit
stormSelect <- mutate (stormSelect,
                       propDmg = ifelse(PROPDMGEXP == "b" | PROPDMGEXP == "B", PROPDMG*10^9, 
                                  ifelse(PROPDMGEXP == "m" | PROPDMGEXP == "M", PROPDMG*10^6,
                                  ifelse(PROPDMGEXP == "k" | PROPDMGEXP == "K", PROPDMG*10^3, 0))))

# cleaning up crop damages: we count them only if they have a proper unit
stormSelect <- mutate (stormSelect, 
                       cropDmg = ifelse(CROPDMGEXP == "b" | CROPDMGEXP == "B", CROPDMG*10^9, 
                                  ifelse(CROPDMGEXP == "m" | CROPDMGEXP == "M", CROPDMG*10^6,
                                  ifelse(CROPDMGEXP == "k" | CROPDMGEXP == "K", CROPDMG*10^3, 0))))

# we drop all events that have neither fatalities nor damages
stormSelectFilter <- filter (stormSelect, 
                             FATALITIES > 0 | 
                               INJURIES > 0 |
                               propDmg > 0 | 
                               cropDmg > 0) %>% 
                     select (BGN_DATE, END_DATE,
                             STATE, 
                             LATITUDE, LONGITUDE,
                             EVTYPE, 
                             FATALITIES, INJURIES,
                             PROPDMG, PROPDMGEXP,  propDmg, 
                             CROPDMG, CROPDMGEXP, cropDmg)

# we drop all unsued levels
stormSelectFilter <- droplevels (stormSelectFilter)
levels(stormSelectFilter$EVTYPE) <- toupper(levels(stormSelectFilter$EVTYPE))
rm (stormSelect)

# we add the year for each event
BGN_DATE <- as.POSIXlt(strptime(as.character(stormSelectFilter$BGN_DATE), "%m/%d/%Y"))
#END_DATE <- as.POSIXlt(strptime(as.character(stormSelectFilter$END_DATE), "%m/%d/%Y"))
stormSelectFilter$year <- factor(BGN_DATE$year+1900)

# converting billions to millions for the CA flood of 2006
stormSelectFilter[which(stormSelectFilter$propDmg > 10^11),]$PROPDMGEXP <- "M"
stormSelectFilter[which(stormSelectFilter$propDmg > 10^11),]$propDmg <- 115*10^6

# EVTYPE list: EVTYPE levels (only 430 rows, much faster than working with the full table)
source(".\\cleanEventType.R")
EVTYPE_list <- data.frame(EVTYPE=levels(stormSelectFilter$EVTYPE))
EVTYPE_list$Event_Type <- cleanEVTYPE(EVTYPE_list$EVTYPE)

# merging the Event Type list with the main dataset
stormClean <- left_join(stormSelectFilter, EVTYPE_list, by="EVTYPE")
rm (EVTYPE_list, cleanEVTYPE, decode, decodeList, stormSelectFilter)

# converting values into factors
stormClean$Event_Type <- factor(stormClean$Event_Type)

# dropping unused columns
stormClean <- select (stormClean, 
                      year,
                      BGN_DATE, END_DATE, 
                      STATE, 
                      LATITUDE, LONGITUDE,
                      Event_Type, 
                      FATALITIES, INJURIES,
                      propDmg, 
                      cropDmg)

# changing dates
#stormClean$BGN_DATE <- BGN_DATE
#stormClean$END_DATE <- END_DATE
#rm (BGN_DATE, END_DATE)
rm (BGN_DATE)

# cleaning states
stateCode <- read.csv(".\\stateCode.csv", sep=";")
stateCode <- select(stateCode, Code, State)

t <- data.frame(table(stormClean$STATE))
names(t) <- c("Code", "Freq")

stateCodeCheck <- left_join(t, stateCode, by="Code")
stateCodeNA <- stateCodeCheck[which(is.na(stateCodeCheck$State)),]
stateCodeValid <- stateCodeCheck[which(!is.na(stateCodeCheck$State)),]

# impact of NA is negligeable
#stormNA <- stormClean[as.character(stormClean$STATE) %in% stateCodeNA$Code, ]
#round(sum(stormNA$FATALITIES)/sum(stormClean$FATALITIES)*100,2)
#round(sum(stormNA$INJURIES)/sum(stormClean$INJURIES)*100,2)
#round(sum(stormNA$propDmg)/sum(stormClean$propDmg)*100,2)
#round(sum(stormNA$cropDmg)/sum(stormClean$cropDmg)*100,2)

# remove unknown states & add state names
stormClean <- stormClean[as.character(stormClean$STATE) %in% stateCodeValid$Code, ]
stormClean <- left_join(stormClean, stateCode, by=c("STATE"="Code"))
rm (stateCode, stateCodeCheck, stateCodeNA, stateCodeValid, t)

# rename & drop factors
stormClean <- rename(stormClean, stateName=State, State=STATE, Fatalities=FATALITIES, Injuries=INJURIES)
stormClean <- droplevels (stormClean)

# remove factors
stormClean$year <- as.numeric(as.character(stormClean$year))
stormClean$State <- as.character(stormClean$State)
stormClean$BGN_DATE <- as.character(stormClean$BGN_DATE)
stormClean$END_DATE <- as.character(stormClean$END_DATE)

# creting condensed tables
stormList <- list()

# condensing Event Types
source(".\\getTop10.R")
for (harmType in c("Fatalities","Injuries","propDmg","cropDmg")) {
  stormClean <- addTop10(stormClean, harmType)
}

for (harmType in c("Fatalities","Injuries","propDmg","cropDmg")) {
  stormList[[harmType]] <- data.frame(tableTop10(stormClean, harmType))
}

rm (getTop10, addTop10, tableTop10, harmType)

# saving the data frame
saveRDS(stormClean, file="stormClean.rds")
saveRDS(stormList, file="stormList.rds")
