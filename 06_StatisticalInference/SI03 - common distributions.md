
### Bernoulli Distribution

A  Bernoulli random variable X can only take the values 1 (success) and 0 (failure), with probabilities of p and 1-p respectively.

Its PMF, the **Bernoulli distribution**, is:

![bernoulli](equations/bernoulli.png?raw=true)


#### Binomial trials

A **binomial random variable** are is as the sum of iid Bernoulli trials. The binomial mass function is:

![bernoulliTrials](equations/bernoulliTrials.png?raw=true)

_Note: ("n choose x") counts the number of ways of selecting x items out of n,
 without replacement and disregarding the order of the items._
 
The binomial mass function gives the probability that out of n trials, x are a success.

```r
pbinom(x, size = n, prob = 0.5, lower.tail = FALSE) #lower.tail=FALSE: P(X>x)
```


### Normal Distribution

A common notation for a random variable RV that follows a **normal** or **Gaussian distribution** is: 

![normalDist](equations/normalDist.png?raw=true)

When ![stdMu](equations/stdMu.png?raw=true) and ![stdSigma](equations/stdSigma.png?raw=true) the resulting distribution is 
called **the standard normal distribution**, often labeled _Z_.

We can easily transform any normal distribution to a standard one:

![normalToStd](equations/normalToStd.png?raw=true)


#### Quantiles

Percentile | Std deviation from the mean
----------:|:----------------------------
    1 | -2.33
  2.5 | -1.96
    5 | -1.645
   10 | -1.28
	 50 | 0
	 90 | 1.28
	 95 | 1.645
 97.5 | 1.96
   99 | 2.33



