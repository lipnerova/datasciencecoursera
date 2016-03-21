
library(RColorBrewer)

# specify local port
options(shiny.port = 8000)

# dynamic rChart resize:
# http://stackoverflow.com/questions/25371860/automatically-resize-rchart-in-shiny

# ------------------------------ PREPARING DATA --------------------------------------- #

# load DB
stormClean <- readRDS("./dataRep/stormClean.rds")
stormList <- readRDS("./dataRep/stormList.rds")

# harm types
harmTypes <- c("Fatalities"="Fatalities", 
               "Injuries"="Injuries", 
               "Property Damage"="propDmg", 
               "Crop Damage"="cropDmg")

# levels, used for the event types checkbox
harmLevels <- list()
for (harmType in c("Fatalities","Injuries","propDmg","cropDmg")) {
  harmLevels[[harmType]] <- levels(stormList[[harmType]]$eventType)
}

# colors used in the map
fillColors = brewer.pal(7, "Blues") #PuRd

# prepare tooltips beg & end
ttBgn <- "#!function(geo, data) {
return '<div class=\"hoverinfo\">' +
'<strong>' + data.stateName + '</strong><br>' +"

ttEnd <- "'</div>';}!#"
