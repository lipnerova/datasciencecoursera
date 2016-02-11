
## Data Frames - 02W1

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



##### Examples

+ ```myList [posVector]``` returns a sublist
+ ```myList [[posVector]]``` navigates nested elements. ```list$pos``` can be used as well.

_Note: the double bracket notation is mandatory for computed indices_


##### Conditional subsetting

+ ```myVector [logicalVector]``` returns a subvector of indices where logicalVector = TRUE


