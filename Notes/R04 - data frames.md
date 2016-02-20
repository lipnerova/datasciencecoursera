
#### Data Frames - 02W1

+ Data frames are used to store tubular data
+ They are lists where every element (column) has the same length (number of rows)
+ They can be converted to matrices with ```data.matrix (myDataFrame)```



#### Names - 02W1

+ ```colnames (myDataFrame) <- myNamesVector```
+ ```row.names (myDataFrame) <- myNamesVector``` _values must be unique; using NULL resets the values_



#### Subsetting - 02W1 & 03W3

+ `[`  always returns an object of the same class as the original. Can select multiple elements.
+ `[[` extracts elements from a data frame. 
+ `$`  extracts elements from a data frame, by name. 

We can subset a data frame in several ways:

+ `split (myDataFrame, list (myDataFrame$var1, myDataFrame$var2))` # can be used with sapply
+ `myDataFrame [logicalVector, colVector]`
+ `myDataFrame [which(logicalVector), colVector]` exclude NA values _(`which` values are TRUE)
+ `myDataFrame [condition1 & condition2 | condition3, colVector]`
+ `myDataFrame [rowVector, ]`

_Note: if only one column, a **vector** is returned, not a data frame_

_Note: rowVector & colVector can indicate either the position index or the row/col name_
_Note: if no row/col argument, the entire set of rows/columns is returned_

Removing NA values from a data frame:
+ ```> good <- complete.cases(myDataFrame)```
+ ```> myDataFrame[good, ]``` _returns a dataframe_



#### Ordering - 03W3

+ `myDataFrame [order (myDataFrame$myCol1, myDataFrame$myCol2, na.last = TRUE, decreasing = FALSE), ]`



#### Adding rows & columns - 03W3

+ `myDataFrame$newVar <- ifelse(myDataFrame$oldVar < 0, TRUE, FALSE)`
+ `cbind (dataFrame1, dataFrame2)`
+ `rbind (dataFrame1, dataFrame2)`



#### Merging data frames - 03W3

+ `merge(df_x, df_y, by.x="col_name_x",by.y="col_name_y", all=TRUE)`

_Note: all to include x/y values missing in y/x_

#### Frequencies & Crosstabs - 03W3

_More info ([here](http://www.statmethods.net/stats/frequencies.html )_

Frequency tables:

```
mytable <- table(df$A, df$B, useNA = 'ifany') # A will be rows, B will be columns
margin.table(mytable, 1) # frequency table of A values (summed over B) 
margin.table(mytable, 2) # frequency table of B values (summed over A)

prop.table(mytable) # cell percentages
prop.table(mytable, 1) # row percentages 
prop.table(mytable, 2) # column percentages

mytable <- ftable (table(df$A, df$B, df$C) # A & B will be rows, C will be columns
``` 

Crosstabulation tables:

```
mytable <- xtabs(c(A, B)~C+D+E, data=mydata) # frequencies of A & B, summed over C,D,E
ftable(mytable) # print table 
```

#### Pivot tables as data frames

First step is to **melt** the dataframe. The columns of all measured variables will be 
converted in two columns:

+ `variable` listing the column names
+ `value` listing the value of each variable for each id.vars 

```
library (reshape2)
meltedDF <- melt(df, id.vars = idVector, measure.vars = varVector)
dcast (meltedDF, pivotVar1 ~ pivotVar2 ~ pivotVar3, aggregate.fun, value = valueColName)
```

_Note: the **aggregate function** is used when a combination of pivot variables identifies
 more than one row. Its input must be a **numeric** vector and its output must have the
 **same length** regardless of input size._

 
 
#### dplyr

Subsetting: 

```
select (df, col1name, col2name, ...)
select (df, colBeg:colEnd) 
select (df, starts_with/ends_with/one_of) 

filter (df, condition1 & condition2 | condition3)
```

Sorting & Renaming:

```
arrange (df, col1, desc (col2))
rename (df, newName1 = oldName1, newName2 = oldName2)
```

Operations on variables:

```
mutate (df, newCol = oldCol - mean (oldCol, na.rm = TRUE))
transmute (df, newCol = oldCol - mean (oldCol, na.rm = TRUE)) # same as mutate, but drops all untouced variables
```

Group by & summarize _(similar as dcast, but the aggregate functions can be different)_:

```
group_by (df, var1, var2) # creates a grouped df
summarize (grouped_df, var1 = aggregate.fun(var1), var2 = aggregate.fun(var2))
```

Pipeline: symbol `%>%`

```
mutate (df, year = as.POSIXlt(date)[['year']] + 1900) %>%
	group_by (df, year) %>%
	summarize (var1 = aggregate.fun(var1), var2 = aggregate.fun(var2))
```
