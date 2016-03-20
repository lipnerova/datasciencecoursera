require(devtools)
install_github('ramnathv/rCharts', 'ramnathv')

require(rCharts)

# see http://ramnathv.github.io/rCharts/

# mPlot: use morris
# rPlot: default
# pPlot: use polychart
# nPlot: use nvd3
# xPlot: use xCharts
# hPlot: use HighChart


# Example 1 Facetted Scatterplot
names(iris) = gsub("\\.", "", names(iris))
rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')

## Example 2 Facetted Barplot
hair_eye = as.data.frame(HairEyeColor)
rPlot(Freq ~ Hair | Eye, color = 'Eye', data = hair_eye, type = 'bar')


# polychart
r1 <- rPlot(mpg ~ wt | am + vs, data = mtcars, type = "point", color = "gear")
r1

# r1$print("chart1")
# graph_chart1.addHandler(function(type, e){
# var data = e.evtData;
# if (type === 'click'){
#   return alert("You clicked on car with mpg: " + data.mpg.in[0]);
# }
# })


# morris
data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
m1$set(pointSize = 0, lineWidth = 1)
m1
# m1$print("chart2")


# nvd3
hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
n1 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, type = "multiBarChart")
n1
#n1$print("chart3")


# xCharts
require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2] = c("category", "year")
x1 <- xPlot(value ~ year, group = "category", data = uspexp, type = "line-dotted")
x1
#x1$print("chart4")


# HighCharts
h1 <- hPlot(x = "Wr.Hnd", y = "NW.Hnd", data = MASS::survey, 
            type = c("line", "bubble", "scatter"), group = "Clap", size = "Age")
h1
#h1$print("chart5")


# Leaflet
map3 <- Leaflet$new()
map3$setView(c(51.505, -0.09), zoom = 13)
map3$marker(c(51.5, -0.09), bindPopup = "<p> Hi. I am a popup </p>")
map3$marker(c(51.495, -0.083), bindPopup = "<p> Hi. I am another popup </p>")
map3
#map3$print("chart7")


# RickShaw
usp = reshape2::melt(USPersonalExpenditure)
# get the decades into a date Rickshaw likes
usp$Var2 <- as.numeric(as.POSIXct(paste0(usp$Var2, "-01-01")))
p4 <- Rickshaw$new()
p4$layer(value ~ Var2, group = "Var1", data = usp, type = "area", width = 560)
# add a helpful slider this easily; other features TRUE as a default
p4$set(slider = TRUE)
p4
#p4$print("chart6")
