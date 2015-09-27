Class 1
========================================================
author: 
date: 

---
output: html_document
---
Advanced Statistics
========================================================
author: Bernhard Angele 
date: Class 1, October 1st, 2015 (recap)

What did we do on Thursday?
========================================================
- We did a quick overview of probability as you will have encountered it in school
- We have generated some data using dice and coins.
- We used those data to explore descriptive statistics
  - Measures of central tendency such as *mean* and *median*
  - Measures of disperson or variability such as variance and standard deviation


What is advanced about these statistics?
========================================================

- Goal is for you to understand the principles, not just the steps.
- Simulation approach:
  - If you don't know how something about a statistical test, simulate it!
  - Example questions you might ask:
    - What is the power of this test?
    - What happens if I violate the normality assumption for an ANOVA?
    - What happens if I don't correct for multiple comparisons?
  

How do I run simulations?
========================================================

- Not very easy in SPSS
- But Excel can help (to some degree..)
- For more detailed simulations, you'll have to use a programming language such as R, Python, C++, etc.

Maths basics: Summation
========================================================
- The summation operator $\Sigma$:
$$x_1 + x_2 + x_3 + x_4 + x_5 = \sum\limits_{i=1}^5{x_i}$$
- This means: beginning with $i=1$ and ending with $i=5$ sum over the variables $x_i$.
    - This can save a lot of space if you are summing over lots of variables
    - $i$ is called the *index* over which you are summing, and $1$ and $5$ are the limits.
- If the limits are clear from the context, you can also write this as

$$\sum\limits_{i}{x_i}$$

Maths basics: Summation
========================================================
- The summation operator $\Sigma$:
$$x_1 + x_2 + x_3 + x_4 + x_5 = \sum\limits_{i=1}^5{x_i}$$
- This means: beginning with $i=1$ and ending with $i=5$ sum over the variables $x_i$.
    - This can save a lot of space if you are summing over lots of variables
    - $i$ is called the *index* over which you are summing, and $1$ and $5$ are the limits.
- If the limits are clear from the context, you can also write this as

$$\sum\limits_{i}{x_i}$$

Maths basics: Summation (2)
========================================================
- You can have multiple multiple indeces and sum over them (e.g. if you have multiple people in multiple groups, which is something that happens in Psychology *ALL THE TIME*). For example:

Group 1 (females): $x_{11},  x_{12},  x_{13},  x_{14}$

Group 2 (males):  $x_{21},  x_{22},  x_{23},  x_{24}$

Sum of all the individuals in all the groups:

$$
\begin{aligned}
\prod\limits_{m=1}^{2}\prod\limits_{x=1}^{4}{x_{mi}} = x_{11}+x_{12}+x_{13}+x_{14} \\
  + x_{21} + x_{22} + x_{23} + x_{24}
\end{aligned}
$$

Maths basics: Multiplication
========================================================
- The product symbol $\Pi$:
- Works just like the summation symbol:
$$x_1 \cdot x_2 \cdot x_3 \cdot x_4 \cdot x_5 = \prod\limits_{i=1}^5{x_i}$$
- This means: beginning with $i=1$ and ending with $i=5$ calculate the product over the variables $x_i$.

$$
\begin{aligned}
\prod\limits_{m=1}^{2}\prod\limits_{x=1}^{4}{x_{mi}} = x_{11}\cdot x_{12}\cdot x_{13}\cdot x_{14} \\
  \cdot x_{21} \cdot x_{22} \cdot x_{23} \cdot x_{24}
\end{aligned}
$$

Maths basics: Probability
========================================================
- What is probability

Maths basics: Expected values
========================================================
- Random variables have expected values
- For discrete random variables, the expected value is the outcome value multiplied by the probability of the outcome:
$$ E(X) = \sum\limits_{i=1}^k p(x_i)\cdot x_i$$
  - where $E(X)$ is the expected value of a discrete random variable $X$ with the outcomes $(x_1 \dots x_k)$ and the associated probabilities $(p(x_1)\dots p(x_k))$


