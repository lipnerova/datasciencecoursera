
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

+ The **complement** of an event is the event **not** occurring: **P(A')**
+ Two events are **mutually exclusive** or **disjoint** if they cannot occur at the same time.
+ The probability that Event A occurs, given that Event B has occurred, is the **conditional probability: P(A|B)**
+ The probability that **both** Event A and B occur is the **intersection** of A and B): **P(A ∩ B)**
+ The probability that Event A **or** Event B occur is the **union** of A and B: **P(A ∪ B)**
+ If the occurrence of Event A changes the probability of Event B, then they are **dependent**. Otherwise, they are **independent**.


**P(A) = 1 - P(A')**

**P(A ∩ B) = P(A) P(B|A)**

**P(A ∪ B) = P(A) + P(B) - P(A ∩ B)**


#### Conditional probability

![pAgivenB](equations/pAgivenB.png?raw=true)


If Events A and B are independent, then:

![pAgivenBindep](equations/pAgivenBindep.png?raw=true)


#### Baye's rule

+ The probability that Event A occurs, given that Event B has occurred is P(A|B)
+ The probability that Event A occurs, given that Event B has **not** occurred is P(A|B')

Knowing that, we can use the Bayer's rule to estimate the probability that Event B occurs, given that Event A has occurred:

![pBayer](equations/pBayer.png?raw=true)