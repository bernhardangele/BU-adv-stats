Transformations and Logistic Regression
========================================================
author: Bernhard Angele
date: Advanced Statistics
autosize: true


Transformations
========================================================
- In some cases, our dependent variable will not be normally distributed
- Example: reaction times -- you get a long right tail of slow responses
    - Fixation times in eye movements are very similar

Example
========================================================
- For example, the probability density function for fixation durations might look like this:

![plot of chunk unnamed-chunk-1](Class9-figure/unnamed-chunk-1-1.png)

Example data
========================================================
- Example experiment: how long do people look at swear words vs. non-swear words?
    - Let's assume that the true means are 250 ms for non swear words and 300 ms for swear words
- Let's generate data based on this assumption


Running a linear model
========================================================

```

Call:
lm(formula = fixation_time ~ word_condition, data = swear_exp)

Residuals:
    Min      1Q  Median      3Q     Max 
-125.34  -62.91  -14.41   47.39  242.69 

Coefficients:
                         Estimate Std. Error t value Pr(>|t|)    
(Intercept)                304.16      14.86  20.469   <2e-16 ***
word_conditionswear word   -50.84      21.01  -2.419   0.0187 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 81.39 on 58 degrees of freedom
Multiple R-squared:  0.09166,	Adjusted R-squared:  0.076 
F-statistic: 5.853 on 1 and 58 DF,  p-value: 0.01871
```

Plotting the fitted line
========================================================
![plot of chunk unnamed-chunk-4](Class9-figure/unnamed-chunk-4-1.png)

Histogram of the residuals
========================================================
![plot of chunk unnamed-chunk-5](Class9-figure/unnamed-chunk-5-1.png)
- Clearly not normal - it's right-skewed!
- But notice how robust the analysis is. We still find the effect!

Logarithmic transformations
=========================================================
- Better to run a proper model where the values as the dependent variable
  - This is our first step into the world of generalised linear models (GLM)
- The most common transformation uses the logarithm
  - Remember the logarithm from school? 
    - I hope you remember exponentiation: $x \cdot x \cdot x \cdot x = x^4$
    - Every logarithm has a base
      - The logarithm of a number is the exponent to which the base needs to be raised to produce that number
      - For example, the base $x$ logarithm of $x^4$ is $4$, since $x$ needs to be raised to the 4th power to produce $x^4$: $log_x(x^4) = 4$

The natural logarithm
==========================================================
- It doesn't really matter which base you use for your logarithm
- In mathematics, the algorithm to the base $e = 2.718$ called the *natural logarithm*. It is used frequently, since it has some very convenient properties. The logarithm to the base $e$ is called $log_e$ or $ln$.
- Just remember that $ln(e^x) = x$ and $e^{ln(x)} = x$.
- Also, remember that $x^{a+b} = x^a \cdot x^b$
    - Because of this, $e^{ln(x) + ln(y)} = x\cdot y$
    - And, the other way around, $ln(e^x \cdot e^y) = x+y$

Running a log model
========================================================
- Use `Compute` in SPSS to transform the predicted variable


```

Call:
lm(formula = log(fixation_time) ~ word_condition, data = swear_exp)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.56356 -0.23919 -0.01322  0.17969  0.63194 

Coefficients:
                         Estimate Std. Error t value Pr(>|t|)    
(Intercept)               5.68347    0.05245 108.368   <2e-16 ***
word_conditionswear word -0.19513    0.07417  -2.631   0.0109 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.2873 on 58 degrees of freedom
Multiple R-squared:  0.1066,	Adjusted R-squared:  0.0912 
F-statistic: 6.921 on 1 and 58 DF,  p-value: 0.01089
```

Histogram of the residuals of the transformed model
========================================================
![plot of chunk unnamed-chunk-7](Class9-figure/unnamed-chunk-7-1.png)

- Much better! No longer skewed.

How to interpret a log model
========================================================
- We are transforming the predicted values using the natural logarithm ($ln$) here. This is a logarithm to the base $e = 2.7182818$. You may remember from school that $e^{ln(x)} = x$ and $ln(e^x) = x$.
- Important: You can only log-transform positive and non-zero values. If you have zeroes or negative values in your dependent variable, you have to transform it.
  - For example, to eliminate zeroes, you might add a tiny amount to all values.
- Log models are *multiplicative* rather than *additive*:
  - $e^{x+y} = e^x \cdot e^y$, and $e^{ln(x) + ln(y)} = x\cdot y$
- Our model formula: $ln(y_{i}) = \alpha + \beta_1 x_{i1} + \beta_2 x_{i2} + \varepsilon_i$
  - Let's rewrite that: $y_{i} = e^{\alpha + \beta_1 x_{i1} + \beta_2 x_{i2} + \varepsilon_i} = e^{\alpha} \cdot e^{\beta_1x_{i1}} \cdot e^{\beta_2x_{i2}}$

How to interpret a log model (2)
========================================================
- Example: Our swear word fixation time study
    - Fitted model: $ln(y_{i}) = 5.683 - .195 \cdot x_i$
    - Remember: We're using treatment contrasts. $x_i$ is 0 for non swear words and 1 for swear words
    - Predicted value for non swear words: $e^{5.683} \cdot e^{-.195 \cdot 0} = e^{5.683} =  293.82$
    - Predicted value for swear words: $e^{5.683} \cdot e^{-.195 \cdot 1} = 293.82 \cdot e^{-.195} = 293.82 * .823 = 241.81$
- Conclusion: Fixation times on swear words were 17.7% lower than fixation times on non swear words (*b* = -.195, *SE* = .074, *t* = -2.63, *p* = .011).

Summary
========================================================
- If our data aren't normally distributed, we can sometimes transform them to get them closer to normality.
- A very common transformation uses the logarithm (usually the natural logarithm with base $e$, but others can be used to)
- You can't log-transform negative or zero values, so if your data contain any of those, you have to remove them or transform them (e.g. by adding a constant value) before doing the log-transformation
- The regression equation of a log-model is additive in its log format, but multiplicative when transformed back into raw values     - e.g. $log(y) = \alpha + \beta X_i \leftrightarrow y = e^{\alpha + \beta X_i} = e^{\alpha} * e^{\beta X_i}$

Logistic regression
========================================================
- What if we have a dichotomous dependent variable?
    - Yes vs. no, error vs. no error, alive vs. dead, pregnant vs. not pregnant
- Our example (from A. Johnson): Factors that make (or don't make) you fail your driving test
- 90 candidates
- Dependent variable: `Driving.Test`: Yes or No
- Predictor variables:
    - `Practice`: in hours
    - `Emergency.Stop`: Whether the candidate performed the emergency stop (yes or no)
    - `Examiner`: How difficult the examiner is (on a scale from 0 = easy to 100 = extremely difficult)
    - `Cold.Remedy`: How many doses of cold remedy the candidate had before the test

Examining the data
=======================================================
- These are our data (first 6 rows):


























```
Error in file(file, "rt") : cannot open the connection
```