Maths basics: Expected values (2)
========================================================
- For example, the expected value of rolling a six-sided die is:
$$
\begin{aligned}
E(X) &= \sum\limits_{i=1}^{6} p(x_i) \cdot x_i \\
    &= x_1 \cdot p(x_1) + x_2 \cdot p(x_2) + x_3 \cdot p(x_3) + x_4 \cdot p(x_4) \\ 
    &+ x_5 \cdot p(x_5) + x_6 \cdot p(x_6) \\
    &= 1 \cdot \frac{1}{6} + 2 \cdot \frac{1}{6} + 3 \cdot \frac{1}{6} + 4 \cdot \frac{1}{6} \\ 
    &+ 5 \cdot \frac{1}{6} + 6 \cdot \frac{1}{6} \\
    &= \frac{21}{6} = 3.5
\end{aligned}
$$

Maths basics: Computing expected values
========================================================
- The expected value of a random variable is often also called $\mu$:
$$E(X) = \mu$$
  - $\mu$ is also called the distribution *mean*
- What if the expected value is constant across all the possible outcomes?
  - e.g what is the expected value of a die with 1 on all sides? 
      - 1, of course!
- More general:
  - if the value is the same across all outcomes, we can call it a constant
  - e.g. if $x_1 = x_2 = x_3 = \dots = x_i = 1$
      - then $E(X) = E(1) = 1$

Maths basics: Computing expected values (2)
=======================================================
Even more general: If a is a constant, then $E(a) = a$
- If $X$ is a random variable and $a$ is a constant, what is the expected value of $a \cdot X$?
$$E(a\cdot X) = a \cdot E(X)$$
- For example, if the expected value of rolling a 6-sided die is 3.5, what is the expected value of rolling a 6-sided die and then multiplying the number of spots by 3?
$$ E(3\cdot X) = 3\cdot E(X) = 3\cdot 3.5 = 10.5$$
- Try it if you don't believe me!

Maths basics: Computing expected values (3)
=======================================================
- If $X$ is a random variable and $a$ is a constant, what is the expected value of $a + X$?
$$E(a + X) = a + E(X)$$
- For example, if the expected value of rolling a 6-sided die is 3.5, what is the expected value of rolling a 6-sided die and then adding 3 to the number of spots?
$$ E(3 + X) = 3 + E(X) = 3 + 3.5 = 6.5$$
- Try it if you still don't believe me!

Maths basics: Computing expected values (4)
=======================================================
- If $X$ is a random variable and $Y$ is a random variable, what is the expected value of $X + Y$?
$$E(X + Y) = E(X) + E(Y)$$
- For example, if the expected value of rolling two 6-sided dice and adding the two results?
$$ E(X + Y) = E(X) + E(Y)= 3.5 + 3.5 = 7$$
- Try it if you still don't believe me!

Maths basics: Computing expected values (5)
=======================================================
- If $X$ is a random variable and $Y$ is a random variable, what is the expected value of $X \cdot Y$?
$$E(X \cdot Y) = E(X) \cdot E(Y)$$
- But *ONLY* if $X$ and $Y$ are *INDEPENDENT*
- For example, if the expected value of rolling two 6-sided dice and multiplying the two results?
$$ E(X + Y) = E(X) \cdot E(Y)= 3.5 \cdot 3.5 = 12.25$$
- Try it if you still don't believe me!

The expected value of the sample mean
========================================================
- If $X$ is a random variable, and we take a sample of size $n$ from $X$, what is the expected value of the mean of that sample?
- Remember, this is how you compute the sample mean: 
$$\bar{x} = \frac{\sum\limits_{i=1}^{n}}{n}$$
- The expected value of the sample mean is:
$$
\begin{aligned}
E(\bar{X}) &= E\Bigg(\frac{\sum\limits_{i=1}^{n}}{n}\Bigg)\\
           &= \frac{1}{n}\cdot\big(E\sum\limits_{i=1}^n{X_i}\big)
\end{aligned}$$

The expected value of the sample mean (2)
========================================================
$$
\begin{aligned}
           &= \frac{1}{n}\cdot\big(E\sum\limits_{i=1}^n{X_i}\big) \text{ (since } E(a\cdot X) = a \cdot E(X)\text{)} \\
           &= \frac{1}{n}\cdot\sum\limits_{i=1}^n{E(X_i)} \text{ (since } E(X+Y) = E(X) + E(Y)\text{)} \\
           &= \frac{1}{n}\cdot\sum\limits_{i=1}^n{\mu_x} \text{ (since } E(X) = \mu \text{)} \\
           &= \frac{1}{n}\cdot n \cdot\mu_x = \mu_x
