
# -------------------- LOADING DATA --------------------------------------------------- #

NEI <- readRDS(".\\data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\data\\Source_Classification_Code.rds")


# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? ?


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
NEIBalt <- subset(NEI, fips == '24510')
NEIBalt.motors <- subset (NEIBalt, SCC %in% motors.SCC$SCC)
NEIBalt.motors <- merge (NEIBalt.motors, motors.SCC, by = 'SCC')

emissions <- with(NEIBalt.motors, tapply(Emissions, list(EI.Sector, year), sum))  # emissions by year by sector

# we group the sectors to have a more readable graph
group <- c ('Other', 
            'Commercial Marine Vessels', 
            'Other',
            'Other', 'Other', 'Other', 
            'On-Road Diesel Heavy Duty Vehicles',
            'Other', 'Other',
            'On-Road Gasoline Light Duty Vehicles')

emissions <- rowsum (emissions, group, na.rm = TRUE)

emissions <- as.data.frame(as.table(emissions), na.rm=TRUE) # conversion in data frame for ggplotting
names(emissions) <- c ('Sector','Year','Emissions')
emissions

# we convert years to numerics for proper ggplot display
emissions$Year <- as.numeric(sapply(emissions$Year, as.character))


# we reorder the sectors for easier plot reading (the legend order matches the graph order)
emissions$Sector <- factor(emissions$Sector, levels = c("Commercial Marine Vessels", "Other",
                                                        "On-Road Diesel Heavy Duty Vehicles", 
                                                        "On-Road Gasoline Light Duty Vehicles")) 


# plotting
library(ggplot2)

png (file = "plot5bonus.png", height=600, width = 540) 

ggplot(emissions, aes(x=Year, y=Emissions, colour=Sector)) +
  geom_line() + geom_point() +
  ggtitle('Evolution of motors-related PM2.5 emissions \nin Baltimore City from 1999 to 2008, by sector') +
  scale_x_continuous(breaks = pretty(emissions$Year, n = 10), minor_breaks = NULL) +
  theme(plot.margin = unit(c(1,3,1,1), "cm")) +
  theme(plot.title=element_text(size=20, face='bold', margin = unit(c(0,0,1,0), "cm"))) +
  theme(axis.title.x=element_text(margin = unit(c(0.5,0,0,0), "cm"))) +
  theme(axis.title.y=element_text(margin = unit(c(0,0.5,0,0), "cm"))) + ylab("PM25 emissions (in tons)") +
  theme(legend.position = "top") +
  guides(colour=guide_legend(nrow=2))


dev.off() 


  
  
