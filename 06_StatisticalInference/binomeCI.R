n <- 100 
pvals <- seq(0.1, 0.9, by = 0.05) 
pvals
nosim <- 1000 

p1 <- pvals [1]

coverage <- sapply(pvals, function(p) {    
  phats <- rbinom(nosim, prob = p, size = n)/n               # avg of nosim samples of size n, where success proba = p
  ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # lower limit of the 95% confidence interval  
  ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # upper limit of the 95% confidence interval
  mean(ll < p & ul > p)                                      # percentage of samples where the success proba is inside the CI
})


coverage2 <- sapply(pvals, function(p) {    
  phats <- (rbinom(nosim, prob = p, size = n) + 2)/(n+4)     # avg of nosim samples of size n, where success proba = p, with the Agresti/Coull interval
  ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # lower limit of the 95% confidence interval  
  ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # upper limit of the 95% confidence interval
  mean(ll < p & ul > p)                                      # percentage of samples where the success proba is inside the CI
})


rbinom(100, prob = 0.5, size = 5)