\end{aligned}$$


The expected value of the sample mean (3)
========================================================
- We just found that the expected value of the sample mean $E(\bar{X})$ is identical to the population mean $\mu_x$, *regardless of the sample size*.
- We can say that the sample mean $\overline{X}$ is an *unbiased estimator* of the population mean $\mu$
- No matter what we do and what crazy population we're taking samples of, the sample means will always be distributed around the true population mean.
    - *Isn't that cool?*
    - I know what you're thinking right now, but this is *actually* cool. Just think about it: If you want to know the true population mean of any population, all you have to do is take enough samples.

The expected value of the sample variance
========================================================
- OK, now we want to know how the variance of your samples ($s^2$) is related to the population variance $\sigma^2$.
- Remember that the variance of a sample is
$$ s^2 = \frac{\sum\limits_{i=1}^{n}(x_i - \bar{x})^2}{n}$$
- We can rewrite this as:
$$
\begin{aligned}
s^2 &= \frac{\sum\limits_{i=1}^{n}(x_i - \bar{x})^2}{n} = \frac{\sum\limits_{i=1}^{n}(x_i^2 - 2\cdot x_i + \bar{x})^{2}}{n}\\
    &=\frac{\sum\limits_{i=1}^{n}x_i^2 - 2\cdot \bar{x} \cdot\sum\limits_{i=1}^{n}x_i + \bar{x}^{2}}{n}
\end{aligned}
$$

The expected value of the sample variance (2)
========================================================
- Further rewriting: Since $\sum\limits_{i=1}^{n} x_i = n \cdot \bar{x}$ :
$$
\begin{aligned}
s^2 &=\frac{\sum\limits_{i=1}^{n}x_i^2 - 2\cdot \bar{x} \cdot\sum\limits_{i=1}^{n}x_i + \bar{x}^{2}}{n}\\
    &= \frac{\sum\limits_{i=1}^{n}x_i^2 - 2\cdot \bar{x} \cdot n \cdot \bar{x} + \bar{x}^{2}}{n}\\
    &= \frac{\sum\limits_{i=1}^{n}x_i^2 - n\cdot \bar{x}^2}{n} = \frac{\sum\limits_{i=1}^{n}x_i^2}{n} - \bar{x}^2
\end{aligned}
$$

The expected value of the sample variance (3)
========================================================
- Now we can calculate the expected value of $s^2$:
$$
\begin{aligned}
E(S^2) &= E\Bigg(\frac{\sum\limits_{i=1}^{n}X_i^2}{n} - \bar{X}^2\Bigg) \\
       &= E\Bigg(\frac{\sum\limits_{i=1}^{n}X_i^2}{n}\Bigg) - E(\bar{X}^2) \\
       &= \frac{\sum\limits_{i=1}^{n}E(X_i^2)}{n} - E(\bar{X}^2) = \frac{n\cdot E(X_i^2)}{n}-E(\bar{X}^2)
\end{aligned}
$$

The expected value of the sample variance (4)
========================================================
- And $\frac{n\cdot E(X_i^2)}{n}-E(\bar{X}^2)$ of course simplifies to $E(X_i^2)-E(\bar{X}^2)$
- So, now we have to figure out what $E(X_i^2)$ and $E(\bar{X}^2)$ are.
- The easiest way to do this is to start with the population variance $\sigma^2$ and the variance of the sample means $\sigma_{\bar{x}}^2$

The expected value of the sample variance (5)
========================================================
- We can define the population variance as $\sigma^2 = E(X_i - \mu)^2$, the expected value of the squared deviations of $X$ from the population mean $\mu$
- Let's rewrite this:
$$
\begin{aligned}
\sigma^2 &= E(X_i - \mu)^2 = E(X_i^2 - 2X_i\mu + \mu^2) \\
         &= E(X_i^2) - E(2X_i\mu) + E(\mu^2)\\
         &= E(X_i^2) - 2\mu E(X_i) + \mu^2
