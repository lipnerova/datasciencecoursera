
# ------------------------- SETUP THE WORKING DIRECTORY ------------------------------- #

setwd('.\\myPath')



# ------------------------- INSTALL A PACKAGE IF NOT ALREADY -------------------------- #

myPackage <- 'myPackage'
if (myPackage %in% rownames(installed.packages()) == FALSE) { install.packages(myPackage) }
library (myPackage) # no string here: you have to type the package's name


# ------------------------- DOWNLOADING A FILE ---------------------------------------- #

myUrl  <- 'https://www.mysite.com/myfile.ext'
myDate <- format(Sys.time(), '%Y-%m-%d_%H-%M-%S')
myFile <- 'myFileName.ext'
myPath <- paste('.\\', myFile, '_', myDate, '.csv', sep = '')

download.file(myUrl, myFile);
download.file(myUrl, myFile, method = 'wb') # specific case for Excel files



# ------------------------- READING A FILE -------------------------------------------- #

# csv
mySep <- c (',', '\t')
read.table (myPath, sep = mySep, header = TRUE)

# excel - require 'xlsx' package
read.xlsx (myPath, sheetIndex = 1, header = TRUE)

# XML & HTML - require 'XML' package
xmlTreeParse (myPath, useInternal = TRUE)
htmlTreeParse (htmlFileUrl, useInternal = TRUE)

# JSON file - require 'jasonlite' package
myJson <- fromJSON (myFile)
myJson$myFirstNode$mySecondNestedNode

