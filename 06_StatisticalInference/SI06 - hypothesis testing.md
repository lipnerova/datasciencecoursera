
### Introduction

* A null hypothesis is specified that represents the status quo,
  usually labeled H_0
* The null hypothesis is assumed true and statistical evidence is required
  to reject it in favor of a research or alternative hypothesis 

* The alternative hypotheses are typically of the form <, > or <>
* Note that there are four possible outcomes of our statistical decision process

Truth | Decide | Result |
---|---|---|
H_0 | H_0 | Correctly accept null |
H_0 | H_a | Type I error |
H_a | H_a | Correctly reject null |
H_a | H_0 | Type II error |

The Type I error rate increases as the Type II rate error decreases.

* We can reject the null hypothesis if the sample mean was <, > or <> than some constant, say _C_
* Typically, _C_ is chosen so that the probability of a Type I error, &#945;, is 0.05 (or some other relevant constant)
* &#945; = Type I error rate = Probability of rejecting the null hypothesis when, in fact, the null hypothesis is correct

### General rules

The _Z_ test for H_0: &#956 = &#956_0 versus 

![zHyp](equations/zHyp.png?raw=true)
	
* Test statistic (returned value t from t.test):

![TS = \frac{\bar{X} - \mu_0}{S / \sqrt{n}}](equations/zTest.png?raw=true)

We reject the null hypothesis when 

![zHyp2](equations/zHyp2.png?raw=true)


#### Notes

* We have fixed &#945; to be low, so if we reject H_0: 
  * either our model is wrong
	* or there is a low probability that we have made an error
* We have not fixed the probability of a type II error,so we say 'Fail to reject H_0' rather than accepting H_0
* Statistical significance is no the same as scientific significance
* The region of TS values for which you reject H_0 is called the rejection region
* The probability of rejecting the null hypothesis when it is false is called *power*
* Power is a used a lot to calculate sample sizes for experiments

#### Z test and tCI

* The Z test requires the assumptions of the CLT and for n to be large enough
  for it to apply
* If n is small, then a Gossett's T test is performed exactly in the same way,
  with the normal quantiles replaced by the appropriate Student's T quantiles and
  n-1 df