\end{aligned}
$$
since $\mu$ is a constant (and $\mu^2$ is too, of course).

The expected value of the sample variance (6)
========================================================
Continuing from previous slide:
- We already determined that $\mu = E(X)$, so:
$$
\begin{aligned}
\sigma^2 &= E(X_i^2) - 2\mu E(X_i) + \mu^2 \\
         &= E(X_i^2) - 2\mu^2 + \mu^2 = E(X_i^2) - \mu^2 
\end{aligned}
$$
- Solving for $E(X_i^2)$:
$$\begin{aligned}
\sigma^2 &= E(X_i^2) - \mu^2  \\
&\Leftrightarrow E(X_i^2) = \sigma^2 + \mu^2
\end{aligned}
$$
- OK, so now we know that the expected value of a squared random variable is equal to the sum of the population variance $\sigma^2$ and the square of the population mean $\mu^2$.

The expected value of the sample variance (7)
========================================================
- Next up: the variance of sample means $\sigma_{\bar{x}}^2$
    - This is the square of the *standard error* of the mean $\sigma_{\bar{x}}$
- We can define the variance of sample means as $\sigma_{\bar{x}}^2 = E(\bar{X} - \mu)^2$, i.e. the expected value of the squared deviations of the sample means from the true population mean
- We can rewrite this just like we did for the sample variance (this works exactly the same as before; if you are bored, you can skip the next two slides).

The expected value of the sample variance (7a)
========================================================
- We can define the variance of the sample means as $\sigma_{\bar{x}}^2 = E(\bar{X} - \mu)^2$
- Let's rewrite this:
$$
\begin{aligned}
\sigma^2 &= E(\bar{X} - \mu)^2 = E(\bar{X}^2 - 2\bar{X}\mu + \mu^2) \\
         &= E(\bar{X}^2) - E(2\bar{X}\mu) + E(\mu^2)\\
         &= E(\bar{X}^2) - 2\mu E(\bar{X}) + \mu^2
\end{aligned}
$$
since $\mu$ is a constant (and $\mu^2$ is too, of course).

The expected value of the sample variance (7b)
========================================================
Continuing from previous slide:
- We already determined that $\mu = E(\bar{X})$, so:
$$
\begin{aligned}
\sigma_{\bar{x}}^2 &= E(\bar{X}^2) - 2\mu E(\bar{X}) + \mu^2 \\
         &= E(\bar{X}^2) - 2\mu^2 + \mu^2 = E(\bar{X}^2) - \mu^2 
\end{aligned}
$$
- Solving for $E(\bar{X}^2)$:
$$\begin{aligned}
\sigma_{\bar{x}}^2 &= E(\bar{X}^2) - \mu^2  \\
&\Leftrightarrow E(\bar{X}^2) = \sigma_{\bar{x}}^2 + \mu^2
\end{aligned}
$$
- OK, so now we know that the expected value of the squared mean of  a random variable is equal to the sum of the variance of the sample means $\sigma_{\bar{x}}^2$ and the square of the population mean $\mu^2$.

The expected value of the sample variance (8)
========================================================
- Plugging $E(X_i^2) = \sigma^2 + \mu^2$ and $E(\bar{X}^2) = \sigma_{\bar{x}}^2 + \mu^2$ into our term for the expected value of the sample variance:
$$
\begin{aligned}
E(S^2) &= E(X_i^2)-E(\bar{X}^2) = \sigma^2 + \mu^2 - (\sigma_{\bar{x}}^2 + \mu^2) \\
       &= \sigma^2 - \sigma_{\bar{x}}^2
\end{aligned}
$$ 
- In words: the expected value of the sample variance is equal to the population variance minus the variance of the sample means.
    - This means that the sample variance *systematically* underestimates the population variance
    - The sample variance is *NOT* an unbiased estimator of the population variance.

What is a probability distribution?
========================================================
From Wikipedia:
In probability and statistics, a probability distribution assigns a probability to each measurable subset of the possible outcomes of a random experiment, survey, or procedure of statistical inference.

Here's an example of a discrete probability distribution:

![Dice Distribution (from Wikipedia)](https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Dice_Distribution_%28bar%29.svg/512px-Dice_Distribution_%28bar%29.svg.png)

