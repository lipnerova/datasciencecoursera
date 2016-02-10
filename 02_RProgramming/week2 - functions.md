
#### Scoping & Free variables

All variables used in a function but neither passed as arguments nor assigned inside the 
function body are called **free variables**.

R uses **lexical scoping**: it searches values of free variables in the environment in
which the function was defined, not in which it was called.
 
The search goes up the environment tree until the top-level environment, then down the
`search` list until the empty environment. If a value has not been found then, an error is returned.

##### Examples

```
y <- 10

f <- function (x) {
        y <- 2
        y^2 + g(x)
}

g <- function (x) {
        x*y
}
```

`f (3)` returns `34`:
+ `y^2` returns `2^2 = 4`
+ `g(x)` returns `3*10 = 30`
