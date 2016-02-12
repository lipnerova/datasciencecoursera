
### Introduction

Asymptotics is the behavior of statistics as the sample size tends to INF.


### Law of large numbers (LLN)

The relative frequency of an event is the number of times an event occurs, divided by the total number of trials:

P(A) = ( Frequency of Event A ) / ( Number of Trials )

**Law of large numbers**, or **LLN**: 
The relative frequency of an event will converge towards its true probability 
as the number of trials increases.

An estimator is **consistent** if it converges to what you want to estimate.

+ the sample mean of iid samples is consistent for the population mean
+ the sample variance of iid samples is consistent for the population variance



### Central Limit Theorem (CLT)

> The sample mean distribution of iid variables
> will become normal, or nearly normal, as the sample size increases.

![\bar X \sim N~(\mu, \sigma^2 / n)](equations/normalCLT.png?raw=true)

Properly normalized, the distribution becomes a standard normal:

![\frac{\bar X_n - \mu}{\sigma / \sqrt{n}}~ \sim ~N(0, 1)~~when~n \gg 1](equations/CLT.png?raw=true)



### Confidence intervals (CI)

The 2.5 and 97.5 percentiles are &plusmn;1.96 standard deviations from the mean (approx. &plusmn;2).

It means that:

![P (\bar X \in [\mu \pm 2\sigma / \sqrt{n}]) = 95\%](equations/normalCI.png?raw=true)

We can deduce from it the **95% interval for &#956;:**

![\bar X \pm 2\sigma / \sqrt{n}](equations/normalCI2.png?raw=true)

It means that for each value of the sample mean, the interval above has 95% chances to contain &#956;.

_Note: for the 90% interval, you want 5% in each tail so you would use the 95th percentile = 1.645._

+ CI get narrower with less variability of the pop, and as the sample size increases
+ CI get wider as the confidence percentage decreases 

### Sample proportions

In a Bernoulli distribution with success probability p, the CI is:

![\hat p \pm z_{1 - \alpha/2}  \sqrt{\frac{p(1 - p)}{n}}](equations/bernoulliCI.png?raw=true)

Which can be approximated, for the 95% interval of p, by:

![\hat p \pm \frac{1}{\sqrt{n}}](equations/bernoulliCI2.png?raw=true)

```r
binom.test(sampleSuccessRate, sampleSize)$conf.int # returns the 95% CI for the binomial test
```

_Note: adding 2 success and 2 failures, the Agresti/Coull interval, can give better results when nn is too small._




