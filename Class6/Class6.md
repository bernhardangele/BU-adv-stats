Advanced Statistics
========================================================
author: Bernhard Angele
date: Class 6, 13/11/2014

Last class
========================================================
- Time really flies when you are having fun, right?
- On the agenda for today:
    - Contrasts
    - Transformations
    - Logistic regression
    - Linear mixed models
    - Power
    - Non-parametric tests (and why we didn't talk much about them)
- Also: Assignment 2
- Assignment 1 marks:
    - By Dec 1st -- plenty of time to incorporate my feedback for Assignment 2.

Contrasts
========================================================
- The link between multiple regression and ANOVA
- Using dummy coding to turn a discrete variable into a number of "continuous" contrasts
- Many possible contrasts -- you can make your own!
    - Not very many *sensible* contrasts.
- Basic principles: A factor with $k$ levels gets split into $k-1$ contrasts.
    - i.e. one contrast per degree of freedom
- Contrasts can be, but don't have to be, **orthogonal**
    - orthogonal contrasts don't share any variance
    - non-orthogonal contrasts are fine to use, but they may be correlated
        - remember the pitfalls of multicollinearity!
        
Example
========================================================
- Enough about cats, let's talk about dogs!
- In this ficticious example, let's assume we are testing 45 dogs to see how many object names they know (e.g. when you tell them to bring you a "ball", "stick", etc., do they bring you the correct object or a random one?)
- Our sample contains 15 beagles, 15 border collies, and 15 terriers.
- Let's assume that the true means for each breed are:

| Breed        | Number of object names known|
|-------------:|----------------------------:|
| Beagle       |                           10|
| Border Collie|                           60|
| Terrier      |                           15|

Example (2)
========================================================
- With 3 means, there are (at least) 3 comparisons we can make

| Comparison              | Difference                  |
|------------------------:|----------------------------:|
| Border Collie -- Beagle |                           50|
| Border Collie -- Terrier|                           35|
| Terrier -- Beagle       |                            5|

- Let's see how the contrasts reflect these comparisons
  - But remember -- we can only make 2.
  
Generating the data
========================================================
- Feel free to skip over this if you don't care about how we generate the fake data

```r
# Seed for random number generators, so that we all get the same results
set.seed("6")
# Column 1: Breed - repeat each breed name 15 times, then combine
breed <- c(rep("Beagle", 15), rep("Border Collie", 15), rep("Terrier", 15))
# Column 2: Objects - repeat each true group mean 15 times, then combine
objects <- c(rep(10, 15), rep(60, 15), rep(15, 15))
```

Generating the data (2)
========================================================
- You can still skip this if you must...

```r
# Add random noise to the objects scores
objects <- objects + rnorm(n = 45, mean = 0 , sd = 6)
# for more realism, round the objects scores to full integers
# (what does it mean if a dog knows a fraction of an object?)
objects <- round(objects, digits = 0)
# Combine into data frame
dogs <- data.frame(breed, objects)
```

The data
========================================================

```r
# get the means for each breed
mean(dogs[dogs$breed == "Beagle",]$objects)
```

```
[1] 10.4
```

```r
mean(dogs[dogs$breed == "Border Collie",]$objects)
```

```
[1] 61.8
```

```r
mean(dogs[dogs$breed == "Terrier",]$objects)
```

```
[1] 13.93
```

```r
# or do it all in one go:
tapply(X = dogs$objects, INDEX = dogs$breed, FUN = mean)
```

```
       Beagle Border Collie       Terrier 
        10.40         61.80         13.93 
```

Comparing the means
========================================================
- We can always do pairwise *t*-tests. Those give us all the comparisons, but at the cost of making multiple comparisons.

```r
pairwise.t.test(x = dogs$objects, g = dogs$breed)
```

```

	Pairwise comparisons using t tests with pooled SD 

data:  dogs$objects and dogs$breed 

              Beagle Border Collie
Border Collie <2e-16 -            
Terrier       0.14   <2e-16       

P value adjustment method: holm 
```

Adding contrasts
========================================================
- Let's make "breed" into a factor

```r
dogs$breed <- factor(dogs$breed)
```
- R automatically assigns *treatment* contrasts to each factor, which you can look at using the `contrasts` command:

```r
contrasts(dogs$breed)
```

```
              Border Collie Terrier
Beagle                    0       0
Border Collie             1       0
Terrier                   0       1
```
- "Beagle" is the baseline level here. Why? Because it comes first alphabetically and R really has no way to know if there is another baseline level that would suit you more.

What does this contrast matrix mean?
========================================================

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|
- When doing a regression analysis, R will replace the factor "breed" with two contrasts, $x_1$ and $x_2$
- $x_1$ will be 1 for all "Border Collie" cases, and 0 otherwise
- $x_2$ will be 1 for all "Terrier" cases, and 0 otherwise
- Why is this a good idea?

How contrasts work
=========================================================
- Remember the linear regression equation:
- $y_{i} = \beta_0 + \beta_1 x_{1} + \beta_2 x_{2} + \epsilon_i$
- i.e. the predicted value for $y_i$ is $\hat{y_i} = \beta_0 + \beta_1 x_{1} + \beta_2 x_{2}$
- Now let's substitute in the values from the table if breed is "Beagle":

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|
- $\hat{y_{i}} = \beta_0 + \beta_1 \cdot 0 + \beta_2 \cdot 0 = \beta_0$
- The predicted value for the Beagle group is $\beta_0$, the intercept
- That means that in this analysis, the intercept will reflect the mean for the Beagle group (10)

How contrasts work (2)
=========================================================
- The predicted value for $y_i$ is still $\hat{y_i} = \beta_0 + \beta_1 x_{1} + \beta_2 x_{2}$
- Now let's substitute in the values from the table if breed is "Border Collie":

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|
- $\hat{y_{i}} = \beta_0 + \beta_1 \cdot 1 + \beta_2 \cdot 0 = \beta_0 + \beta_1$
- The predicted value for the Border Collie group is $\beta_0 + \beta_1$, i.e. the sum of the intercept and the first slope $\beta_1$
- That means that in this analysis, the slope $\beta_1$ will reflect the difference between the mean for the Border Collie group and the mean for the Beagle group ($60 - 10 = 50$)

How contrasts work (2)
=========================================================
- The predicted value for $y_i$ is still $\hat{y_i} = \beta_0 + \beta_1 x_{1} + \beta_2 x_{2}$
- Now let's substitute in the values from the table if breed is "Terrier":

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|
- $\hat{y_{i}} = \beta_0 + \beta_1 \cdot 0 + \beta_2 \cdot 1 = \beta_0 + \beta_2$
- The predicted value for the Border Collie group is $\beta_0 + \beta_2$, i.e. the sum of the intercept and the second slope $\beta_2$
- That means that in this analysis, the slope $\beta_1$ will reflect the difference between the mean for the Terrier group and the mean for the Beagle group ($15 - 10 = 5$)

Let's try it
==========================================================

```r
lm(data = dogs, objects ~ breed)
```

```

Call:
lm(formula = objects ~ breed, data = dogs)

Coefficients:
       (Intercept)  breedBorder Collie        breedTerrier  
             10.40               51.40                3.53  
```
- Looks just about right (remember, the means differ from the true population means because this is a -- simulated -- sample and contains random error)

Let's do the hypothesis tests
==========================================================
- First, the ANOVA:

```r
anova(lm(data = dogs, objects ~ breed))
```

```
Analysis of Variance Table

Response: objects
          Df Sum Sq Mean Sq F value Pr(>F)    
breed      2  24728   12364     304 <2e-16 ***
Residuals 42   1711      41                   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Now, the contrasts
==========================================================

```r
summary(lm(data = dogs, objects ~ breed))
```

```

Call:
lm(formula = objects ~ breed, data = dogs)

Residuals:
   Min     1Q Median     3Q    Max 
 -9.80  -4.40  -0.40   4.07  12.20 

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
(Intercept)           10.40       1.65    6.31  1.4e-07 ***
breedBorder Collie    51.40       2.33   22.05  < 2e-16 ***
breedTerrier           3.53       2.33    1.52     0.14    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 6.38 on 42 degrees of freedom
Multiple R-squared:  0.935,	Adjusted R-squared:  0.932 
F-statistic:  304 on 2 and 42 DF,  p-value: <2e-16
```

Interpreting the hypothesis tests
========================================================
- Note that we are testing the $H_0$ that $\beta_0$, $\beta_1$, $\beta_2$ are 0.
- R helpfully calls the observed coefficients $b_1$ `breedBorder Collie` and $b_2$ `breedTerrier`.
- Remember what we said about the coefficients?
- $\beta_0$ (the intercept) reflects the mean for the Beagle group
- If the intercept is significantly different from 0, that's not that interesting (but at least it is evidence that the beagles can learn more than 0 object names)
- The first slope $\beta_1$ reflects the difference between the Border Collie group and the Beagle group
- If this difference is significant, it means that there is evidence that Border Collies know more object names than Beagles

Interpreting the hypothesis tests (2)
========================================================
- The second slope $\beta_2$ reflects the difference between the Terrier group and the Beagle group
- If this difference is significant, it means that there is evidence that Terriers know more object names than Beagles
- Looking at the *t*-test results, $b_1$ is significantly different from 0, but $b_2$ isn't.
- There's a significant difference in terms of object names known between Beagles and Border Collies, but not between Beagles and Terriers
- Note that we are only doing two comparisons -- that's all we can do.

Trying different contrasts
=========================================================
- We can try some different contrast coding schemes to see how they work
- We can do this here because there are fake data and we know the actual means
- With real data, you need to plan your contrasts **before** you analyse your data (ideally, before you even collect them)
    - That's why they are called **planned** contrasts as opposed to **post hoc**.
- You can't even look at the means first!
- Otherwise, you're cheating. This is far worse than a small violation of normality or homoscedasticity!

What other contrasts does R have?
========================================================
- Sum/deviation contrasts
- (Reverse) Helmert contrasts
- many more
- Make your own!

Sum (or deviation) contrasts
==========================================================

```r
contrasts(dogs$breed) <- contr.sum
kable(coef(summary(lm(data = dogs, objects ~ breed))))
```



|            | Estimate| Std. Error|  t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|--------:|------------------:|
|(Intercept) |  28.7111|     0.9514|  30.1762|             0.0000|
|breed1      | -18.3111|     1.3456| -13.6086|             0.0000|
|breed2      |  33.0889|     1.3456|  24.5913|             0.0000|

Interpreting sum/deviation contrasts
===========================================================
- The intercept $\beta_0$ is the grand mean of all the observations ($28.33$)
- $\beta_1$ is the difference between the grand mean and the mean of Beagle ($10 - 28.33 = -18.33$)
- $\beta_2$ is the difference between the grand mean and the mean of Border Collie ($60 - 28.33 = 31.67$)
- Terrier is never explicitly compared to the grand mean.
- In general: each level (except for the last level) is compared to the grand mean.

(Reverse) Helmert contrasts
==========================================================

```r
contrasts(dogs$breed) <- contr.helmert
kable(coef(summary(lm(data = dogs, objects ~ breed))))
```



|            | Estimate| Std. Error|  t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|--------:|------------------:|
|(Intercept) |  28.7111|     0.9514|  30.1762|             0.0000|
|breed1      |  25.7000|     1.1653|  22.0547|             0.0000|
|breed2      |  -7.3889|     0.6728| -10.9827|             0.0000|

Interpreting (reverse) Helmert contrasts
========================================================
- The intercept $\beta_0$ is the grand mean of all the observations ($28.33$)
- $beta_1$ is half of the difference between the mean of Beagle and the mean of Border Collie ($(60 - 10)/2 = 25$)
- $beta_2$ is half of the difference between the joint mean of Beagle and Border Collie and the mean of Terrier ($(15 - (60+10)/2)/2 = -10$)
- In general: each level is compared to the mean of the previous levels

Make your own contrasts
==========================================================
- General rules: You have one contrast per degree of freedom
- The dummy values in each contrast should sum to 0 (so that your intercept will be the grand mean)
- The sum of the absolute values of the dummy values in each contrast should be 2
- If you want to compare two levels, set one to be -1 and the other to be 1
- Factor levels that you don't want to compare should be set to 0


Example
==========================================================
- I want to compare level 1 (Beagle) to level 3 (Terrier):

|             | x1 | x2|
|------------:|---:|--:|
|Beagle       |   1|TBD|
|Border Collie|   0|TBD|
|Terrier      |  -1|TBD|

- This contrast sums to 0, so the intercept should be the grand mean (unless the other contrast is something really crazy)
- The absolute values sum to 2
- The coefficient will be $Mean(Terrier) - Mean(Beagle)$, so it will be positive if the mean for Terrier is greater than that for Beagle and negative if $Mean(Beagle) > Mean(Terrier)$

More complex comparisons
==========================================================
- To compare a mean of two factor levels to the mean of another factor (e.g. the mean of Beagle and Terrier vs. the mean of Border Collie), split them up: 
    - Set the two levels that you want to take the mean of both to .5 or -.5
    - Then set the third level to -1 or 1, respectively
    - The rules still hold:
        - The dummy values in each contrast should sum to 0 (so that your intercept will be the grand mean)
        - The absolute values should sum to 2
        - Factor levels that you don't want to compare should be set to 0

Example (continued)
==========================================================
- I want to compare level 1 (Beagle) to level 3 (Terrier):

|             | x1 | x2|
|------------:|---:|--:|
|Beagle       |   1|-.5|
|Border Collie|   0|  1|
|Terrier      |  -1|-.5|

- Both contrasts sum to 0, so the intercept should be the grand mean
- The absolute values sum to 2
- The coefficient for x2 will be $Mean(Terrier) - Mean(Beagle)$, so it will be positive if the mean for Terrier is greater than that for Beagle and negative if $Mean(Beagle) > Mean(Terrier)$

Defining your own contrast coding
========================================================
- You'll need the library "MASS"
    - If you don't have it yet, install it: `install.packages("MASS")`
- Put together the contrast matrix:

```r
x1 <- c(1, 0, -1)
x2 <- c(-.5, 1 , -.5)
# cbind: bind the vectors together as columns in a matrix
my_contrasts <- cbind(x1, x2)
```

Defining your own contrast coding (2)
========================================================
- Now you can assign the contrasts
- Important: you don't actually assign your home-made contrast matrix itself, but rather the transposed generalised inverse of the matrix
    - Why? That's just how R expects to get the contrasts...
- The only thing you need to be aware of is that `ginv` requires the `MASS` package to be loaded:

```r
library(MASS)
contrasts(dogs$breed) <- t(ginv(my_contrasts))
```

Interpreting the results
=======================================================

```r
kable(coef(summary(lm(data = dogs, objects ~ breed))))
```



|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |  28.7111|     0.9514| 30.1762|             0.0000|
|breed1      |  -3.5333|     2.3306| -1.5161|             0.1370|
|breed2      |  49.6333|     2.0183| 24.5913|             0.0000|
- The intercept $\beta_0$ is the grand mean of all the observations ($28.33$)
- $\beta_1$ is the difference between the mean of Beagle and the mean of Terrier ($10 - 15 = -5$)
- $\beta_2$ is the difference between the mean of Beagle and Terrier together and the mean of Border Collie ($60 - (10+15)/2 = 47.5$)
- Once again, notice that the sample coefficients $b_0$, $b_1$, and $b_2$ are not *exactly* the same as the population coefficients $\beta_0$, $\beta_1$, and $\beta_2$.

Orthogonality of contrasts
=======================================================
- If contrasts are orthogonal, that means they do not share any variance
    - i.e. they are not correlated
- You can find out if your hand-made contrasts are orthogonal:
- Calculate the product of each row
- If the row products sum up to 0, the contrast is orthogonal:

|             | x1 | x2| x1*x2|
|------------:|---:|--:|-----:|
|Beagle       |   1|-.5|   -.5|
|Border Collie|   0|  1|     0|
|Terrier      |  -1|-.5|    .5|
|*Total*      |   0|  0|     0|

- Are our contrasts orthogonal? Yes!

Orthogonality of contrasts (2)
=======================================================
- Contrasts do not have to be orthogonal (also known as *independent*).
- But be aware that correlated contrasts may cause multicollinearity issues
    - Especially if you have an unbalanced design
    - Especially if you have an interaction design
- As long as you are aware of what exactly you are doing, you'll be fine
- As soon as you no longer know what you're doing, ask for help!

Transformations
========================================================
- In some cases, our dependent variable will not be normally distributed
- Example: reaction times -- you get a long right tail of slow responses
    - Fixation times in eye movements are very similar

Example
========================================================
- For example, the probability density function for fixation durations might look like this:

![plot of chunk unnamed-chunk-19](Class6-figure/unnamed-chunk-19.png) 

Example data
========================================================
- Example experiment: how long do people look at swear words vs. non-swear words?
    - Let's assume that the true means are 250 ms for non swear words and 300 ms for swear words
- Let's generate data based on this assumption

```r
set.seed("11233")
# 60 subjects
word_condition <- factor(c(rep("swear word", 30), rep("non swear word", 30)))
# rlnorm: Generate random samples from the lognormal distribution
fixation_time <- c(rlnorm(n = 30, mean = log(250), sd = .3), rlnorm(n = 30, mean = log(265), sd = .3))
swear_exp <- data.frame(word_condition, fixation_time)
```

Running a linear model
========================================================

```r
linear_model <- lm(data = swear_exp, fixation_time ~ word_condition)
summary(linear_model)
```

```

Call:
lm(formula = fixation_time ~ word_condition, data = swear_exp)

Residuals:
   Min     1Q Median     3Q    Max 
-125.3  -62.9  -14.4   47.4  242.7 

Coefficients:
                         Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 304.2       14.9   20.47   <2e-16 ***
word_conditionswear word    -50.8       21.0   -2.42    0.019 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 81.4 on 58 degrees of freedom
Multiple R-squared:  0.0917,	Adjusted R-squared:  0.076 
F-statistic: 5.85 on 1 and 58 DF,  p-value: 0.0187
```

Assumption test
========================================================

```r
shapiro.test(resid(linear_model))
```

```

	Shapiro-Wilk normality test

data:  resid(linear_model)
W = 0.9491, p-value = 0.01417
```
- Clearly not normal!
- But notice how robust the analysis is. We still find the effect!
- Nevertheless, better to run a proper model with log transformed values as the dependent vairable


Running a log model
========================================================

```r
log_model <- lm(data = swear_exp, log(fixation_time) ~ word_condition)
summary(log_model)
```

```

Call:
lm(formula = log(fixation_time) ~ word_condition, data = swear_exp)

Residuals:
    Min      1Q  Median      3Q     Max 
-0.5636 -0.2392 -0.0132  0.1797  0.6319 

Coefficients:
                         Estimate Std. Error t value Pr(>|t|)    
(Intercept)                5.6835     0.0524  108.37   <2e-16 ***
word_conditionswear word  -0.1951     0.0742   -2.63    0.011 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.287 on 58 degrees of freedom
Multiple R-squared:  0.107,	Adjusted R-squared:  0.0912 
F-statistic: 6.92 on 1 and 58 DF,  p-value: 0.0109
```

Assumption test
========================================================

```r
shapiro.test(resid(log_model))
```

```

	Shapiro-Wilk normality test

data:  resid(log_model)
W = 0.9823, p-value = 0.5325
```

How to interpret a log model
========================================================
- Formula: $ln(y_{i}) = \beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i$
- Let's rewrite that: $y_{i} = e^{\beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i} = e^{\beta_0} \cdot e^{\beta_1x_{i1}} \cdot e^{\beta_2x_{i2}}$
    - If this confuses you: we are using the natural logarithm ($ln$; R somewhat confusingly calls it `log`) here. This is a logarithm to the base $e ~ 2.718$. Maybe you'll remember that $e^{ln(x)} = x$
- Log models are *multiplicative* rather than *additive*

How to interpret a log model (2)
========================================================
- Example: Our swear word fixation time study
    - Fitted model: $ln(y_{i}) = 5.683 - .195 \cdot x_i$
    - Remember: We're using treatment contrasts. $x_i$ is 0 for non swear words and 1 for swear words
    - Predicted value for non swear words: $e^{5.683} \cdot e^{-.195 \cdot 0} = e^{5.683} =  293.82$
    - Predicted value for swear words: $e^{5.683} \cdot e^{-.195 \cdot 1} = 293.82 \cdot e^{-.195} = 293.82 * .823 = 241.81$
- Conclusion: Fixation times on swear words were 17.7% lower than fixation times on non swear words (*b* = -.195, *SE* = .074, *t* = -2.63, *p* = .011).

Logistic regression
========================================================
- What if we have a dichotomous dependent variable?
    - Yes vs. no, error vs. no error, alive vs. dead, pregnant vs. not pregnant
- Our example (from A. Johnson): Factors that make (or don't make) you fail your driving test
- 90 candidates
- Dependent variable: `Driving.Test`
- Predictor variables:
    - `Practice`: in hours
    - `Emergency.Stop`: Whether the candidate performed the emergency stop (yes or no)
    - `Examiner`: How difficult the examiner is (on a scale from 0 = easy to 100 = extremely difficult)
    - `Cold.Remedy`: How many doses of cold remedy the candidate had before the test

Where to start?
=========================================================
- We would like to use our standard regression model $y_{i} = \beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i$
- But our data are definitely not normally distributed (they aren't even continuous)
- First step: represent the data as probabilities rather than Yes or No
    - What's the probability of passing the test given that I've had (at most) 20 hours of practice, did my emergency stop, had at most an average examiner (50) and had only one cup of cold remedy?
    - Probabilities are still weird: They only go from 0 to 1, and they also aren't great for linear relationships
    - Let's try something else: odds
    
Probability and odds
========================================================
- Very popular in betting, since they make it easy to estimate the payout
- $Odds = \frac{P}{1-P}$
- For example: 
      - $P = .5$ gives you even odds $\frac{.5}{.5} = 1/1$
      - $P = .25$ gives you $\frac{.25}{.75} = 1/3$
      - $P = .75$ gives you $\frac{.75}{.25} = 3/1$
- Odds are nice because they aren't bounded, but for high probabilities they get very large very quickly ($P = .99 \Leftrightarrow Odds = 99/1$) and for small probabilities, they get very small very quickly ($P = .01 \Leftrightarrow Odds = 1/99$)
- What to do?

Log odds (logits)
=========================================================
- Just transform our odds (just like we did with our continuous fixation time variable earlier) by taking the natural logarithm: $logit = ln(Odds) = ln(\frac{P}{1-P})$
- Now we have a dependent measure that is suitable for linear relationships
- Our new logistic regression model is $ln(\frac{P}{1-P}) = \beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i$
- If we want to get back to probabilities, we can exponentiate both sides of the equation: $\frac{P}{1-P} = e^{\beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i}$
- Solving this for $P$: $P = \frac{e^{\beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i}}{1 + e^{\beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i}} = \frac{1}{1 + e^{-(\beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + \epsilon_i)}}$

Power in ANOVA
========================================================
- For the pain example last week:
  - 3 groups
  - 2 subjects per group
  - $\eta^2$ = .55
- Remember, $\eta^2 = \frac{SS_{Model}}{SS_{Total}}$
- R can calculate the power for a simple oneway ANOVA, but for anything more complex use G*Power (http://www.gpower.hhu.de/)
  - The same is true for SPSS

Using G*Power
========================================================

- Pick `F-Tests` as the `Test family`
- Pick the appropriate `Statistical test`
  - In this case, it's `ANOVA: Fixed effects, omnibus, one-way`
- Choose the `Type of power analysis`
  - That is, tell G*Power what information you have and what you want to know
  - Most commonly used:
    - `A priori`: You give G*Power your estimate of the effect size and the desired power, and it gives you the necessary sample size to achieve that power
    - `Post-hoc`: You give G*Power your effect size and the sample size from the analysis you have already done, and it gives you the power that your analysis had


Using G*Power (2)
========================================================
- How to get the effect size:
  - Click `Determine =>` next to the `Effect size f` field
  - Make sure `Select procedure` in the sidebar that opened is set to `Effect size from variance`
  - If you've already run your analysis and have your $\eta_G^2$ (`ges` in ezANOVA) or $\eta_P^2$ (partial eta-squared in SPSS) estimate, click on `Direct` and enter the value in the Partial $\eta^2$ field
  - Click on `Calculate and transfer to main window`
- If you are doing an a priori analysis or for some reason you don't have an $\eta^2$ estimate, you can get your effect size by setting `Select procedure` to `Effect size from means` and then entering your group means, your within-group standard deviation ($\sigma$), and group sizes in the table


Using G*Power (3)
========================================================
- Now fill in the rest of the input parameters
- Leave $\alpha$ `err prob` at .05 unless for some reason you're not testing at a 5% $\alpha$ level
- Click `Calculate`
- G*Power will come up with a nice plot of F distribution based on the $H_0$ (red line), the distribution if the true effect has the entered effect size (dashed blue line), the critical F value, and your $\alpha$ and $\beta$ error regions 
- If you are running a post-hoc analysis: The `Power` (1-$\beta$ err prob) field will contain your power estimate
- If you are running an a priori analysis: `The total sample size` field will contain your necessary sample size

