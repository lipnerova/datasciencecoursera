
#========================================================================================
#                                                                                       #
# This is a transcript of the 'dplyr' chapter of the book r_programming                 #
# by Roger D. Peng. The full book is available here: https://leanpub.com/rprogramming   #
#                                                                                       #
#========================================================================================



# ---------- SETUP THE WORKING DIRECTORY ---------------------------------------------- #

# setup the working directory
setwd('.\\02_RProgramming')

# install dplyr
myPackage <- 'dplyr'
if (myPackage %in% rownames(installed.packages()) == FALSE) { install.packages(myPackage) }
library (dplyr)


# ---------- FIRST GLANCE ------------------------------------------------------------- #

# load the file
chicago <- readRDS ("assets/chicago.rds")
head (chicago)

# display dim sizes
dim (chicago)

# display the structure
str (chicago)



# ---------- SELECT: SUBSETTING COLUMNS ----------------------------------------------- #

# subset only some columns
subset <- select (chicago, city:dptp)
head (subset)

# subset excluding some columns
subset <- select (chicago, -(city:dptp))
head (subset)

# subset with patterns
subset <- select (chicago, ends_with (2))
head (subset)

subset <- select (chicago, starts_with ('d'))
head (subset)

subset <- select (chicago, one_of ('city', 'date', 'o3tmean2'))
head (subset)

subset <- select (chicago, city, date, o3tmean2)
head (subset)


# ---------- FILTER: SUBSETTING ROWS -------------------------------------------------- #

# keeping only rows matching the condition
chic.f <- filter (chicago, pm25tmean2 > 30)
str (chic.f) 
summary (chic.f$pm25tmean2)

# filtering on multiple criteria then selecting a few columns
chic.f <- v
select(chic.f, date, tmpd, pm25tmean2) 



# ---------- ARRANGE: SORTING ROWS ---------------------------------------------------- #

# sort by date
chicago <- arrange (chicago, date)

# display the first & last 3 rows of the sorted table (only columns date & pm25tmean2)
head (select (chicago, date, pm25tmean2), 3) 
tail (select (chicago, date, pm25tmean2), 3) 

# sort by descending order - date
chicago <- arrange (chicago, desc (date))

head (select (chicago, date, pm25tmean2), 3) 
tail (select (chicago, date, pm25tmean2), 3) 



# ---------- RENAME ------------------------------------------------------------------- #

# showing the head of the first 5 columns
head (chicago[, 1:5], 3) 

# renaming two columns with more explicit names
chicago <- rename (chicago, dewpoint = dptp, pm25 = pm25tmean2) 



# ---------- MUTATE: MAKE OPERATIONS ON VARIABLES ------------------------------------- #

# removing the pm25 mean to have an easy read of the variations from the mean
chicago <- mutate (chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(chicago) 

# transmute is the same as mutate, but drops all the non-transformed variables
head(transmute (chicago,
                pm10detrend = pm10tmean2 - mean (pm10tmean2, na.rm = TRUE), 
                o3detrend = o3tmean2 - mean (o3tmean2, na.rm = TRUE))) 



# ---------- GROUP BY + SUMMARIZE ----------------------------------------------------- #

# adding year based on date
head (chicago)
chicago <- mutate (chicago, year = as.POSIXlt(date)[['year']] + 1900)

# creating a separate data frame
years <- group_by (chicago, year)
head (years)

# annual averages of pm25, o3, and no2. 
summarize (years, 
           pm25 = mean(pm25, na.rm = TRUE),
           o3 = max(o3tmean2, na.rm = TRUE),
           no2 = median(no2tmean2, na.rm = TRUE)) 


# average levels of ozone (o3) and nitrogen dioxide (no2) within quintiles of pm25

# new quantile variable
qq <- quantile (chicago$pm25, seq (0, 1, 0.2), na.rm = TRUE)
chicago <- mutate(chicago, pm25.quint = cut (pm25, qq))
head (filter (chicago, is.na(pm25) == FALSE))

#  group the data frame by the pm25.quint variable.
quint <- group_by (chicago, pm25.quint)

# compute the mean of o3 and no2 within quintiles of pm25
summarize(quint, 
          o3 = mean(o3tmean2, na.rm = TRUE),
          no2 = mean(no2tmean2, na.rm = TRUE)) 


# From the table, it seems there isn't a strong relationship between pm25 and o3
# but there appears to be a positive correlation between pm25 and no2.



# ---------- PIPELINE %>% ------------------------------------------------------------- #

# Once you travel down the pipeline with %>%, 
# the first argument is taken to be the output of the previous element in the pipeline. 

# using the pipeline with the example above

qq <- quantile (chicago$pm25, seq (0, 1, 0.2), na.rm = TRUE)

mutate (chicago, pm25.quint = cut(pm25, qq)) %>%
  group_by (pm25.quint) %>%
  summarize (o3 = mean (o3tmean2, na.rm = TRUE), 
             no2 = mean (no2tmean2, na.rm = TRUE)) 


# computing the average pollutant level by month
mutate (chicago, month = as.POSIXlt(date)[['mon']] + 1) %>%
  group_by (month) %>%
  summarize (pm25 = mean(pm25, na.rm = TRUE),
             o3 = max(o3tmean2, na.rm = TRUE),
             no2 = median(no2tmean2, na.rm = TRUE)) 




