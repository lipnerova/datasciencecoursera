
#### Vectors - 02W1

+ R has five atomic classes of objects: ```character```, ```complex```, ```numeric```, ```integer```, ```logical```.
+ R most basic object is a ```vector```, which can only have **one class** of elements.
Mixing classes results in **coercion**. 
+ Explicit coercion: use ```as.class (vector)```. Can introduce ```NAs```
+ Implicit coercion: the default order is above, starting with ```character```

_Note: ```TRUE``` is replaced by ```"TRUE"```, ```1+0i```, ```1```, ```1L```_

+ Populating an empty vector created with ```vector (class, length)``` is faster than 
doing both tasks at once using ```x:y (for integer sequences)``` or ```c (values)```.


#### Matrices - 02W1

+ Matrices are vectors with a ```dim``` attribute, constructed column-wise
+ ```matrix(values, nrow = x, ncol = y)```
+ ```dim (vector) <- c(nrow, ncol)``` changes a vector/matrix dimensions
+ ```cbind (vector1, vector2)``` merges two vectors/matrices column-wise
+ ```rbind (vector1, vector2)``` merges two vectors/matrices row-wise

_Note: dimensions must match or R will return an error_
_Note: matrices are vectors, so are also subject to coercion_

+ ```as.vector (matrix)``` deconstruct a matrix column-wise
	
	
#### Factors - 02W1

+ Factors are integer vectors with **labels**, called ```levels```
+ ```attr (myFactor, "levels")``` returns a vector with all the unique levels
+ ```table (myFactor)``` returns the count of each level
+ ```unclass (myFactor)``` returns the numerical vector w/o levels
+ ```droplevels (myFactor)``` removes unused levels _(ex: after subsetting)_
+ ```factor (myVector)``` converts a vector into a factor

_Note: levels can be ordered by using ```table (myFactor, levels = c(level1, level2, ...))```_


#### Lists - 02W1

+ Lists are vectors that can contain elements of **different classes**
+ ```unlist (myList)``` coerces a list back to a vector


#### Data Frames - 02W1

+ Data frames are used to store tubular data
+ They are lists where every element (column) has the same length (number of rows)
+ They can be converted to matrices with ```data.matrix (myDataFrame)```


#### Names - 02W1

+ ```names (myVector / myList) <- myNamesVector```
+ ```dimnames (myMatrix) <- list (rowNamesVector, colNamesVector)```
+ ```colnames (myDataFrame) <- myNamesVector```
+ ```row.names (myDataFrame) <- myNamesVector``` _values must be unique; using NULL resets the values_

#### Dates & Times - 02W1 & 03W4

+ Dates, represented by the `Date` class, measure the number of days since 1970-01-01
+ Times, represented by the `POSIXct` and `POSIXlt` class, measure the number of seconds since 1970-01-01

  + ```POSIXct``` is a large integer
  + ```POSIXlt``` is a list that includes day of the week, day of the year, etc.

+ `strptime`, `as.Date`, `as.POSIXlt`, `as.POSIXct` can be used to coerce a string into a Date/Time format.
+ ```as.POSIXlt(date)[['year']] + 1900``` returns the year of a date

#### Subsetting - 02W1 & 03W3

+ `[`  always returns an object of the same class as the original. Can select multiple elements.
+ `[[` extracts elements from a list or data frame. 
+ `$`  extracts elements from a list or data frame, by name. 


##### Examples

+ ```myVector [posVector]``` returns a subvector
+ ```mymatrix [rowPosVector, colPosVector]``` returns a submatrix 

_Note: when subsetting a single column or a single row, using ```drop = FALSE``` will return a matrix_

+ ```myList [posVector]``` returns a sublist
+ ```myList [[posVector]]``` navigates nested elements. ```list$pos``` can be used as well.

_Note: the double bracket notation is mandatory for computed indices_


##### Conditional subsetting

+ ```myVector [logicalVector]``` returns a subvector of indices where logicalVector = TRUE
+ ```myDataFrame [logicalVector, colVector]``` returns a sub-dataframe

Removing NA values from a data frame:
+ ```> good <- complete.cases(myDataFrame)```
+ ```> myDataFrame[good, ]``` _returns a dataframe_

#### Sorting & Ordering - 03W3

+ `sort (myVector, decreasing = FALSE, na.last = NA)`
+ `myDataFrame [order (myDataFrame$myCol1, myDataFrame$myCol2), ]`