Discrete probability distribution
========================================================
![Dice Distribution (from Wikipedia)](https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Dice_Distribution_%28bar%29.svg/512px-Dice_Distribution_%28bar%29.svg.png)

Every possible outcome (sum of the numbers rolled on two dice) is assigned a corresponding probability. This is called a *probability mass function*.

Important: all values sum to 1.

Continuous probability distribution
=======================================================
![plot of chunk unnamed-chunk-1](Class 1-figure/unnamed-chunk-1-1.png) 

Here, the outcomes are continuous, so it doesn't make sense to ask about the probability of any point on the x-axis.

- What is the probability of x = 1? 
 - What do you mean by "1"? Does 1.00001 still qualify as 1?
- It makes more sense to ask these questions about intervals.
- Important: the total area under the curve is 1.

Normal probability density function (PDF)
========================================================
$$
  f(x,\mu,\sigma) = \frac{1}{\sigma \sqrt{2 \pi}} e^{-((x - \mu)^2/2 \sigma^2)}
$$

With $x$ = value, 
$\mu$ = mean, 
and $\sigma$ = standard deviation
![plot of chunk unnamed-chunk-2](Class 1-figure/unnamed-chunk-2-1.png) 

Defining the normal PDF by hand (just in case you wanted to make sure)
========================================================
$$
  f(x,\mu,\sigma) = \frac{1}{\sigma \sqrt{2 \pi}} e^{-((x - \mu)^2/2 \sigma^2)}
$$

```r
dnorm_manual <- function(x, mu = 0, sigma = 1) {1/(sigma*sqrt(2*pi)) * exp(-((x-mu)^2/2*sigma^2))}
plot(function(x) dnorm_manual(x), -3, 3,
main = "Normal density",ylim=c(0,.4),
ylab="density",xlab="X")
```

![plot of chunk unnamed-chunk-3](Class 1-figure/unnamed-chunk-3-1.png) 

Asking reasonable questions about continuous distributions
=======================================================
- What's the probability of x being between 0 and 1?

![plot of chunk unnamed-chunk-4](Class 1-figure/unnamed-chunk-4-1.png) 

- How do we do this?
- We could integrate!
  - But there's a more convenient way in R.
  
Using `pnorm`
=======================================================
- `pnorm(q)` gives you the probability of `x < q` (in the standard normal distribution)

```r
pnorm(1)
```

```
[1] 0.8413447
```
![plot of chunk unnamed-chunk-6](Class 1-figure/unnamed-chunk-6-1.png) 
- `pnorm(1)` is not quite what we wanted yet.

Using `pnorm` (2)
=======================================================
- What about `pnorm(0)`?

```r
pnorm(0)
```

```
[1] 0.5
```
![plot of chunk unnamed-chunk-8](Class 1-figure/unnamed-chunk-8-1.png) 
Well, look at that!

Finally getting our area under the curve
========================================================
- I hope you can guess how to do it now:

```r
pnorm(1)-pnorm(0)
```

```
[1] 0.3413447
```
![plot of chunk unnamed-chunk-10](Class 1-figure/unnamed-chunk-10-1.png) 
- Success!

Things you can do with this knowledge
========================================================
- Say I'm looking at random numbers from a standard normal distribution:

```r
rnorm(5)
```

```
[1] -1.1297485 -0.8449843 -0.7108758 -0.3742611 -0.9118679
```
- and I see that one of them is 4.
  - That seems very unusual
  - Just how unusual?
    - What's the probability of getting a value of 4 when sampling from a standard normal distribution (mean = 0, sd = 1)?    

Just how unusual is a value of 4?
========================================================
- Remember, when you have a continuous distribution, you can't think about point values (e.g. 5). Rather, what you want to know is:
    - What is the probability of getting a value of 4 *or greater*?

```r
print(pnorm(4), digits = 5)
```

```
[1] 0.99997
```
- Is that the probability? No, that's the probability of getting a value of 4 *or less*
- Just get the inverse probability:

```r
1 - pnorm(4)
```

```
[1] 3.167124e-05
```

Why do we care about the normal distribution?
========================================================
- Central limit theorem (CLT)

