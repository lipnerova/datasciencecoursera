
#### Introduction

The **probability** of an event refers to the likelihood that the event will occur. 
The probability that an experiment results in a successful outcome (S) is:

P(S) = ( Number of successful outcomes ) / ( Total number of equally likely outcomes )



#### Law of large numbers

The relative frequency of an event is the number of times an event occurs, divided by the total number of trials:

P(A) = ( Frequency of Event A ) / ( Number of Trials )

The idea that the relative frequency of an event will converge on the probability of the event, 
as the number of trials increases, is called the **law of large numbers**.



#### Rules of probability

+ The probability of an event ranges from 0 to 1.
+ The sum of probabilities of all possible events equals 1.

Often, we want to compute the probability of an event from the known probabilities of other events. 

+ The **complement** of an event is the event not occurring. The probability that Event A will **not** occur is denoted by P(A') = 1 - P(A).
+ Two events are **mutually exclusive** or **disjoint** if they cannot occur at the same time.
+ The probability that Event A occurs, given that Event B has occurred, is called a **conditional probability**. It is denoted by the symbol P(A|B).
+ The probability that **both** Event A and B occur (**intersection** of A and B) is denoted by P(A ∩ B). If Events A and B are mutually exclusive, P(A ∩ B) = 0.
+ The probability that Event A **or** Event B occur (**union** of A and B) is denoted by P(A ∪ B).
+ If the occurrence of Event A changes the probability of Event B, then they are **dependent**. Otherwise, they are **independent**.


##### Rule of substraction

The probability that event A will occur is equal to 1 minus the probability that event A will **not** occur.
P(A) = 1 - P(A')


##### Rule of multiplication

The probability that Events A and B **both** occur is equal to the probability that Event A occurs times the probability that Event B occurs, given that A has occurred.
P(A ∩ B) = P(A) P(B|A)


##### Rule of addition

The probability that Event A **or** Event B occurs is equal to the probability that Event A occurs 
plus the probability that Event B occurs minus the probability that both Events A and B occur.
P(A ∪ B) = P(A) + P(B) - P(A ∩ B))


##### Conditional probability

The probability that Event A occurs, given that Event B has occurred, is equal to the probability that **both** Event A and B occur, 
divided by the probability that Event B occur.

![pAgivenB](equations/pAgivenB.png?raw=true)


If Events A and B are independent, then:

![pAgivenBindep](equations/pAgivenBindep.png?raw=true)


##### Baye's rule

+ The probability that Event A occurs, given that Event B has occurred is P(A|B)
+ The probability that Event A occurs, given that Event B has **not** occurred is P(A|B')

Knowing that, we can use the Bayer's rule to estimate the probability that Event B occurs, given that Event A has occurred:

![pBayer](equations/pBayer.png?raw=true)


A **random variable** is a numerical outcome of an experiment. 

#### Probability Mass Functions

A PMF is associated with **discrete random variables**.

A PMF evaluated at a value corresponds to the
probability that a random variable takes that value. 

To be a valid PMF, a function must satisfy:

  1. It must always be larger than or equal to 0.
  2. The sum of the possible values that the random variable can take has to add up to one.

	
	
#### Probability Density Functions

A PDF is associated with **continuous random variables** .

*The area under a PDF correspond to probabilities for that random variable*

To be a valid PDF, a function must satisfy

1. It must be larger than or equal to zero everywhere.
2. The total area under it must be one.



#### Cumulative Distribution Functions

+ The CDF of a random variable X returns the probability that X is less than or equal to the value $x$
+ The Survival function of a random variable X returns the probability that X is greater than the value $x$
+ S(x) = 1 - F(x)



#### Quantiles

The  _&#945;<sup>th</sup>_ **quantile** of a distribution with distribution function _F_ is the point x<sub>&#945;</sub> where:

_F ( x<sub>&#945;</sub> ) = &#945;_

The **median** is the _50<sup>th</sup>_ percentile.



#### Conditional Probabilities

![pAuB](equations/pAuB.png?raw=true)
It can be used to estimate properties of a population based on sample data.
