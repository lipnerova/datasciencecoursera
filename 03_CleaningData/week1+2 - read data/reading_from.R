
# ------------------------- SETUP THE WORKING DIRECTORY ------------------------------- #

setwd('D:\\datascience\\03_CleaningData')



# ------------------------- CSV FILES ------------------------------------------------- #


# downloading the csv file from the internet w/ download date in file name

csvFileUrl <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
csvDateDownloaded <- format(Sys.time(), '%Y-%m-%d_%H-%M-%S')
csvName <- paste('.\\assets\\cameras_', csvDateDownloaded, '.csv', sep = '')
download.file(csvFileUrl, csvName)


# loading the data

csvCameraData <- read.table (csvName, sep = ',', header = TRUE)
head (csvCameraData)



# ------------------------- EXCEL FILES ----------------------------------------------- #

# downloading the excel file from the internet w/ download date in file name
# using mode = 'wb' is mandatory on Windows. It means using binary mode

xlsxFileUrl <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD'
xlsxDateDownloaded <- format(Sys.time(), '%Y-%m-%d_%H-%M-%S')
xlsxName <- paste('.\\assets\\cameras_', xlsxDateDownloaded, '.xlsx', sep = '')
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



# ------------------------- XML FILES ------------------------------------------------- #

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



# ------------------------- HTML FILES - WEBSCRAPPING --------------------------------- #

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

#another example
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//*[@class='gsc_a_c']", xmlValue)

#readLines
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

# GET from the httr package
if ("httr" %in% rownames(installed.packages()) == FALSE) {
  install.packages('httr')
  install.packages('stringi')
}

library(httr); 
html2 = GET(url)
content2 = content (html2,as="text")
parsedHtml = htmlParse (content2,asText=TRUE)
xpathSApply (parsedHtml, "//title", xmlValue)

# Accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2
names(pg2)

# using handles - authentication params are stored in a cookie for future use
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")

# more info:
# http://www.r-bloggers.com/?s=Web+Scraping
# http://cran.r-project.org/web/packages/httr/httr.pdf



# ------------------------- JSON FILES ------------------------------------------------ #

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

# ------------------------- DATA.TABLE LIBRARY ---------------------------------------- #

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



# ------------------------- MYSQL ----------------------------------------------------- #

# Data is structured in databases > tables > rows (called records)

if ("RMySQL" %in% rownames(installed.packages()) == FALSE) {
  install.packages('RMySQL')
}

library (RMySQL)

# Connecting and listing databases
ucscDb  <- dbConnect (MySQL (), user='genome', host='genome-mysql.cse.ucsc.edu')
  result <- dbGetQuery (ucscDb, 'show databases;'); 
dbDisconnect (ucscDb);
result

# Connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu", db="hg19")

  allTables <- dbListTables (hg19)
  length(allTables)
  allTables[1:5]
  
  # Get dimensions of a specific table
  dbListFields (hg19,"affyU133Plus2")
  dbGetQuery (hg19, "select count(*) from affyU133Plus2")
  
  # Read from the table
  affyData <- dbReadTable (hg19, "affyU133Plus2")
  head (affyData)
  
  # Select a specific subset
  query <- dbSendQuery (hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
  affyMis <- fetch (query); quantile (affyMis$misMatches)
  affyMisSmall <- fetch (query,n=10); dbClearResult (query);
  dim (affyMisSmall)

# Don't forget to close the connection!
dbDisconnect(hg19)


# Further resources

# RMySQL vignette:  http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
# List of commands: http://www.pantz.org/software/mysql/mysqlcommands.html
# ONLY USE SELECT - NO DELETE, NO JOIN
# A nice blog post summarizing some other commands: http://www.r-bloggers.com/mysql-and-r/



# ------------------------- HDF5 ------------------------------------------------------ #

# large datasets / large range of data types (http://www.hdfgroup.org/)
# Hierarchical data format: groups (group_header, group_symbol_table) > datasets (header, data_array)

source ("http://bioconductor.org/biocLite.R")
biocLite ("rhdf5")

library (rhdf5)

# create file
created = h5createFile (".//assets//example.h5")
created

# access a file
h5path <- ".//assets//example.h5"

# create groups
created = h5createGroup(h5path,"foo")
created = h5createGroup(h5path,"baa")
created = h5createGroup(h5path,"foo/foobaa") # subgroup of foo
h5ls(h5path) # ls-like function

# Write to groups
A = matrix (1:10,nr=5,nc=2)
h5write (A, h5path,"foo/A")

B = array (seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr (B, "scale") <- "liter"
h5write (B, h5path,"foo/foobaa/B")

df = data.frame(1L:5L, 
                seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"), 
                stringsAsFactors=FALSE)

h5write (df, h5path,"df")
h5ls(h5path)

# read data
readA = h5read(h5path,"foo/A")
readB = h5read(h5path,"foo/foobaa/B")
readdf= h5read(h5path,"df")
readdf

# Writing and reading chunks
readA
h5write(c(12,13,14),h5path,"foo/A",index=list(1:3,1)) #index: first 3 rows, first col
h5read(h5path,"foo/A")

H5close()

# Notes and further resources

# hdf5 can be used to optimize reading/writing from disc in R
# rhdf5 tutorial: http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf


