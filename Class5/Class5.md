Advanced Statistics
========================================================
author: Bernhard Angele
date: Class 5, 30/10/2014

Linear regression
========================================================
- So far, we've figured out how to test if a *discrete* predictor (e.g. treatment group) can explain the variance in a *continuous* variable.
- What if our predictor is also *continuous*?

- Example:
    - More exciting data about cats and cat food!
    - Is the amount of cat food a cat eats related to its weight?
    
Cat food and weight
=========================================================


- This table actually has 30 rows, but I'm using the `head` command to just show you the first 6.
- You have cat weight in kg and cat food eaten in g.
- Looks like there might be a positive relationship here.


```r
kable(head(catfood))
```



| CatWeight| FoodEaten|
|---------:|---------:|
|      4.38|      79.6|
|      6.82|     149.4|
|      5.55|     109.9|
|      5.72|      99.2|
|      4.39|      84.0|
|      4.49|      92.4|

Let's plot it
==========================================================

```r
plot(x = catfood$CatWeight, y = catfood$FoodEaten)
```

![plot of chunk unnamed-chunk-3](Class5-figure/unnamed-chunk-3.png) 

Looks quite linear
==========================================================
- Let's put a line through it

```r
plot(x = catfood$CatWeight, y = catfood$FoodEaten)
abline(lm(catfood$FoodEaten ~ catfood$CatWeight))
```

![plot of chunk unnamed-chunk-4](Class5-figure/unnamed-chunk-4.png) 

Correlation
==========================================================
- Looks like we have a strong positive relationship:
    - The heavier the cat (variable $X$), the more food eaten (variable $Y$).
- We can compute the correlation coefficient
  - The correlation is the covariance ($\sigma{(X_i - \bar{X})\cdot(Y_i - \bar{Y})}$, where $X_i$ and $Y_i$ are each individual value in the two variables and $\bar{X}$ and $\bar{Y}$ are the means) which we standardise by dividing it by the product of the standard deviations ($s_X \cdot s_Y$).
  - Or we can just have R do it for us:

```r
cor(catfood$CatWeight, catfood$FoodEaten)
```

```
[1] 0.841
```

Correlation (2)
===========================================================
- If we square the correlation, we get $R^2$, the proportion of variance in variable $X$ explained by variable $Y$ (and vice-versa, of course)

```r
cor(catfood$CatWeight, catfood$FoodEaten)^2
```

```
[1] 0.707
```


Testing correlations
==========================================================
- Important: correlations calculated from a sample are **random variables**
- That means they will be different each time we repeat the experiment and whether they reflect the true correlation in the population depends on our luck of the draw.
- Luckily, Pearson figured out that if you randomly take *uncorrelated* samples from a normal distribution and compute the correlation coefficient, it will be *t*-distributed.
    - Tthis is exactly what you are doing if the null hypothesis that there is no relationship between the two variables you are studying is true.
    - So all we have to do is to see if the correlation coefficient is extreme enough that it would only occur 5% of the time or less if the $H_0$ (no correlation in the population) were true.

Testing correlations (2)
==========================================================
- R can do this *t*-test very easily using the `cor.test` function:

```r
cor.test(catfood$CatWeight, catfood$FoodEaten)
```

```

	Pearson's product-moment correlation

data:  catfood$CatWeight and catfood$FoodEaten
t = 8.21, df = 28, p-value = 6.119e-09
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.689 0.922
sample estimates:
  cor 
0.841 
```

Moving beyond correlations
============================================================
- So far, so good. But what if we have multiple continuous predictors?
- Let's look at the function we used to draw the line again:

```r
abline(lm(catfood$FoodEaten ~ catfood$CatWeight))
```
- The `abline` part just does the drawing. The real work is done by `lm`.
- `lm` stands for "Linear Models"
- Let's see what `lm` does if we don't use `abline` on it

Linear models
===========================================================
- Remember the formula interface? It's `Dependent variable ~ Independent variable(s)`
- Also, I can use `data = catfood` to avoid having to write `catfood$` every time.

```r
lm(formula = FoodEaten ~ CatWeight, data = catfood)
```

```

Call:
lm(formula = FoodEaten ~ CatWeight, data = catfood)

Coefficients:
(Intercept)    CatWeight  
       7.72        19.54  
```

What do these values mean?
============================================================
- `lm` tries to fit a *least squares* line through the data
- That means that it fits a line that minimises the square of each data point's deviation from the line
- *Least squares* means that large errors are penalised much more than small errors
- If you remember algebra from school, the function that draws a line has the following format:
    - $y = m \cdot x + c$
    - $c$ is called the *intercept*, since it gives the $y$-value where the line intersects the $y$-axis
    - $m$ is called the *slope*. For each unit of $x, $y$ changes this many units
    - In regression, we usually write the intercept first ($c + m \cdot x$), but that's just a convention.
    
What do these values mean (2)?
============================================================
- So, in our case, the best fitting line for the cat food data intersects the $y$-axis at the point (0, 7.718).
  - Not all x-values are sensible for all data. Saying that a cat with 0 kg weight would eat 7.718 g of food makes no sense, since a cat with 0 kg weight is not a cat anymore.
  - The linear function doesn't care, of course. It knows nothing about our data and just specifies a line.
- The slope might be more useful: It says that for each kg of extra weight, a cat will eat 19.536 more grammes of food.
    - Using this information, we can predict that a giant 8 kg cat would eat $7.718 + 19.536 \cdot 8 = 164.005$ g of food.
    
Predictions and residual errors
===============================================================
- Of course, our prediction is likely to be at least a little off.
- If we had an 8 kg cat in our data and its actual amount of food consumed was 170 g, we'd have an error of 5.995.
  - This is called the residual error.
- More formally, the regression equation looks like this (where $x_i$ are the individual values for the $x$ variable, and $y_i$ are the corresponding values for the $Y$ variable):
    - $y_i = \beta_0 + \beta_1 x_i + \epsilon_i$
    - Here, we've simply renamed the intercept to $\beta_0$ and the slope to $\beta_1$.
    - $\epsilon_i$ is the residual error for each data point.
    - Important: $\epsilon_i$ is assumed to be normally distributed
      - This doesn't matter for the line fitting, but it does for the hypothesis tests!
      
Back to hypothesis testing
=================================================================
- Important: Note that the $\beta$ variables are greek letters, which means they are the *population parameters*
- For each $\beta$ in the regression formula, we can propose the $H_0$ that its true value is 0
- The $\beta$ that are estimated from our sample are simply called $b$
- We can once again test if our $b$ values are extreme enough so they would only occur 5% of the time or less given the $H_0$.
- We test this separately for each $b$ value. Guess what, it's a *t*-test!

Hypothesis testing using lm
=================================================================
- In R, the `summary` function will usually give us the hypothesis tests corresponding to a linear model:

```r
summary(lm(formula = FoodEaten ~ CatWeight, data = catfood))
```

```

Call:
lm(formula = FoodEaten ~ CatWeight, data = catfood)

Residuals:
    Min      1Q  Median      3Q     Max 
-26.294  -9.010   0.698   9.634  17.570 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)     7.72      12.06    0.64     0.53    
CatWeight      19.54       2.38    8.21  6.1e-09 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 13 on 28 degrees of freedom
Multiple R-squared:  0.707,	Adjusted R-squared:  0.696 
F-statistic: 67.5 on 1 and 28 DF,  p-value: 6.12e-09
```

Hypothesis testing using lm (2)
=================================================================
- This is essentially the same test as the Pearson test for the correlations before, just without standardising the slope
- We also test whether the intercept is 0
    - This is usually not particularly interesting unless you have a very specific hypothesis about the intercept.
- In our cat example, the intercept is so small that it essentially doesn't matter for the quality of the prediction if the intercept is 0
- What definitely matters is whether the slope is 0 or not. Based on the sample data, we can conclude that if the $H_0$ were true, we would see an effect of this size far less than 5% of the time.

