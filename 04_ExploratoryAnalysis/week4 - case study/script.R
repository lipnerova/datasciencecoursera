
## setwd("~/CourseraModules/04_ExploratoryAnalysis/CaseStudy/pm25_data")

## Has fine particle pollution in the U.S. decreased from 1999 to 2012?

# -------------------- FUNCTIONS ------------------------------------------------------ #

# read data function
readpm25data <- function (filePath) {
  
  pm25data <- read.table(filePath, comment.char = "#", header = FALSE, sep = "|", na.strings = "")

  # the new lighter files have no headers, so we do not use readLines
  # cnames <- readLines(filePath, 1); print (cnames)
  
  cnames <- "State Code|County Code|Site ID|Date|Sample Value"
  cnames <- unlist (strsplit(cnames, "|", fixed = TRUE))
  
  names(pm25data) <- make.names(cnames)
  
  pm25data$Date <- as.Date(as.character(pm25data$Date), "%Y%m%d")
  
  print ('Dimensions'); print (dim(pm25data))
  print ('First rows'); print (head(pm25data))

  return (pm25data)
  
}

# sample value function


# -------------------- FIRST LOOK AT DATA --------------------------------------------- #

pm0 <- readpm25data ("..\\assets\\pm25_data\\airData1999.txt")
pm1 <- readpm25data ("..\\assets\\pm25_data\\airData2012.txt")

## reading pm25 data
x0 <- pm0$Sample.Value
x1 <- pm1$Sample.Value

## Five number summaries for both periods: mean & max are lower in 2012
summary(x1)
summary(x0)
mean(is.na(x0))  ## Are missing values important here?
sum(is.na(x1)) 
mean(is.na(x1))  ## Are missing values important here?

## Make a boxplot of both 1999 and 2012
boxplot(x0, x1)
boxplot(log10(x0), log10(x1))

## Check negative values in 'x1'
negative <- x1 < 0; negative
sum(negative, na.rm = T)
mean(negative, na.rm = T)

## Check measures dates across the year
dates <- pm1$Date; str (dates)
datesNeg <- dates[negative == TRUE & is.na(negative) == FALSE];

par (mfrow = c(1,2))
hist(dates, "month")  
hist(datesNeg, "month") 



# -------------------- ZOOM ON NEW YORK STATE ----------------------------------------- #

## Find a monitor for New York State that exists in both datasets
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")
str(site0)
str(site1)
both <- intersect(site0, site1)
print(both)

## Find how many observations available at each monitor
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)

## Choose county 63 and side ID 2008
pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
dim(pm1sub)
dim(pm0sub)

## Prepare plotting 
dates0 <- pm0sub$Date
dates1 <- pm1sub$Date

x0sub <- pm0sub$Sample.Value
x1sub <- pm1sub$Sample.Value

## Plot data for both years in same panel
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20)  ## Whoa! Different ranges
abline(h = median(x1sub, na.rm = T))

## Find global range
rng <- range(x0sub, x1sub, na.rm = T)
rng
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x1sub, na.rm = T))

## clean workspace
rm (pm0sub, dates0, x0, x0sub, pm1sub, dates1, x1, x1sub, rng, negative)



# -------------------- STATE BY STATE TREND ------------------------------------------- #

## Show state-wide means and make a plot showing trend
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = T))
str(mn0); summary(mn0)

mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = T))
str(mn1); summary(mn1)

## Make separate data frames for states / years
d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)
mrg <- merge(d0, d1, by = "state")
mrg$trend <- with(mrg, as.numeric(mean.y < mean.x) + 1)

dim(mrg)
mrg

colVector <- c ('red', 'green')

## Connect lines
par(mfrow = c(1, 1))
with(mrg, plot(rep(1, 52), mrg[, 2], xlim = c(.5, 2.5)))
with(mrg, points(rep(2, 52), mrg[, 3]))
segments(rep(1, 52), mrg[, 2], rep(2, 52), mrg[, 3], col=colVector [mrg$trend])

## clean workspace
rm (pm0, pm1, d0, d1, mn0, mn1, mrg, colVector)

