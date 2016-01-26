
# ------------------------- SETUP THE WORKING DIRECTORY ------------------------- #

setwd('.\\cleaning_data\\week1')



# ------------------------- CSV FILES ------------------------- #


# downloading the csv file from the internet w/ download date in file name

csvFileUrl <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
csvDateDownloaded <- format(Sys.time(), '%Y-%m-%d_%H-%M-%S')
csvName <- paste('.\\cameras_', csvDateDownloaded, '.csv', sep = '')
download.file(csvFileUrl, csvName)


# loading the data

csvCameraData <- read.table (csvName, sep = ',', header = TRUE)
head (csvCameraData)



# ------------------------- EXCEL FILES ------------------------- #

# downloading the excel file from the internet w/ download date in file name
# using mode = 'wb' is mandatory on Windows. It means using binary mode

xlsxFileUrl <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD'
xlsxDateDownloaded <- format(Sys.time(), '%Y-%m-%d_%H-%M-%S')
xlsxName <- paste('.\\cameras_', xlsxDateDownloaded, '.xlsx', sep = '')
download.file(xlsxFileUrl, xlsxName, mode="wb")


# using the xlsx library to read the file (we install the package first)
# note: you must install Java for this library to work

if ("xlsx" %in% rownames(installed.packages()) == FALSE) {
  install.packages('xlsx')
}
library(xlsx)
xlsxCameraData <- read.xlsx (xlsxName, sheetIndex = 1, header = TRUE)
head (xlsxCameraData)


# reading only a part of the Excel file

colIndex <- 2:3
rowIndex <- 1:4
xlsxCameraData <- read.xlsx (xlsxName, sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)
head (xlsxCameraData)



# ------------------------- XML FILES ------------------------- #

# Working directly with the internet xml file
# using the xlm library to read the file (we install the package first)

if ("XML" %in% rownames(installed.packages()) == FALSE) {
  install.packages('XML')
}

library(XML)

xmlFileUrl <- 'http://www.w3schools.com/xml/simple.xml'

xmlDoc <- xmlTreeParse (xmlFileUrl, useInternal = TRUE)
xmlDocRootNode <- xmlRoot (xmlDoc)

# names of nodes
xmlName (xmlDocRootNode)
names (xmlDocRootNode) 

# accessing a node 
xmlDocRootNode [[1]]
xmlDocRootNode [[1]][[1]]

# extract parts of the XML file
xmlSApply (xmlDocRootNode, xmlValue)

# using XPath
xpathSApply (xmlDocRootNode, '//name', xmlValue)
xpathSApply (xmlDocRootNode, '//price', xmlValue)



# ------------------------- HTML FILES ------------------------- #

# Working directly with the internet xml file
# using the xlm library to read the file (we install the package first)

if ("XML" %in% rownames(installed.packages()) == FALSE) {
  install.packages('XML')
}

library(XML)

htmlFileUrl <- 'http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens'

htmlDoc <- htmlTreeParse (htmlFileUrl, useInternal = TRUE)

# using XPath
xpathSApply (htmlDoc, "//div[@class='score']", xmlValue)     # scores
xpathSApply (htmlDoc, "//div[@class='game-info']", xmlValue) # teams



# ------------------------- JSON FILES ------------------------- #

# Working directly with the internet xml file
# using the xlm library to read the file (we install the package first)

if ("jsonlite" %in% rownames(installed.packages()) == FALSE) {
  install.packages('jsonlite')
}

library(jsonlite)

jsonFileUrl <- 'https://api.github.com/users/jtleek/repos'

jsonData <- fromJSON (jsonFileUrl)

# working with the resulting data frame
names (jsonData)
names (jsonData$owner)
jsonData$owner$login

# converting dta into a json structure
myJson <- toJSON (iris, pretty = TRUE)
cat (myJson)

iris2 <- fromJSON (myJson)
head (iris2)

juu

# ------------------------- DATA.TABLES ------------------------- #

if ("data.table" %in% rownames(installed.packages()) == FALSE) {
  install.packages('data.table')
}

library(data.table)

DF = data.frame (x = rnorm (9), y = rep (c ('a', 'b', 'c'), each = 3), z = rnorm (9))
head (DF, 3)

DT = data.table (x = rnorm (9), y = rep (c ('a', 'b', 'c'), each = 3), z = rnorm (9))
head (DT, 3)

# shows all data.tables in memory
tables ()

# subsetting
DT [2, ]
DT [DT$y == 'a', ]

DF [c (2, 3)] # applies on COLUMNS
DT [c (2, 3)] # applies on ROWS

# perform functions in lists
DT [, list (mean(x), sum(z))]
DT [, table(y)]

# adds new column
DT [, w:=z^2]
DT [, a:=x>0]
DT

# copying a data table
# be careful: by default data.table makes a deep copy, not a shallow one
DT2 <- copy (DT)

# multiple operations at once
DT [, m:={tmp <- (x+z); log2 (tmp + 5)}]
DT

# plyr like operations
# calculating the mean of x+w for rows w/ the same a value
DT [, b:=mean(x+w), by=a]

# counting occurences of a variable
DT [, .N, by=y]

# subsetting a DT by key
DT <- data.table (x=rep(c('a', 'b', 'c'), each=100), y=rnorm(300))
setkey (DT, x)
DT ['a']

# joining two DT by key
DT1 <- data.table (x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table (x=c('a', 'b', 'dt2'), z=5:7)
setkey (DT1, x)
setkey (DT2, x)
merge (DT1, DT2)
merge (DT2, DT1)

# fast reading
big_df <- data.frame (x=rnorm(1E6), y=rnorm(1E6))
file <-tempfile()
write.table (big_df, file = file, row.names = FALSE, col.names = TRUE, sep = '\t', quote = FALSE)

# fread from data.table vs regular read.table
system.time (fread (file))
system.time (read.table (file, header = TRUE, sep = '\t'))