Hypothesis testing using lm (2)
=================================================================
- Unlike simply running a hypothesis test on a correlation, we can easily add another predictor to a linear model, making it a multiple regression model, where $x_{1i}$ is observation *i* on the first predictor and $x_{2i}$ is observation *i* on the second predictor:
    - $y_i = \beta_0 + \beta_1 x_{1i} + \beta_2 x_{2i} + \beta_3 x_{1,i} x_{2,i} + \epsilon_i$
    - Note the interaction term  $\beta_3 x_{1,i} x_{2,i}$
      - We could also specify the model without the interaction if we think there might be a possibility that the effects are just additive:
          - $y_i = \beta_0 + \beta_1 x_{1i} + \beta_2 x_{2i} + \beta_3 x_{1,i} x_{2,i} + \epsilon_i$
    - Which of the models is better?
      - That's exactly what the significance test tells us!
      
Example
==================================================================
- Let's assume that, apart from each cat's weight in kg, we also have its age in months:

```r
kable(head(catfood_age))
```



| CatWeight| CatAge| FoodEaten|
|---------:|------:|---------:|
|      4.38|   35.6|      79.6|
|      6.82|   55.1|     149.4|
|      5.55|   25.5|     109.9|
|      5.72|   60.0|      99.2|
|      4.39|   39.1|      84.0|
|      4.49|   55.9|      92.4|
- Does adding age (and the interaction between age and weight) to the model improve it?


Example (2)
==================================================================
- In a formula, the `:` symbol symbolises the interaction term

```r
summary(lm(formula = FoodEaten ~ CatWeight + CatAge + CatWeight:CatAge, data = catfood_age))
```

```

Call:
lm(formula = FoodEaten ~ CatWeight + CatAge + CatWeight:CatAge, 
    data = catfood_age)

Residuals:
   Min     1Q Median     3Q    Max 
-25.05  -6.39   1.72   7.27  14.78 

Coefficients:
                 Estimate Std. Error t value Pr(>|t|)   
(Intercept)      -26.7797    33.2888   -0.80   0.4284   
CatWeight         22.9673     6.3651    3.61   0.0013 **
CatAge             0.7513     0.6140    1.22   0.2321   
CatWeight:CatAge  -0.0742     0.1149   -0.65   0.5238   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 11.1 on 26 degrees of freedom
Multiple R-squared:  0.799,	Adjusted R-squared:  0.776 
F-statistic: 34.5 on 3 and 26 DF,  p-value: 3.22e-09
```

Example (3)
==================================================================
- You can also use the shorthand `*` to add both a main effect and an interaction.
  - This model is exactly the same as the previous one:

```r
lm_catfood_interaction <- lm(formula = FoodEaten ~ CatWeight * CatAge, data = catfood_age)
summary(lm_catfood_interaction)
```

```

Call:
lm(formula = FoodEaten ~ CatWeight * CatAge, data = catfood_age)

Residuals:
   Min     1Q Median     3Q    Max 
-25.05  -6.39   1.72   7.27  14.78 

Coefficients:
                 Estimate Std. Error t value Pr(>|t|)   
(Intercept)      -26.7797    33.2888   -0.80   0.4284   
CatWeight         22.9673     6.3651    3.61   0.0013 **
CatAge             0.7513     0.6140    1.22   0.2321   
CatWeight:CatAge  -0.0742     0.1149   -0.65   0.5238   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 11.1 on 26 degrees of freedom
Multiple R-squared:  0.799,	Adjusted R-squared:  0.776 
F-statistic: 34.5 on 3 and 26 DF,  p-value: 3.22e-09
```

Interpreting the coefficients
=================================================================
- Let's look at just the coefficients:

```r
kable(summary(lm_catfood_interaction)$coefficients)
```



|                 | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------|--------:|----------:|-------:|------------------:|
|(Intercept)      |  -26.780|     33.289|  -0.804|              0.428|
|CatWeight        |   22.967|      6.365|   3.608|              0.001|
|CatAge           |    0.751|      0.614|   1.224|              0.232|
|CatWeight:CatAge |   -0.074|      0.115|  -0.646|              0.524|
- Looks like only the coefficient for CatWeight is significantly different from 0, while the coefficients for CatAge and the interaction aren't.
- Important: these *t*-tests measure how much of the variance each predictor explains **given that all the other predictors are in the model as well**.

The rest of the results
=================================================================
- Residuals: Gives you a quick overview of the distribution of residuals
    - Is the median (roughly) 0?
    - Is quartile 1 roughly as far away from the median as quartile 3?
    - Are the minimum or maximum extremely far away from the median?
- Residual standard error: 
    - This is an estimate of the error variance: On average, how far away are the true values from the predicted values?

The rest of the results (2)
=================================================================
- Multiple R-squared:
    - $R^2 = \frac{SS_{Model}}{SS_{Total}}$
    - What is the percentage of the total variance that can be explained by the model?
    - This is a meaasure of effect size (exactly the same as $\eta^2$)
- Adjusted R-squared:
    - This is an adjustment to $R_2$ that takes into account the number of predictors used
    - With enough predictors, you can fit anything
    - We want a model that explains as much of the variance as possible with as few predictors as possible

The rest of the results (2)
=================================================================
- F-statistic: This compares the variance explained by the model ($MS_{Model}$) with the unexplained variance ($MS_{Error}$) -- just like an ANOVA.
    - The dfs work just like in ANOVA: you have one Model df for each parameter that you estimate
    - $df_{Error} = df_{Total} - df_{Model}$
    - $df_{Total} = n - 1$, where $n$ is the number of observations; you lose one df for computing the intercept.
- You can also conceptualise this as testing whether the model with the 3 predictors is better than a model using only the intercept.

Regression and F-Tests
=================================================================
- You can use F-Tests to compare any regression models that you want
  - Although the comparison only makes sense if they share predictors
- For example, is a model containing the CatWeight by CatAge interaction better than a model without it?

```r
anova(lm_catfood_interaction, lm(formula = FoodEaten ~ CatWeight + CatAge, data = catfood_age))
```

```
Analysis of Variance Table

Model 1: FoodEaten ~ CatWeight * CatAge
Model 2: FoodEaten ~ CatWeight + CatAge
  Res.Df  RSS Df Sum of Sq    F Pr(>F)
1     26 3221                         
2     27 3273 -1     -51.7 0.42   0.52
```

Regression and F-Tests (2)
=================================================================
- You can use the `anova` command for this. If you only give one linear model to the ANOVA command, it will run an F-Test for each predictor

```r
anova(lm_catfood_interaction)
```

```
Analysis of Variance Table

Response: FoodEaten
                 Df Sum Sq Mean Sq F value  Pr(>F)    
CatWeight         1  11346   11346   91.59 5.3e-10 ***
CatAge            1   1437    1437   11.60  0.0022 ** 
CatWeight:CatAge  1     52      52    0.42  0.5238    
Residuals        26   3221     124                    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Why do we get conflicting results?
=================================================================
- This is weird: We didn't have an effect for CatAge when we looked at the *t*-values, but we have when doing F-tests?

```r
kable(anova(lm_catfood_interaction))
```



|                 | Df|  Sum Sq| Mean Sq| F value| Pr(>F)|
|:----------------|--:|-------:|-------:|-------:|------:|
|CatWeight        |  1| 11345.9| 11345.9|  91.588|  0.000|
|CatAge           |  1|  1436.6|  1436.6|  11.596|  0.002|
|CatWeight:CatAge |  1|    51.7|    51.7|   0.418|  0.524|
|Residuals        | 26|  3220.9|   123.9|      NA|     NA|
- The answer lies in **what each test compares**. This may sound nitpicky, but it's really important!

Model comparisons
=================================================================
- The *t*-values compare a model containing the predictor *along with* all the other predictors to a model containing *all the other predictors* **except** the predictor in question.
- The `anova` command compares a model containing the predictor **and all other predictors** entered *so far* with a model only containing the predictors entered **so far**
    - This means that **order matters**. In this case, the CatWeight by CatAge interaction isn't entered yet.
    - This is called **Type I sums of squares**
- The `anova` command is dumb and can only do Type I SS, but there is an alternative in the `car` package, cleverly labeled `Anova`
  - Use `install.packages("car")` to get the `car` package if you don't have it already

Sums of squares
=================================================================
- Type I: Compare a model containing the predictor **and all other predictors** entered *so far* with a model only containing the predictors entered **so far** (order matters).
    - This is what the `anova` command does.
- Type II: The *t*-values compare a model containing the predictor *along with* all the other predictors to a model containing *all the other predictors* **except** the predictor in question **and its interactions**.
    - This is the standard in ezANOVA.
- Type III: The *t*-values compare a model containing the predictor *along with* all the other predictors to a model containing *all the other predictors* **except** the predictor in question, but **including its interactions**.
    - This is the equivalent of the *t*-tests.
    - This is the standard in SPSS.


Example: Type I sum of squares
=================================================================

```r
kable(anova(lm_catfood_interaction))
```



|                 | Df|  Sum Sq| Mean Sq| F value| Pr(>F)|
|:----------------|--:|-------:|-------:|-------:|------:|
|CatWeight        |  1| 11345.9| 11345.9|  91.588|  0.000|
|CatAge           |  1|  1436.6|  1436.6|  11.596|  0.002|
|CatWeight:CatAge |  1|    51.7|    51.7|   0.418|  0.524|
|Residuals        | 26|  3220.9|   123.9|      NA|     NA|

Example: Type II sum of squares
=================================================================

```r
library(car)
kable(Anova(lm_catfood_interaction,type = "II"))
```



|                 |  Sum Sq| Df| F value| Pr(>F)|
|:----------------|-------:|--:|-------:|------:|
|CatWeight        | 10766.2|  1|  86.908|  0.000|
|CatAge           |  1436.6|  1|  11.596|  0.002|
|CatWeight:CatAge |    51.7|  1|   0.418|  0.524|
|Residuals        |  3220.9| 26|      NA|     NA|

Example: Type III sum of squares
=================================================================

```r
library(car)
kable(Anova(lm_catfood_interaction,type = "III"))
```



|                 | Sum Sq| Df| F value| Pr(>F)|
|:----------------|------:|--:|-------:|------:|
|(Intercept)      |   80.2|  1|   0.647|  0.428|
|CatWeight        | 1612.9|  1|  13.020|  0.001|
|CatAge           |  185.5|  1|   1.497|  0.232|
|CatWeight:CatAge |   51.7|  1|   0.418|  0.524|
|Residuals        | 3220.9| 26|      NA|     NA|

Summary: Sums of square types
==================================================================
- ANOVA results (both classic ANOVA and regression model tests) can vary depending on which SS you use
    - Make sure that you know which ones you are using
    - If you are using SPSS, the answer is *probably* III.
- In standard ANOVA (with only discrete predictors), all SS types give the same result *as long as your design is balanced*
    - An unbalanced design will lead to differing sums of squares.
- In multiple regression, all SS types give the same result *as long as your predictor variables are not correlated*

Back to the current model
=================================================================
- **Important**: The above model has a **critical flaw**, so read on before you run off and perform multiple regressions.
- The flaw is related to correlations between predictors (multicollinearity).
- Specifically, we seem to have the issue that CatAge is significant on its own, but loses significance if the interaction CatWeight:CatAge is already in the model
- Can we test this idea in a more formal way?

Multicollinearity
=================================================================
- Once again: Type III SS and *t*-tests measure how much of the variance each predictor explains **given that all the other predictors are in the model as well**.
- This may not seem important at first, but often, the predictors will be correlated themselves
- This is called *multicollinearity*.

```r
cor(catfood_age$CatWeight, catfood_age$CatAge)
```

```
[1] 0.0665
```
- In this case, they aren't. So where is the problem?

Multicollinearity (2)
=================================================================
- Imagine what would happen if CatWeight and CatAge were somehow (almost)perfectly correlated
- Actually, let's just try it

```r
# make a copy of catfood_age
catfood_age_bizarre <- catfood_age
catfood_age_bizarre$CatAge <- catfood_age_bizarre$CatWeight/10 + rnorm(nrow(catfood_age_bizarre), 0, .0001)
```
- We're entering a bizarre world where each cat's age is exactly 1/10th of its weight
- I added a tiny little bit of random variance because perfect correlations really mess up regression

Multicollinearity (3)
=================================================================
- Neat little trick: If you give `plot` just a data frame object instead of columns, it will make every possible scatter plot from the data (a scatter plot matrix).

```r
plot(catfood_age_bizarre)
```

![plot of chunk unnamed-chunk-23](Class5-figure/unnamed-chunk-23.png) 

Multicollinearity (4)
=================================================================

```r
summary(lm(formula = FoodEaten ~ CatWeight + CatAge, data = catfood_age_bizarre))
```

```

