require(dplyr)
require(rCharts)

stormList <- readRDS(".\\data\\stormList.rds")

df <- group_by(stormList[[1]], year) %>%
  summarize(harmValue = sum(harmValue))

df <- data.frame (df)
df$year <- as.character(df$year)
str(df)

p2 <- nPlot(harmValue ~ year, type = 'historicalBarChart', data = df)
p2

p2$addParams(dom = 'chart3')
p2

# ------------------------------ PREPARING DATA --------------------------------------- #


#dat <- get_gdoc(durl)
dat <- read.csv(".\\data\\data.csv")

dat2 <- reshape(dat, varying = names(dat)[2:35], direction = 'long', timevar = "year")
dat2m <- reshape2::melt(dat2, id = c(1:3, 6))
dat2m <- na.omit(transform(dat2m, value = as.numeric(as.character(value))))
names(dat2m) <- c('country', 'countrycode', 'year', 'id', 'gender', 'value')

COUNTRY = "France"
country = subset(dat2m, country == COUNTRY)
p2 <- rPlot(value ~ year, color = 'gender', type = 'line', data = country)
p2
#p2$guides(y = list(min = 0, title = ""))
#p2$guides(y = list(title = ""))
p2$addParams(height = 300, dom = 'chart2')
p2