> When sampling from a population that has a mean, provided the sample size is large
> enough, the sampling distribution of the sample mean will be close to normal regardless
> of the shape of the population distribution

Let's see if that's actually true by running some simulations!

Non-normal distributions: Gamma
========================================================


```r
## plot density histogram:
x<-rgamma(n = 1000, shape = 3)
par(mfrow=c(1,2)) # (two plots side-by-side)
hist(x,freq=F, breaks = 20)
plot(function(x) dgamma(x, shape = 3), 0, 6,
main = "Gamma density",ylim=c(0,.4),
ylab="density",xlab="X")
```

![plot of chunk unnamed-chunk-14](Class 1-figure/unnamed-chunk-14-1.png) 


Sampling from a gamma distribution (1)
========================================================


```r
sample_size <- 100
number_of_simulations <- 1000

sample_means <- replicate(number_of_simulations, mean(rgamma(n = sample_size, shape = 3)))

mean(sample_means)
```

```
[1] 2.991735
```

```r
sd(sample_means)
```

```
[1] 0.1744589
```

Sampling from a gamma distribution (2)
========================================================
Make a function to combine histogram and plot:

```r
make_hist_and_plot <- function(sample_means){
  par(mfrow=c(1,2)) # (two plots side-by-side)
  hist(sample_means,freq=F, breaks = 30)
  plot(density(sample_means), main = paste("Mean = ", round(mean(sample_means),2) , 
                                           "SD = ", round(sd(sample_means),2)))
} # label the plot with mean and sd
make_hist_and_plot(sample_means)
```

![plot of chunk unnamed-chunk-16](Class 1-figure/unnamed-chunk-16-1.png) 


Non-normal distributions: Uniform
========================================================


```r
## plot density histogram:
x <- runif(n = 1000)
par(mfrow=c(1,2)) # (two plots side-by-side)
hist(x,freq=F)
plot(function(x) dunif(x), -3, 3,
main = "Uniform density",ylim=c(0,1),
ylab="density",xlab="X")
```

![plot of chunk unnamed-chunk-17](Class 1-figure/unnamed-chunk-17-1.png) 

Sampling from a uniform distribution (1)
========================================================


```r
sample_size <- 100
number_of_simulations <- 1000

sample_means <- replicate(number_of_simulations, mean(runif(n = sample_size)))

mean(sample_means)
```

```
[1] 0.4986721
```

```r
sd(sample_means)
```

```
[1] 0.02875109
```

Sampling from a uniform distribution (2)
========================================================


```r
make_hist_and_plot(sample_means)
```

![plot of chunk unnamed-chunk-19](Class 1-figure/unnamed-chunk-19-1.png) 

Non-normal distributions: Exponential
========================================================


```r
## plot density histogram:
x <- rexp(n = 1000)
par(mfrow=c(1,2)) # (two plots side-by-side)
hist(x,freq=F)
plot(function(x) dexp(x), 0, 6,
main = "Exponential distribution density",ylim=c(0,1),
ylab="density",xlab="X")
```

![plot of chunk unnamed-chunk-20](Class 1-figure/unnamed-chunk-20-1.png) 

Sampling from an exponential distribution (1)
========================================================


```r
number_of_simulations <- 100

sample_mean_from_exp<- function(number_of_samples){
  samples <- rexp(number_of_samples)
  mean(samples)
}

sample_means <- sapply(1:number_of_simulations, sample_mean_from_exp)
summary(sample_means)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.3859  0.8799  0.9836  0.9922  1.0890  1.8370 
```

Sampling from an exponential distribution (2)
========================================================


```r
make_hist_and_plot(sample_means)
```

![plot of chunk unnamed-chunk-22](Class 1-figure/unnamed-chunk-22-1.png) 
```

The sampling distribution of the mean (1)
========================================================
- Notice something about the means of the samples?
  - They seem to cluster around the population mean
  - Let's play with this some more.
  - First, make a function for running the simulations so that we don't have to type all the code from the previous slides again and again
    - We're going to sample from the normal distribution again since it's easy to specify mean and sd for it.
  
The sampling distribution of the mean (2)
========================================================
This is our convenience function for running the simulations.
Don't worry if you don't understand everything yet!

```r
run_simulation <- function(sample_size = 100, 
                           number_of_simulations = 1000, 
                           population_mean = 0, 
                           population_sd = 1)
  {

sample_means <- replicate(number_of_simulations, 
                          mean(rnorm(n = sample_size, 
                                     mean = population_mean, 
                                     sd = population_sd)))

make_hist_and_plot(sample_means)
}
```

The sampling distribution of the mean (2)
========================================================
It works:

```r
run_simulation(sample_size = 100, 
               number_of_simulations = 1000, 
               population_mean = 0, 
               population_sd = 1)
