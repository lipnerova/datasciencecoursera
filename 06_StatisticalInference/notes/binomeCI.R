n <- 100 
pvals <- seq(0.1, 0.9, by = 0.05) 
pvals
nosim <- 1000 

p1 <- pvals [1]

coverage <- sapply(pvals, function(p) {    
  phats <- rbinom(nosim, prob = p, size = n)/n               # (nosim x 1 vector) avg of successes for n binomial tests
  ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # (nosim x 1 vector) lower limit of the 95% confidence interval  
  ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # (nosim x 1 vector) upper limit of the 95% confidence interval
  mean(ll < p & ul > p)                                      # percentage of samples where the success proba is inside the CI
})


coverage2 <- sapply(pvals, function(p) {    
  phats <- (rbinom(nosim, prob = p, size = n) + 2)/(n+4)     # avg of successes for nosim samples of size n, with the Agresti/Coull interval
  ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # lower limit of the 95% confidence interval  
  ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)   # upper limit of the 95% confidence interval
  mean(ll < p & ul > p)                                      # percentage of samples where the success proba is inside the CI
})


rbinom(100, prob = 0.5, size = 5)

k <- 1000 
xvals <- seq(-5, 5, length = k) 

myplot <- function(df){  
  d <- data.frame(y = c(dnorm(xvals), dt(xvals, df)),                  
                  x = xvals,                  
                  dist = factor(rep(c("Normal", "T"), c(k,k))))  
  
  g <- ggplot(d, aes(x = x, y = y))   
  g <- g + geom_line(size = 2, aes(colour = dist))  
  g 
} 

library(manipulate)
manipulate(myplot(mu), mu = slider(1, 20, step = 1)) 


pvals <- seq(.5, .99, by = .01) 

myplot2 <- function(df){  
  d <- data.frame(n= qnorm(pvals),t=qt(pvals, df),                  
                  p = pvals)  
  g <- ggplot(d, aes(x= n, y = t))  
  g <- g + geom_abline(size = 2, col = "lightblue")  
  g <- g + geom_line(size = 2, col = "black")  
  g <- g + geom_vline(xintercept = qnorm(0.975))  
  g <- g + geom_hline(yintercept = qt(0.975, df))  
  g 
}

manipulate(myplot2(df), df = slider(1, 20, step = 1))