Call:
lm(formula = FoodEaten ~ CatWeight + CatAge, data = catfood_age_bizarre)

Residuals:
    Min      1Q  Median      3Q     Max 
-23.462  -9.629  -0.404  10.424  20.680 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)
(Intercept)      7.96      11.71    0.68     0.50
CatWeight     3621.38    2191.86    1.65     0.11
CatAge      -36019.22   21919.05   -1.64     0.11

Residual standard error: 12.6 on 27 degrees of freedom
Multiple R-squared:  0.733,	Adjusted R-squared:  0.714 
F-statistic: 37.1 on 2 and 27 DF,  p-value: 1.78e-08
```

What a mess!
=================================================================

```r
kable(summary(lm(formula = FoodEaten ~ CatWeight + CatAge, data = catfood_age_bizarre))$coefficients)
```



|            |  Estimate| Std. Error|   t value| Pr(>&#124;t&#124;)|
|:-----------|---------:|----------:|---------:|------------------:|
|(Intercept) |  7.96e+00|   1.17e+01|  6.80e-01|           5.02e-01|
|CatWeight   |  3.62e+03|   2.19e+03|  1.65e+00|           1.10e-01|
|CatAge      | -3.60e+04|   2.19e+04| -1.64e+00|           1.12e-01|
- Neither CatWeight nor CatAge are significant  -- nothing is!
- If you compare the standard errors of the estimates to the "sane" model, they are huge.
    - That is because the model has a hard time determining the estimates
      - If the predictors are perfectly correlated, you can make equally good predictions no matter what the value of coefficient 1 is -- you just have to adjust coefficient 2 to compensate!

What a mess! (2)
=================================================================
- This model is really hard to interpret
    - CatWeight or CatAge would have a strong effect individually
    - But neither predictor adds anything if the other one is already in the model
- Make sure to check for correlations between predictors before running a regression
- Start by using the scatter plot matrix, then you can run `cor` on individual predictors
- Important: Some multicollinearity is unavoidable, but the higher values are correlated, the more problems you get


Diagnosing Multicollinearity
================================================================
- You can use `vif` from the `car` package
- First the sane data, where cat age isn't almost perfectly correlated with cat weight (note that I'm taking the interaction out for the time being)

```r
library(car)
vif(lm(formula = FoodEaten ~ CatWeight + CatAge, data = catfood_age))
```

```
CatWeight    CatAge 
        1         1 
```

Diagnosing Multicollinearity
================================================================
- Now the insane data, where all cats gain 100 grammes per month for some bizarre reason.

```r
library(car)
vif(lm(formula = FoodEaten ~ CatWeight + CatAge, data = catfood_age_bizarre))
```

```
CatWeight    CatAge 
   900765    900765 
```

Interpreting the VIF
=================================================================
- You have a problem with mulitcollinearity if
    - The largest VIF is greater than 10 and/or
    - The average VIF is substantially greater than 1
- Multicollinearity seriously affects the interpretability of your model
- Both criteria are true for the bizarre data
- Neither is true for the non-bizarre data

Now what about that problematic interaction model?
==================================================================
- We use the non-bizarre data (of course)

```r
vif(lm_catfood_interaction)
```

```
       CatWeight           CatAge CatWeight:CatAge 
            9.72            33.79            44.75 
```
- Those are some seriously high VIFs!
- What is going on?

Where does the multicollinearity come from?
==================================================================
- Here's the problem: The interaction effect is equivalent to CatWeight x CatAge
- Unfortunately, the product of the two variables is highly correlated with both variables:

```r
with(catfood_age, cor(CatWeight, CatWeight*CatAge))
```

```
[1] 0.498
```

```r
with(catfood_age, cor(CatAge, CatWeight*CatAge))
```

```
[1] 0.885
```

What to do?
===================================================================
- Luckily, there is an easy solution:
  - If we **center** both variables (i.e. subtract the mean from each observation), the correlation will disappear
  - You can center variables either by hand `x - mean(x)` or by using `scale(x, scale = FALSE)` (one of the least intuitive commands I've seen so far!)

```r
catfood_age$CatWeight <- catfood_age$CatWeight - mean(catfood_age$CatWeight)
catfood_age$CatAge <- catfood_age$CatAge - mean(catfood_age$CatAge)
```

Did this help?
===================================================================
- Yes, it did:

```r
with(catfood_age, cor(CatWeight, CatWeight*CatAge))
```

```
[1] 0.351
```

```r
with(catfood_age, cor(CatAge, CatWeight*CatAge))
```

```
[1] 0.308
```

```r
# re-fit the model
lm_catfood_interaction <- lm(formula = FoodEaten ~ CatWeight * CatAge, data = catfood_age)
vif(lm_catfood_interaction)
```

```
       CatWeight           CatAge CatWeight:CatAge 
            1.14             1.11             1.26 
