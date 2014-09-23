Advanced Statistics
========================================================
author: Bernhard Angele 
date: October 2nd, 2014

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
- Very easy in R


R basics
========================================================
Addition

```r
1+1
```

```
[1] 2
```
Subtraction

```r
1-1
```

```
[1] 0
```

R basics
========================================================
Multiplication and division

```r
4*3
```

```
[1] 12
```

```r
12/4
```

```
[1] 3
```

R basics
========================================================
Powers

```r
5^2
```

```
[1] 25
```

```r
2^3
```

```
[1] 8
```

Variables
========================================================

```r
x <- 5
x + 1
```

```
[1] 6
```


Commands
========================================================

```r
x <- 5
x + 1
```

```
[1] 6
```

```r
x
```

```
[1] 5
```
Is anyone surprised by this?

Functions
========================================================

```r
addOne <- function(x) {
  x+1
}
addOne(5)
```

```
[1] 6
```

```r
addOne(-3)
```

```
[1] -2
```

Types of data
========================================================

```r
x <- 1
y <- "test"
z <- c(1,2)
z
```

```
[1] 1 2
```
z is a **vector**

```r
z + 1
```

```
[1] 2 3
```

Vector operations
========================================================

```r
z <- c(1,2,3,4,5)
z + 2
```

```
[1] 3 4 5 6 7
```

```r
z - 1
```

```
[1] 0 1 2 3 4
```

```r
z * 2
```

```
[1]  2  4  6  8 10
```

More vector operations
========================================================

```r
z <- c(1,2,3,4,5)
sum(z)
```

```
[1] 15
```

```r
length(z)
```

```
[1] 5
```

```r
sum(z)/length(z)
```

```
[1] 3
```

Descriptive statistics
========================================================
We could define a new function that calculates the mean.
But maybe it's defined for us already?

```r
z <- c(1,2,3,4,5)
mean(z)
```

```
[1] 3
```

What about other descriptive statistics?
========================================================

```r
median(z)
```

```
[1] 3
```

```r
sd(z)
```

```
[1] 1.581
```

```r
var(z)
```

```
[1] 2.5
```

Summary: lots of interesting descriptive statistics at once
========================================================

```r
summary(z)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      1       2       3       3       4       5 
```


Let's simulate some data
========================================================


```r
x<-rnorm(1000)
head(x)
```

```
[1] -1.8148 -1.5262 -0.7176  0.1405  0.7109 -0.4269
```

```r
plot(x)
```

![plot of chunk unnamed-chunk-15](Class 1-figure/unnamed-chunk-15.png) 

Distribution of the simulated data (histogram)
========================================================


```r
## plot density histogram:
par(mfrow=c(1,2)) # (little trick: two plots side-by-side)
hist(x,freq=F)
plot(density(x))
```

![plot of chunk unnamed-chunk-16](Class 1-figure/unnamed-chunk-16.png) 

Probability density?
========================================================

```r
plot(function(x) dnorm(x), -3, 3,
main = "Normal density",ylim=c(0,.4),
ylab="density",xlab="X")
```

![plot of chunk unnamed-chunk-17](Class 1-figure/unnamed-chunk-17.png) 

Normal probability density function (PDF)
========================================================
$$
\begin{equation}
  f(x,\mu,\sigma) = \frac{1}{\sigma \sqrt{2 \pi}} e^{-((x - \mu)^2/2 \sigma^2)}
\end{equation}
$$
With $x$ = value, 
$\mu$ = mean, 
and $\sigma$ = standard deviation
![plot of chunk unnamed-chunk-18](Class 1-figure/unnamed-chunk-18.png) 

Defining the normal PDF by hand (just in case you wanted to make sure)
========================================================
$$
\begin{equation}
  f(x,\mu,\sigma) = \frac{1}{\sigma \sqrt{2 \pi}} e^{-((x - \mu)^2/2 \sigma^2)}
\end{equation}
$$

```r
dnorm_manual <- function(x, mu = 0, sigma = 1) {1/(sigma*sqrt(2*pi)) * exp(-((x-mu)^2/2*sigma^2))}
plot(function(x) dnorm_manual(x), -3, 3,
main = "Normal density",ylim=c(0,.4),
ylab="density",xlab="X")
```

![plot of chunk unnamed-chunk-19](Class 1-figure/unnamed-chunk-19.png) 

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

![plot of chunk unnamed-chunk-20](Class 1-figure/unnamed-chunk-20.png) 


Sampling from a gamma distribution (1)
========================================================


```r
number_of_simulations <- 100

sample_mean_from_gamma <- function(number_of_samples){
  samples <- rgamma(number_of_samples, shape = 3)
  mean(samples)
}

sample_means <- sapply(1:number_of_simulations, sample_mean_from_gamma)
mean(sample_means)
```

```
[1] 2.929
```

```r
sd(sample_means)
```

```
[1] 0.3798
```

Sampling from a gamma distribution (2)
========================================================


```r
par(mfrow=c(1,2)) # (two plots side-by-side)
hist(sample_means,freq=F, breaks = 20)
plot(density(sample_means))
```

![plot of chunk unnamed-chunk-22](Class 1-figure/unnamed-chunk-22.png) 


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

![plot of chunk unnamed-chunk-23](Class 1-figure/unnamed-chunk-23.png) 

Sampling from a uniform distribution (1)
========================================================


```r
number_of_simulations <- 100

sample_mean_from_unif<- function(number_of_samples){
  samples <- runif(number_of_samples)
  mean(samples)
}

sample_means <- sapply(1:number_of_simulations, sample_mean_from_unif)
summary(sample_means)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.325   0.471   0.503   0.510   0.534   0.804 
```

Sampling from a uniform distribution (2)
========================================================


```r
par(mfrow=c(1,2)) # (two plots side-by-side)
hist(sample_means,freq=F, breaks = 20)
plot(density(sample_means))
```

![plot of chunk unnamed-chunk-25](Class 1-figure/unnamed-chunk-25.png) 

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

![plot of chunk unnamed-chunk-26](Class 1-figure/unnamed-chunk-26.png) 

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
  0.446   0.892   1.010   1.030   1.110   3.010 
```

Sampling from a uniform distribution (2)
========================================================


```r
par(mfrow=c(1,2)) # (two plots side-by-side)
hist(sample_means,freq=F, breaks = 20)
plot(density(sample_means))
```

![plot of chunk unnamed-chunk-28](Class 1-figure/unnamed-chunk-28.png) 

