library(plyr)
library(dplyr)
library(rMaps)
library(RColorBrewer)

stormClean <- readRDS(".\\data\\stormClean.rds")

ichoroplethCustom(Fatalities ~ State, ncuts=5, data = subset(stormSummary, year==2002), 
            pal = "PuRd", legend = TRUE)

ichoroplethCustom <- function(x, data, pal = "Blues", ncuts = 5, map = 'usa', legend = TRUE, labels = TRUE, ...){
  d <- Datamaps$new()
  fml = lattice::latticeParseFormula(x, data = data)
  data = transform(data, 
                   fillKey = cut(
                     fml$left, 
                     unique(quantile(fml$left, seq(0, 1, 1/ncuts))),
                     ordered_result = TRUE
                   )
  )
  fillColors = brewer.pal(ncuts, pal)
  d$set(
    scope = map, 
    fills = as.list(setNames(fillColors, levels(data$fillKey))), 
    legend = legend,
    labels = labels,
    ...
  )

  d$set(data = dlply(data, fml$right.name))

  return(d)
}
