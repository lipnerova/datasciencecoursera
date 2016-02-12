
### Introduction

For small samples, we can apply Gosset's _t_ distribution and _t_ confidence intervals.

They take the following form, with _TQ_ a _t_ quantile:

![Est \pm TQ \times SE_{Est}](equations/tCI.png?raw=true)

The _t_ distribution has thicker tails than the normal, so the tCI is wider than
the normal CI. As the sample size increases, the it will become close to the _z_ interval.

It is centered around zero, so it is only indexed by one parameter: 
the **degrees of freedom**.


### Formula

Assuming the underlying data are iid Gaussian:

![\frac{\bar X - \mu}{S/\sqrt{n}}](equations/tDist.png?raw=true)

follows a _t_ distribution with _n-1_ degrees of freedom.

_Note: if we replaces S by &#963; it would be exactly standard normal)_Note

The tCI interval is:

![\bar X \pm t_{n-1} S/\sqrt{n}](equations/tCIdetail.png?raw=true)


### Paired _t_ confidence intervals

If we want to evaluate the before/after difference in a test population, we can apply the tCI 
to the difference vector:

```r
difference <- g2 - g1 
mn <- mean(difference); s <- sd(difference); n <- length(difference)
mn + c(-1, 1) * qt(.975, n-1) * s / sqrt(n) 
t.test(difference)
t.test(g2, g1, paired = TRUE)
```

### Independent group _t_ confidence intervals

#### Constant variance

A (1 - &#945;) * 100\% confidence interval for 	&#956;_y - 	&#956;_x is:

![\bar Y - \bar X \pm t_{n_x + n_y - 2, 1 - \alpha/2}S_p\left(\frac{1}{n_x} + \frac{1}{n_y}\right)^{1/2}](equations/tCIindep.png?raw=true)

Where the pooled variance estimator is the weighted average of S_x & S_y (weight by sample size):

![S_p^2 = \{(n_x - 1) S_x^2 + (n_y - 1) S_y^2\}/(n_x + n_y - 2)](equations/tCIindep2.png?raw=true)

```r
t.test(..., paired = FALSE)
```


#### Unequal variance

![\bar Y - \bar X \pm t_{df} \times \left(\frac{s_x^2}{n_x} + \frac{s_y^2}{n_y}\right)^{1/2}](equations/tCIunequal.png?raw=true)

Where the following degrees of freedom will give a 95% CI:

![df=\frac{\left(S_x^2 / n_x + S_y^2/n_y\right)^2}{\left(\frac{S_x^2}{n_x}\right)^2 / (n_x - 1) +\left(\frac{S_y^2}{n_y}\right)^2 / (n_y - 1)}](equations/tCIunequal2.png?raw=true)

```r
t.test(..., var.equal = FALSE)
```