```

![plot of chunk unnamed-chunk-24](Class 1-figure/unnamed-chunk-24-1.png) 


The sampling distribution of the mean (3)
========================================================
Now, let's try different parameters. What happens if we change the mean of the population?

```r
run_simulation(sample_size = 100, 
               number_of_simulations = 1000, 
               population_mean = 100, 
               population_sd = 1)
```

![plot of chunk unnamed-chunk-25](Class 1-figure/unnamed-chunk-25-1.png) 

The sampling distribution of the mean (3)
========================================================
The sampling distribution of the mean has the same mean as the population!
You can (hopefully) see how this might be useful.

```r
run_simulation(sample_size = 100,
               number_of_simulations = 1000, 
               population_mean = 50000, 
               population_sd = 1)
```

![plot of chunk unnamed-chunk-26](Class 1-figure/unnamed-chunk-26-1.png) 

Sample mean and population mean (1)
========================================================
- OK, *why* is it useful?
  - Well, usually, we don't know the population mean.
  - We have to estimate it somehow.
  - Solution: just use the sample mean as an estimator for the population mean.
    - Can this go wrong?
      - Yes, definitely.
      
Sample mean and population mean (2)
========================================================
- Remember the plots we just made:

![plot of chunk unnamed-chunk-27](Class 1-figure/unnamed-chunk-27-1.png) 

- Notice that the sample mean is not **not always** the same as the population mean (0 in this case).
  - This is due to the random nature of drawing a sample from the population.
  
Sample mean and population mean (3)
========================================================
- Let's try reducing the sample size

```r
run_simulation(sample_size = 10,
               number_of_simulations = 1000,
               population_mean = 0,
               population_sd = 1)
```

![plot of chunk unnamed-chunk-28](Class 1-figure/unnamed-chunk-28-1.png) 
- Things got a bit noisier (note that the x-axis is scaled automatically)
- The sd of the distribution of the sample means went up.

Sample mean and population mean (4)
========================================================
- Let's try increasing the sample size

```r
run_simulation(sample_size = 1000,
               number_of_simulations = 1000,
               population_mean = 0, 
               population_sd = 1)
```

![plot of chunk unnamed-chunk-29](Class 1-figure/unnamed-chunk-29-1.png) 
- Things got a lot less noisy (note that the x-axis is scaled automatically)
- The sd of the distribution of the sample means went down.

Sample mean and population mean (5)
========================================================
- Note that when we changed the sample size, the sd of the distribution of sample means changed.
- The mean stayed the same though!
- The larger your sample is, the closer your average sample mean is going to be to the true population mean.
- Formally speaking, the sample mean is an **unbiased estimator** of the population mean.
- I could show you the mathematical proof for that, but I won't.

Standard error of the mean (SE) (1)
========================================================

Population SD = 1

|Sample size|  SD of the sample mean|
|----------:|----------------------:|
|         10|                    .31|
|        100|                     .1|
|       1000|                    .03|

See a pattern?

This relationship holds in general:
$$
\sigma_{\bar{x}} = \frac{\sigma}{\sqrt{n}}
$$
where $\sigma_{\bar{x}}$ is the standard deviation of the sample means, $\sigma$ is the population standard deviation, and $n$ is the sample size


Standard error of the mean (SE) (2)
========================================================
- Usually, we don't know what $\sigma$ is, but we can still can estimate $\sigma_{\bar{x}}$ from our sample:
$$
SE_{\bar{x}} = \frac{s}{\sqrt{n}}
$$

where $SE_{\bar{x}}$ is the estimated **standard error of the mean**, $s$ is the population standard deviation, and $n$ is the sample size.
- More about that next week.
