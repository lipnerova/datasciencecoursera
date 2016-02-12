
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

When &#956; = 0 and &#963; = 1 the resulting distribution is 
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
	 16 | -1
	 50 | 0
	 84 | 1
	 90 | 1.28
	 95 | 1.645
 97.5 | 1.96
   99 | 2.33

	 
```r
pnorm (1, mean = 0, sd = 1) # returns 0.84
qnorm (0.9, mean = 0, sd = 1) # returns 1.28
```


### Poisson distribution

> The Poisson Distribution expresses the probability of a given number of events
> occurring in a fixed interval of time and/or space, if these events occur
> with a known average rate and independently of the time since the last event.

> The Poisson distribution can also be used for the number of events in other
> specified intervals such as distance, area or volume.

_source: [wikipedia](https://en.wikipedia.org/wiki/Poisson_distribution)_

#### Poisson mass function

![poissonDist](equations/poissonDist.png?raw=true)

* &#955; is the average number of events in an interval
* The mean is &#955;
* The variance is &#955;
* The function is defined only at integer values, from 0 to INF

![Poisson_pmf](equations/Poisson_pmf.png?raw=true)

#### Poisson Cumulative distribution function

![Poisson_cdf](equations/Poisson_cdf.png?raw=true)

#### Use case

The Poisson Distribution can be used to model rates. 

![poissonUse](equations/poissonUse.png?raw=true)

```r
ppois (x, lambda * t) # proba to have x events or less during t
```

