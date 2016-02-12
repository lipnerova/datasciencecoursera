
#### Introduction

A **random variable** is a numerical outcome of an experiment. It can either be **discrete** or **continuous**.

A **probability distribution** is a table or an equation that links each possible value that a random variable can assume with its probability of occurrence.

Random variables are said to be iid if they are **independent and identically distributed**
+ Independent: statistically unrelated from one and another
+ Identically distributed: all having been drawn from the same population distribution

iid random variables are the default model for random samples


#### Probability Mass Functions

A PMF is associated with **discrete random variables**.

A PMF evaluated at a value corresponds to the
probability that a random variable takes that value. 

To be a valid PMF, a function must satisfy:

  1. It must always be larger than or equal to 0.
  2. The sum of the possible values that the random variable can take has to add up to one.

	
	
#### Probability Density Functions

A PDF is associated with **continuous random variables** .

_The probability distribution of a continuous random variable is represented by an equation, called the probability density function._

To be a valid PDF, a function must satisfy

1. It must be larger than or equal to zero everywhere.
2. The total area under it must be one.

_Note: With a continuous distribution, there are an infinite number of values between any two data points. 
As a result, the probability that a continuous random variable will assume a particular value is always zero._



#### Cumulative Distribution Functions

+ The CDF of a random variable X returns the probability that X is less than or equal to the value $x$
+ The Survival function of a random variable X returns the probability that X is greater than the value $x$
+ S(x) = 1 - F(x)



#### Quantiles

The  _&#945;<sup>th</sup>_ **quantile** of a distribution with distribution function _F_ is the point x<sub>&#945;</sub> where:

_F ( x<sub>&#945;</sub> ) = &#945;_

The **median** is the _50<sup>th</sup>_ percentile.



#### Expectations

Expected values are useful for characterizing a probability distribution:

- The mean is a characterization of its central tendency
- The variance and standard deviation are characterizations of its variability (how spread out it is)

Our sample expected values (the sample mean and variance) will estimate the population versions.


##### Population mean

The **mean** of a discrete random variable X is also called the **expected value** of X: **E (X)**. 
It represents the center of mass of its population.

![expValueDiscretePop](equations/expValueDiscretePop.png?raw=true)


##### Sample mean

The sample mean represents the center of the observed data. For a sample of size n:

![expValueDiscreteSample](equations/expValueDiscreteSample.png?raw=true)

The sample mean distribution (ie. the mean values of a certain number of samples) gets more 
concentrated around the population mean as the sample size increases.

Example with 10.000 die roll samples, where the sample size varies from 1 to 30 rolls.

![dieSamples](equations/dieSamples.png?raw=true)

