
# -------------------- LOADING DATA --------------------------------------------------- #

NEI <- readRDS(".\\data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\data\\Source_Classification_Code.rds")


# Have total emissions from PM2.5 decreased inBaltimore City, Maryland (fips == "24510") from 1999 to 2008 ?


# we filter & group the data
NEIBalt <- subset(NEI, fips == '24510')
emissions <- with(NEIBalt, tapply(Emissions, list(type, year), sum))  # emissions by year by type
emissions <- as.data.frame(as.table(emissions))                       # conversion in data frame for ggplotting
names(emissions) <- c ('Type','Year','Emissions')


# we convert years to numerics for proper ggplot display
emissions$Year <- as.numeric(sapply(emissions$Year, as.character))


# we reorder the types for easier plot reading (the legend order matches the graph order)
emissions$Type <- factor(emissions$Type, levels = c("NONPOINT", "POINT", "NON-ROAD", "ON-ROAD")) 


# plotting
library(ggplot2)

png (file = "plot3.png", width = 540) 

ggplot(emissions, aes(x=Year, y=Emissions, colour=Type)) +
  geom_line() + geom_point() +
  theme(plot.margin = unit(c(1,1,1,1), "cm")) +
  ggtitle('Evolution of PM2.5 emissions in Baltimore City\n from 1999 to 2008, by source type') +
  theme(plot.title=element_text(size=20, face='bold', margin = unit(c(0,0,1,0), "cm"))) +
  theme(axis.title.x=element_text(margin = unit(c(0.5,0,0,0), "cm"))) +
  theme(axis.title.y=element_text(margin = unit(c(0,0.5,0,0), "cm"))) + ylab("PM25 emissions (in tons)") +
  scale_x_continuous(breaks = pretty(emissions$Year, n = 10), minor_breaks = NULL)

dev.off() 