```

Let's look at the coefficients again
===================================================================

```r
kable(summary(lm_catfood_interaction)$coefficients)
```



|                 | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------|--------:|----------:|-------:|------------------:|
|(Intercept)      |  104.899|      2.037|  51.488|              0.000|
|CatWeight        |   19.563|      2.182|   8.965|              0.000|
|CatAge           |    0.382|      0.111|   3.440|              0.002|
|CatWeight:CatAge |   -0.074|      0.115|  -0.646|              0.524|
- Look at that: Now CatAge is significant, too!
- We would have made a Type II error if we hadn't centered the variables.
- Lesson of this story: When testing for interactions with continuous variables, **always center the continuous variables**.

Influential cases
====================================================================
- Meet Goliath, the cat

![Big cat](http://www.zakshow.com/show/cat2.jpg)

- He's very heavy (20 kg more than the average) and isn't very old (4 months more than the average) but doesn't eat much (101 g).

Influential cases (2)
====================================================================
- Let's add him to the data:

```r
catfood_goliath <- rbind(catfood_age, c(20, 4, 101))
# don't forget to re-center the predictors!
catfood_goliath$CatWeight <- scale(catfood_goliath$CatWeight, scale = FALSE)
catfood_goliath$CatAge <- scale(catfood_goliath$CatAge, scale = FALSE)
```

Influential cases (3)
====================================================================
- Make a plot of the situation. See Goliath out there?

```r
plot(catfood_goliath)
```

![plot of chunk unnamed-chunk-34](Class5-figure/unnamed-chunk-34.png) 

Influential cases (4)
====================================================================
- What will he do to the model?

```r
lm_goliath <- lm(formula = FoodEaten ~ CatWeight * CatAge, data = catfood_goliath)
kable(coef(summary(lm_goliath)))
```



|                 | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------|--------:|----------:|-------:|------------------:|
|(Intercept)      |  104.388|      4.106|  25.423|              0.000|
|CatWeight        |    0.792|      1.419|   0.558|              0.581|
|CatAge           |    0.440|      0.226|   1.943|              0.063|
|CatWeight:CatAge |    0.079|      0.228|   0.345|              0.733|
- That doesn't look too good!

Let's plot it
=====================================================================

```r
with(catfood_goliath, plot(x = CatWeight, y = FoodEaten))
abline(lm_goliath)
```

![plot of chunk unnamed-chunk-36](Class5-figure/unnamed-chunk-36.png) 

Diagnosing influential cases
======================================================================
- R has a convenient function called `influence.measures` giving you all the statistics you need.
  - To make this more readable here I'm using `kable` to only print the last rows of the statistics table (in order to see Goliath's case), but you can just use `influence.measures(your_lm_here)` to get a fairly comprehensive printout of all the cases.

Diagnosing influential cases (2)
======================================================================

```r
kable(tail(influence.measures(lm_goliath)$infmat))
```



|   | dfb.1_| dfb.CtWg| dfb.CtAg| dfb.CW:C|   dffit| cov.r| cook.d|   hat|
|:--|------:|--------:|--------:|--------:|-------:|-----:|------:|-----:|
|26 | -0.020|    0.051|    0.028|   -0.067|  -0.094| 1.527|  0.002| 0.242|
|27 | -0.116|    0.067|   -0.011|   -0.029|  -0.143| 1.132|  0.005| 0.042|
|28 |  0.312|    0.162|   -0.319|   -0.221|   0.436| 0.930|  0.046| 0.083|
|29 | -0.238|    0.090|    0.050|   -0.061|  -0.283| 0.907|  0.019| 0.039|
|30 | -0.238|    0.111|   -0.044|    0.054|  -0.308| 0.975|  0.023| 0.057|
|31 | -6.447|  -26.570|    0.934|    1.346| -33.904| 0.056| 71.180| 0.933|

Diagnosing influential cases (3)
======================================================================
- One row per observation/case
- Columns:
- DFBetas (one for each predictor) 
    - Difference between the parameter when this case is excluded and when it is included
    - Should not be much larger than that of the other cases
- DFFit
    - Difference between the predicted value for a case when this case is excluded and when it is included
    - Should not be much larger than that of the other cases
- Covariance ratio
    - The farther it is from 1 and the smaller it is the more this case increases the error variance

Diagnosing influential cases (4)
========================================================================
- Cook's distance
    - Measure of the overall influence of a case on the model
      - Values > 1 are possibly problematic
- Hat = leverage
    - How strongly does this case influence the prediction?
    - Average value is $p/n$, where $p$ is the number of predictors (including the intercept, so 4 for our model) and $n$ is the number of observations(31 for our model, so our average should be .13)
    - Values over 2 or 3 times the average should be cause for concern

General strategy for diagnosing influential cases
==========================================================================
- Check if any cases have a Cook's distance of > 1
- Then check if they have an undue effect on the model using the other statistics
- If called directly, influence.measures gives you a column called "Inf", flagging potentially influential cases. 
  - If Cook's distance for these cases is > 1, consider removing them.

More assumption tests
===========================================================================
- Normality of the residuals (we already know that one)

```r
shapiro.test(resid(lm_catfood_interaction))
```

```

	Shapiro-Wilk normality test

