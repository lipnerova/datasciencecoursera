
#### lapply & sapply - 02W3

It will **apply a function on each element of a list.**

+ `lapply (myList, FUN, ...)`: returns a list
+ `sapply (myList, FUN, ...)`: returns a vector or matrix when all computed elements have the same length

_Note: ... arguments are passed to FUN_


#### split - 02W3

It will **create subsets of a data structure using a factor or list of factors.**

```
library(datasets)
s <- split(airquality, list(airquality$Month, airquality$Day)) #returns a list of sub-dataframes
t(sapply (s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))) #returns the colmMeans for each subset as a matrix
```

#### apply - 02W3

It will **apply a function over the margins of an array.** Usually used to apply a function to the rows or columns of a matrix.

`apply (myArray, myMarginVector, myFun, ...)` 


#### tapply - 02W3

It is a **combination of `split()` and `sapply()` for vectors only.**

`tapply (myVector, myFactorList, myFun, ..., simplify = TRUE)` 

#### mapply

It is a **Multivariate version of `lapply`.**