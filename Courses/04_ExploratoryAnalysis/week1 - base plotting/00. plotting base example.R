
# ------------------------- GREAT RESOURCES ------------------------------------------- #

# great ressources
# https://www.datacamp.com/community/tutorials/15-questions-about-r-plots
# http://www.statmethods.net/advgraphs/layout.html



# ------------------------- GRAPHS LAYOUT --------------------------------------------- #

# creating two graphs in one plot
par (mfrow = c(2,2)) # plots are populated by rows first
par (mfcol = c(2,2)) # plots are populated by cols first

# margins (number of text rows per side - clockwise from bottom)
par ('mar' = c(4, 4, 2, 2))

# references
example (points) # plot showing pch values & symbols
colors()         # vector of colors by name

# additional graph info
title ('scatterplot')
text (-2, -2, 'label')
mtext (...)
legend ('topright', legend='Data', pch=20)
lines (...) # x, y vectirs or a 2-column matrix); this function just connects the dots
axis ()     # adding axis ticks/labels


# ------------------------- BASE EXAMPLES --------------------------------------------- #

# example
x <- rnorm (100); y <- rnorm (100); z <- rpois (100, 2)
g <- gl (2, 50, labels = c ('Male', 'Female'))

?par
par (mar = c(4, 4, 2, 2),  # graph margin
     oma = c (2,2,2,2),    # outer margins (starting from bottom)
     bg = 'lavender',      # bg color
     las = 1)              # orientation of the axis labels 

layout(matrix(c(1,2,3,4,4,5), 2, 3, byrow = TRUE), widths=c(1,1,1), heights=c(1,1))

# graph1
plot (x, y, type='n', # not showing the data yet
      main='scatterplot',
      xlab='Weight', ylab='Height')

points (x [g == 'Male'], y  [g == 'Male'],     pch = 21, col='black', bg='yellow')
points (x [g == 'Female'], y  [g == 'Female'], pch=19, col='blue')

fit <- lm (x ~ y) # line model that fits the data
abline (fit, col='blue', lwd=3) # lwd: line width

text(x+0.05,y+0.05,labels=as.character(1:12))

# graph2 - using with (x)
library(datasets)
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2, lty = 2)


# graph3
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", col = Month))
abline(h = 12, lwd = 2, lty = 2)


# graph4 - hist
hist(airquality$Ozone, breaks = 100)  ## Draw a new plot
rug (airquality$Ozone)
abline(v = 12, lwd = 2)
abline(v = median(airquality$Ozone, na.rm=TRUE), col = "magenta", lwd = 4)


# graph5 - boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")


# outer title
mtext("Mix of different graphs", outer = TRUE)


# another multiple base plot
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})



# ------------------------- OTHER EXAMPLE --------------------------------------------- #

# first lattice example
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot (Life.Exp ~ Income | region, data = state, layout = c(4, 1))


# first ggplot2 example
install.packages('ggplot2')
library(ggplot2)
qplot(displ, hwy, data = mpg)