data:  resid(lm_catfood_interaction)
W = 0.945, p-value = 0.1215
```

More assumption tests (2)
===========================================================================
- Normality of the residuals (we already know that one)

```r
shapiro.test(resid(lm_catfood_interaction))
```

```

	Shapiro-Wilk normality test

data:  resid(lm_catfood_interaction)
W = 0.945, p-value = 0.1215
```

More assumption tests (2)
===========================================================================
- Durbin-Watson test for autocorrelated errors (in `car` package)
- Are adjacent residuals correlated?

```r
durbinWatsonTest(lm_catfood_interaction)
```

```
 lag Autocorrelation D-W Statistic p-value
   1          -0.216          2.35    0.31
 Alternative hypothesis: rho != 0
```
- Not in this case.

More assumption tests (3)
===========================================================================
- Heteroskedasticity
    - Look at the plot of residuals by predicted values
    - Does it look like there is more variance for certain predicted values?

```r
plot(x = predict(lm_catfood_interaction), y = resid(lm_catfood_interaction))
```

![plot of chunk unnamed-chunk-41](Class5-figure/unnamed-chunk-41.png) 

Reporting the regression results
===================================================================
- Make a table with the model coefficients:

```r
lm_catfood_interaction_table <- coef(summary(lm_catfood_interaction))
kable(lm_catfood_interaction_table)
```



|                 | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------|--------:|----------:|-------:|------------------:|
|(Intercept)      |  104.899|      2.037|  51.488|              0.000|
|CatWeight        |   19.563|      2.182|   8.965|              0.000|
|CatAge           |    0.382|      0.111|   3.440|              0.002|
|CatWeight:CatAge |   -0.074|      0.115|  -0.646|              0.524|
- Introductory paragraph: In order to test the hypothesis that cat weight and cat age can predict how much food a cat eats, we performed a multiple regression analysis  with food eaten (in g) as the dependent variable and cat weight and cat age as well aas their interactions as continuous independent variables. The model explained a very high amount of the variance in the dependent variable, with an adjusted $R^2$ of 0.776.


Reporting the regression results
===================================================================
Our results show that both cat weight (b = 19.563, SE = 2.182, t = 8.965, p = 1.958 &times; 10<sup>-9</sup>) and cat age (b = 0.382, SE = 0.111, t = 3.44, p = 0.002)) had a significant effect on the food eaten.
