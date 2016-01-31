
# -------------------- LOADING DATA --------------------------------------------------- #

NEI <- readRDS(".\\data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\data\\Source_Classification_Code.rds")


# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008 ?


# we identify coal combustion-related EI Sectors
SCC_EI.Sector <- unique (SCC$EI.Sector)  # we list the EI Sectors
coal <- grepl("Coal", SCC_EI.Sector)     # we look for coal related sectors
coal.EI.Sectors <- SCC_EI.Sector [coal]  # we keep only the coal related sectors           

# we identify the SCC codes in coal related sectors & keep only the relevant columns
coal.SCC <- unique(subset (SCC, EI.Sector %in% coal.EI.Sectors))
coal.SCC <- coal.SCC [, c('SCC', 'EI.Sector')]

# we convert the SCC & EI Sectors to strings
coal.SCC$SCC <- sapply(coal.SCC$SCC, as.character)
coal.SCC$EI.Sector <- sapply(coal.SCC$EI.Sector, as.character)


# we filter & group the data
NEI.coal <- subset (NEI, SCC %in% coal.SCC$SCC)
NEI.coal <- merge (NEI.coal, coal.SCC, by = 'SCC')

emissions <- with(NEI.coal, tapply(Emissions, list(EI.Sector, year), sum))  # emissions by year by sector
emissions <- as.data.frame(as.table(emissions))                             # conversion in data frame for ggplotting
names(emissions) <- c ('Sector','Year','Emissions')
emissions

# we convert years to numerics for proper ggplot display
emissions$Year <- as.numeric(sapply(emissions$Year, as.character))


# we reorder the types for easier plot reading (the legend order matches the graph order)
emissions$Sector <- factor(emissions$Sector, levels = c("Fuel Comb - Electric Generation - Coal", 
                                                        "Fuel Comb - Industrial Boilers, ICEs - Coal", 
                                                        "Fuel Comb - Comm/Institutional - Coal")) 


# plotting
library(ggplot2)

png (file = "plot4bonus.png", height=540, width = 540) 

ggplot(emissions, aes(x=Year, y=Emissions, colour=Sector)) +
  geom_line() + geom_point() +
  theme(plot.margin = unit(c(1,3,1,1), "cm")) +
  ggtitle('Evolution of coal-related PM2.5 emissions in the US\n from 1999 to 2008, by sector') +
  theme(plot.title=element_text(size=20, face='bold', margin = unit(c(0,0,1,0), "cm"))) +
  theme(axis.title.x=element_text(margin = unit(c(0.5,0,0,0), "cm"))) +
  theme(axis.title.y=element_text(margin = unit(c(0,0.5,0,0), "cm"))) + ylab("PM25 emissions (in tons)") +
  scale_x_continuous(breaks = pretty(emissions$Year, n = 10), minor_breaks = NULL)+
  theme(legend.position="top", legend.direction='vertical')

dev.off() 

