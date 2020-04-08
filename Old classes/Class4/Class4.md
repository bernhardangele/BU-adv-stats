Advanced Statistics
========================================================
author: Bernhard Angele
date: Lecture 4


Linear regression
========================================================
- So far, we've figured out how to test if a *discrete* predictor (e.g. treatment group) can explain the variance in a *continuous* variable.
- What if our predictor is also *continuous*?

- Example:
    - More exciting data about cats and cat food!
    - Is the amount of cat food a cat eats related to its weight?
    - In other words, do heavy cats eat more?
    
Cat food and weight
=========================================================


- This table actually has 30 rows, but I'm just showing you the first 6.
- You can find the full data set on myBU.
- You have cat weight in kg and cat food eaten in g.
- Looks like there might be a positive relationship here.


| CatWeight| FoodEaten|
|---------:|---------:|
|      5.37|      96.8|
|      5.40|      97.9|
|      4.27|      96.7|
|      5.95|     102.5|
|      4.47|      79.6|
|      4.93|      71.6|

Let's plot it
==========================================================
![plot of chunk unnamed-chunk-3](Class4-figure/unnamed-chunk-3-1.png)

Fitting a line to the data
==========================================================
- Let's put a line through it

![plot of chunk unnamed-chunk-4](Class4-figure/unnamed-chunk-4-1.png)

- Looks like we have a strong positive relationship:
    - The heavier the cat (variable $x$), the more food eaten (variable $y$).

Fitting a line to the data
==========================================================
- What is this line?
  - There are lots of possible lines to draw for data like these
      - What is the best line to describe these data?
      - Remember (from school) that a line is (exhaustively) described by an equation such as $$y = a+b\cdot x$$
          - $a$ is called the *intercept*. It describes where the line intersects the $y$-axis
          - $b$ is called the *slope*. It describes by how many units $y$ changes when $x$ changes
          - You may have learned this as $y = mx + c$ depending on where you went to school

The Least-Squares regression line
=========================================================
- How do we find the best $a$ and $b$ for the data?
  - Since we are (as always) taking samples from a larger population, no line will ever fit the data perfectly (i.e. go through all the points), even if there is a perfect linear relationship in the population
  - We can determine the line that best estimates the actual data points, though
      - What does "best" mean?
        - We want the line that minimises the deviations of the values predicted by the equation ($\hat{y}$) from the actual $y$ values
          - Actually, we want to penalise large deviations, so we use the square: $$\sum\limits_{i=1}^{n}(y_i - \hat{y}_i)^2 =min$$

The Least-Squares regression line
=========================================================
- Here, I've plotted the deviations of the predicted values (on the line) from the actual values. These are also called the **residuals**.

![plot of chunk unnamed-chunk-5](Class4-figure/unnamed-chunk-5-1.png)

- For the simple case where all we do is predict one $y$ from one $x$ variable, the $b$ value is really easy to calculate. We start with the covariance.

Covariance
=======================================================
- Defined as: $$cov(x, y) = \frac{\sum\limits_{i = 1}^n {(x_i - \bar{x})\cdot(y_i - \bar{y})}}{n-1}$$
  - The covariance gives us a measure of how much $x$ and $y$ vary together: 
      - if $x$-values that are far away from the mean co-occur with $y$ values that are also far from the mean, we get a large absolute covariance (it can be either positive or negative, depending on which way the relationship between $x$ and $y$ goes)
      - if $x$-values that are far away from the mean co-occur with $y$ values that are close to the mean (and vice-versa), we get a small absolute covariance (i.e. $x$ and $y$ don't change together)

Covariance, the regression slope, and correlation
======================================================
- In the simple regression case, we can compute the regression slope from the covariance: $$b = \frac{cov(x, y)}{s_x^2}$$
- Why? The explanation would involve derivatives, which you may not want to deal with right now.
- We get the **correlation** $r$ if we standardise the covariance by dividing it by the product of the standard deviations ($s_x \cdot s_y$). In short, $r = \frac{cov(x, y)}{s_x \cdot s_y}$.

Sums of squares
===========================================================
- We can also express how well our model predicts the data as **sums of squares**
- The total sums of squares is simply the numerator of the variance of $y$ (just like in the ANOVA): ${SS}_{total} = \sum\limits_{i=1}^{n}(y_i - \bar{y})^2$
- The **regression** or model sums of squares is the variance explained by the regression model: ${SS}_{model} = \sum\limits_{i=1}^{n}(\hat{y}_i - \bar{y})^2$
- The residual sums of squares is the squared differences $e_i$ between the actual $y$-values and the predicted $\hat{y}$-values: ${SS}_{residual} =  \sum\limits_{i=1}^{n}e_i = \sum\limits_{i=1}^{n}(y_i - \hat{y}_i)^2$
- Of course, these add up just like in the ANOVA: $SS_{total} = {SS}_{model} + {SS}_{residual}$


Coefficient of determination
============================================================
- Remember $\eta^2$ for the ANOVA? We can do the same thing for the sums of squares in the regression:
$$r^2 = \frac{{SS}_{model}}{{SS}_{total}}$$
- $\frac{{SS}_{model}}{{SS}_{total}}$ is the same as the square of the correlation coefficient $r$.
    - Fun activity at home: Work out why!
- In multiple regression, we call the coefficient of determination $R^2$ instead of $r^2$. Here, we have multiple predictors and multiple correlations, so $R^2$ doesn't correspond to the square of any one of them. It still tells you how much variance your model explains, though.
- In our example: $r^2 = 0.154$

Hypothesis tests
==========================================================
- We assume that there is the following linear relationship in our population: $$Y_i = \alpha + \beta\cdot x_i + \epsilon_i$$
  - $\alpha$ and $\beta$ are our population coefficients. $\epsilon_i$ is the error for this particular observation.
- We will need to estimate our regression equation based on our sample, so that $a$ and $b$ are estimates of the population coefficients $\alpha$ and $\beta$.
- $\epsilon$ is the **error**. It represents all the influences (random or not) that we are not considering in the linear relationship.
    - If the relationship is actually linear, then $E(\epsilon) = 0$
- How can we interpret these estimated coefficients? Mostly, we care about whether $\beta$ is 0, i.e. whether there is a significant relationship between $x$ and $y$ in the population.

Assumptions
==========================================================
- First, we need to assume that $x$ and $y$ come from a **bivariate** normal distribution (i.e. that they are both normally distributed) with means $\mu_x$ and $\mu_y$, variances $\sigma^2_x$ and $\sigma^2_y$, and covariance $\sigma_{x,y}$.
- The bivariate (or, more generally, multivariate) normal distribution assumes that:
    - For each $x$-value $x_j$, the corresponding $y_{(i|x_j)}$-values are normally distributed: $\epsilon \sim N(0, \sigma_{\epsilon}^2$)
    - For each $x$-value $x_j$, the corresponding $y_{(i|x_j)}$-values have the same standard deviation (homoscedasticity assumption): $Var(\epsilon_i) = \sigma_{\epsilon}^2$
    - For each $x$-value $x_j$, the corresponding $y_{(i|x_j)}$-values are independent (i.e. all $\epsilon_i$ are independent)
- Pretty similar to the ANOVA assumptions, actually. I wonder why?

Distribution of the coefficient estimates
===========================================================
- If our assumptions are met, our coefficient estimates $a$ and $b$ will be themselves normally distributed
- What do their distributions look like?
- What about the means (or rather, the expected values?): $E(a) = \alpha$; $E(b) = \beta$ (no derivations here, just the end results)
- What about the variance?
  - We don't really care about $a$, but $b$ is important: $$\sigma^2_b = \frac{\sigma_{\epsilon}^2}{\sum\limits_{i=1}^{n}(x_i-\bar{x})^2} = \frac{\sigma_{\epsilon}^2}{(n-1)\cdot s^2_{x}}$$
- This means that the sampling variance of our estimate of $\beta$ will be smaller when:
    - the overall error variance is small
    - our $x$-values are spread out (covering a wide range)

Doing a hypothesis test on b
==========================================================
- We now know the sampling distribution of $b$: $$ b \sim N\left(\beta, \frac{\sigma_{\epsilon}}{\sqrt{\sum\limits_{i=1}^{n}(x_i-\bar{x})^2}}\right)$$
- All we need to do is find an estimate for $\sigma_{\epsilon}$
- We can get this by calculating the variance of the residuals (the error): $$s^2_e = \frac{\sum\limits_{i = 1}^{n} e_i^2}{n-2} = \frac{\sum\limits_{i = 1}^{n} (y_i - \hat{y}_i)^2}{n-2}$$
    - Why divide by $n-2$? So we get an unbiased estimator of the error. Not showing you the derivation of why it has to be $n-2$.
- Since we are *estimating* the error variance, we need to use the *t*-distribution instead of the standard normal distribution.

Testing coefficients
===========================================================
- Our null hypothesis is usually $H_0: \beta = 0$
    - i.e. there is no systematic relationship between $x$ and $y$; you can't predict $y$ from $x$
- We calculate a *t*-value for our observed $b$ just like we do when we're comparing means: $$t = \frac{b - \beta_0}{\sqrt{\hat{\sigma_b}^2}}$$ where $\beta_0$ is the value of $\beta$ assumed by the null hypothesis. In our case, $\beta_0 = 0$, to we can rewrite this as $t = \frac{b}{\sqrt{\hat{\sigma_b}^2}}$
- As always, this *t*-value has as many degrees of freedom as the estimated variance, i.e. $n-2$ in the case of the error variance.
- We can also get confidence intervals, just like when comparing means: $CI: b \pm t_{\alpha/2}\cdot\hat{\sigma_b}$. We reject the $H_0$ if the CI doesn't include 0.

Back to our example
=============================================================
![plot of chunk unnamed-chunk-6](Class4-figure/unnamed-chunk-6-1.png)
- We can calculate $b$ from the data by first getting the covariance:
    - $cov(CatWeight,FoodEaten) = \frac{\sum\limits_{i = 1}^n {(CatWeight_i - \bar{CatWeight})\cdot(FoodEaten_i - \bar{FoodEaten})}}{n-1} = 3.766$
- Then $$b = \frac{cov(CatWeight, CatFood)}{s_{CatWeight}^2} = \frac{3.766}{0.367} = 10.261$$

Back to our example (2)
===============================================================
- Now calculate the standard error of $b$ (replacing $CatWeight$ with $x$ for better readability: $$\hat{\sigma_b^2} = \frac{\sigma_{\epsilon}^2}{(n-1)\cdot s^2_{x}} = \frac{\frac{\sum\limits_{i = 1}^{n} (y_i - \hat{y}_i)^2}{n-2}}{(n-1)\cdot s^2_{x}} = \frac{\frac{6146.544}{30 - 2}}{(30 - 1)\cdot 0.367} = 20.626$$
- And the $t$-value: $$t_{28} = \frac{b}{\sqrt{\hat{\sigma_b}^2}} = \frac{10.261}{\sqrt{20.626}} = \frac{10.261}{4.542} = 2.259$$
- And the *p*-value (look it up in Excel): $p(|t_{28}| = 2.259) = 0.016$
- Remember, we are doing a two-tailed test, so we have to multiply the p-value by 2 if we want to compare it to $\alpha = .05$: $p =0.032$ 
- Looks like we can reject the $H_0$ this time: Heavier cats tend to eat more.

Can we also do an F-test?
================================================================
- Of course we can!
- $MS_{model} = \frac{SS_{model}}{df_{model}} = \frac{\sum\limits_{i=1}^{n}(\hat{y}_i - \bar{y})^2}{1} = 1120.577$
  - $df_{model}$ is the number of slopes that we're estimating.
- $MS_{residual} = \frac{SS_{residual}}{df_{residual}} = \frac{\sum\limits_{i=1}^{n}e_i = \sum\limits_{i=1}^{n}(y_i - \hat{y}_i)^2}{n-2} = \frac{6146.544}{30 - 2} = 219.519$
- $F_{(1, 28)} = \frac{MS_{model}}{MS_{residual}} = \frac{1120.577}{202.885} = 5.105$
- $p(F_{(1, 28)} = 5.105) = 0.032$ 
- Guess what? The square root of the *F*-value is our *t*-value. Again, this only works if we have one single predictor: $\sqrt{F_{(1,28)}} = t_{28} = 2.259$

Summary: What did we find?
============================================================
- The best fitting line for the cat food data intersects the $y$-axis at the point (0, 51.885).
  - (We never bothered to estimate $a$ by hand, but that's what you would get.)
  - Not all x-values are sensible for all data. Saying that a cat with 0 kg weight would eat 51.885 g of food makes no sense, since a cat with 0 kg weight is not a cat.
  - The linear function doesn't care, of course. It knows nothing about our data and just specifies a line.
- The slope might be more useful: It says that for each kg of extra weight, a cat will eat 10.261 more grammes of food.
    - Using this information, we can predict that a giant 8 kg cat would eat $51.885 + 10.261 \cdot 8 = 133.973$ g of food.
    
Summary: Predictions and residual errors
===============================================================
- Of course, our prediction is likely to be at least a little off.
- If we had an 8 kg cat in our data and its actual amount of food consumed was 170 g, we'd have an error of $e_i = 36.027$.
  - This is called the residual error.
- More formally, the **population** regression equation looks like this (where $x_i$ are the individual values for the $x$ variable, and $y_i$ are the corresponding values for the $Y$ variable):
    - $y_i = \alpha + \beta_1 x_i + \epsilon_i$
    - Here, we've simply renamed the intercept to $\alpha$ and the slope to $\beta_1$.
    - $\epsilon_i$ is the residual error for each data point.
    - Important: $\epsilon_i$ is assumed to be normally distributed
      - This doesn't matter for the line fitting, but it does for the hypothesis tests!
      
Summary: Hypothesis testing
=================================================================
- Important: Note that the $\beta$ variables are greek letters, which means they are the *population parameters*
- For each $\beta$ coefficient in the regression formula, we can propose the $H_0$ that the true value of that $\beta$ coefficient is 0
- The $\beta$ that are estimated from our sample are simply called $b$
- We can once again test if our $b$ values are extreme enough so they would only occur 5% of the time or less given the $H_0$.
- We test this separately for each $b$ value. Guess what, it's a *t*-test!
- We also test whether the intercept is 0
    - This is usually not particularly interesting unless you have a very specific hypothesis about the intercept.

Multiple regression
=================================================================
- Unlike simply running a hypothesis test on a correlation, we can easily add another predictor to a linear model, making it a multiple regression model, where $x_{1i}$ is observation *i* on the first predictor and $x_{2i}$ is observation *i* on the second predictor:
    - $y_i = \alpha + \beta_1 x_{1i} + \beta_2 x_{2i} + \beta_3 x_{1,i} \cdot x_{2,i} + \epsilon_i$
    - Note that we have an interaction term in this equation: $\beta_3 x_{1,i} \cdot x_{2,i}$
      - We could also specify the model without the interaction if we think there might be a possibility that the effects are just additive:
          - $y_i = \alpha + \beta_1 x_{1i} + \beta_2 x_{2i} + \epsilon_i$
    - Which of the models is better?
      - That's exactly what we want to find out!
      
Example
==================================================================
- Let's assume that, apart from each cat's weight in kg, we also have its age in months:


| CatWeight| CatAge| FoodEaten|
|---------:|------:|---------:|
|      5.37|  25.84|      96.8|
|      5.40|  18.77|      97.9|
|      4.27|  62.42|      96.7|
|      5.95|  30.85|     102.5|
|      4.47|  21.75|      79.6|
|      4.93|   9.02|      71.6|
- Does adding age  to the model improve it?
- Open the file `catfood_age.csv` from myBU in SPSS

The regression output
==================================================================
- Multiple regression gets computationally intense, so let's leave this to SPSS
- First, let's fit the model without the interaction.
- For your convenience (and to make sure you got things right), here's the output from R


```

Call:
lm(formula = FoodEaten ~ CatWeight + CatAge, data = catfood_age)

Residuals:
   Min     1Q Median     3Q    Max 
-20.81  -5.41   1.49   4.46  27.94 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -10.4377    19.7290   -0.53      0.6    
CatWeight    17.7645     3.5024    5.07 0.000025 ***
CatAge        0.4555     0.0847    5.38 0.000011 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 10.5 on 27 degrees of freedom
Multiple R-squared:  0.592,	Adjusted R-squared:  0.562 
F-statistic: 19.6 on 2 and 27 DF,  p-value: 0.00000557
```

Interpreting the coefficients
=================================================================
- Let's look at just the coefficients:


|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |  -10.438|     19.729|  -0.529|              0.601|
|CatWeight   |   17.765|      3.502|   5.072|              0.000|
|CatAge      |    0.456|      0.085|   5.381|              0.000|

- Looks like both the coefficient for CatWeight and the coefficient for CatAge are significantly different from 0

Now let's add the interaction term
=================================================================
- Note that SPSS is a bit annoying about this, making you calculate the interaction term yourself


|                 | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------|--------:|----------:|-------:|------------------:|
|(Intercept)      |   22.568|     46.302|   0.487|              0.630|
|CatWeight        |   11.357|      8.853|   1.283|              0.211|
|CatAge           |   -0.067|      0.668|  -0.101|              0.920|
|CatWeight:CatAge |    0.103|      0.131|   0.789|              0.437|
- Now nothing is significant! What is going on?
- Important: these *t*-tests test the null hypothesis that each individual coefficient is 0 **given that all the other predictors are in the model as well**.

Why do we get conflicting results?
=================================================================
- This is weird: We didn't have an effect for CatAge when we looked at the *t*-values, but we have when doing F-tests?


|                 | Df| Sum Sq| Mean Sq| F value| Pr(>F)|
|:----------------|--:|------:|-------:|-------:|------:|
|CatWeight        |  1| 1120.6|  1120.6|  10.058|  0.004|
|CatAge           |  1| 3180.4|  3180.4|  28.546|  0.000|
|CatWeight:CatAge |  1|   69.4|    69.4|   0.623|  0.437|
|Residuals        | 26| 2896.7|   111.4|      NA|     NA|

- The answer lies in **what each test compares**. This may sound nitpicky, but it's really important!

Types of sums of squares for the F-test
=================================================================
- Type I: Compare a model containing the predictor **and all other predictors** entered *so far* with a model only containing the predictors entered **so far** (order matters).
    - This is what the `anova` command in R does.
- Type II: Compare a model containing the predictor *along with* all the other predictors to a model containing *all the other predictors* **except** the predictor in question **and its interactions**.
    
- Type III: Compare a model containing the predictor *along with* all the other predictors to a model containing *all the other predictors* **except** the predictor in question, but **including its interactions**.
    - This is the equivalent of the *t*-tests.
    - This is the standard in SPSS.


Example: Type I sum of squares
=================================================================

|                 | Df| Sum Sq| Mean Sq| F value| Pr(>F)|
|:----------------|--:|------:|-------:|-------:|------:|
|CatWeight        |  1| 1120.6|  1120.6|  10.058|  0.004|
|CatAge           |  1| 3180.4|  3180.4|  28.546|  0.000|
|CatWeight:CatAge |  1|   69.4|    69.4|   0.623|  0.437|
|Residuals        | 26| 2896.7|   111.4|      NA|     NA|

Example: Type II sum of squares
=================================================================

|                 | Sum Sq| Df| F value| Pr(>F)|
|:----------------|------:|--:|-------:|------:|
|CatWeight        | 2826.2|  1|  25.367|  0.000|
|CatAge           | 3180.4|  1|  28.546|  0.000|
|CatWeight:CatAge |   69.4|  1|   0.623|  0.437|
|Residuals        | 2896.7| 26|      NA|     NA|

Example: Type III sum of squares
=================================================================

|                 |  Sum Sq| Df| F value| Pr(>F)|
|:----------------|-------:|--:|-------:|------:|
|(Intercept)      |   26.47|  1|   0.238|  0.630|
|CatWeight        |  183.36|  1|   1.646|  0.211|
|CatAge           |    1.14|  1|   0.010|  0.920|
|CatWeight:CatAge |   69.39|  1|   0.623|  0.437|
|Residuals        | 2896.73| 26|      NA|     NA|

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

Our problem
=================================================================
- This model is really hard to interpret
    - CatWeight or CatAge would have a strong effect individually
    - But neither predictor adds anything if the interaction is already in the model
    - Why? Because the interaction is strongly correlated with both of them!
- Make sure to check for correlations between predictors before running a regression
    - `Part- and partial correlations` in the `Statistics...` menu of the Linear Regression module
- Important: Some multicollinearity is unavoidable, but the more strongly your predictors are correlated, the more problems you get


Diagnosing Multicollinearity
================================================================
- Ask SPSS to give you collinearity diagnostics (in the `Statistics...` menu of the Linear Regression module).
- Now it will print out something called Variance Inflation Factors (VIFs)
- For your convenience, the VIFs for this model are printed below


```
       CatWeight           CatAge CatWeight:CatAge 
            7.49            72.98            62.16 
```

Interpreting the VIF
=================================================================
- You have a problem with mulitcollinearity if
    - The largest VIF is greater than 10 and/or
    - The average VIF is substantially greater than 1
- Multicollinearity seriously affects the interpretability of your model
  - In practice, it increases the estimate of the standard error of your coefficients $\sigma_{\beta}$
  - This reduces the power of the significance test

Where does the multicollinearity come from?
==================================================================
- Here's the problem: The interaction effect is equivalent to $CatWeight \cdot CatAge$
- What to do? Luckily, there is an easy solution to this particular issue:
  - If we **center** both variables (i.e. subtract the mean from each observation), the correlation will disappear
  - You can center variables using `Transform` --> `Compute Variable...`
  - Get the **mean** using `Analyze` --> `Descriptives...`, then subtract it from each observation of both variables:
    - $CatWeight - 4.935$; $CatAge - 55.52$
  - Save the new variables as `CatWeight_centered` and `CatAge_centered`

Does this help?
===================================================================

|                      | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:---------------------|--------:|----------:|-------:|------------------:|
|(Intercept)           |  103.128|      2.073|  49.751|              0.000|
|Cat Weight            |   17.082|      3.632|   4.704|              0.000|
|Cat Age               |    0.441|      0.087|   5.069|              0.000|
|Cat Weight by Cat Age |    0.103|      0.131|   0.789|              0.437|



|                      |  VIF|
|:---------------------|----:|
|Cat Weight            | 1.26|
|Cat Age               | 1.24|
|Cat Weight by Cat Age | 1.07|

- Yes, it does 

Let's look at the coefficients again
===================================================================


|                                   | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------------------------|--------:|----------:|-------:|------------------:|
|(Intercept)                        |  103.128|      2.073|  49.751|              0.000|
|CatWeight_centered                 |   17.082|      3.632|   4.704|              0.000|
|CatAge_centered                    |    0.441|      0.087|   5.069|              0.000|
|CatWeight_centered:CatAge_centered |    0.103|      0.131|   0.789|              0.437|

- Look at that: Now CatAge is significant, too!
- We would have made a Type II error if we hadn't centered the variables.
- Lesson of this story: When testing for interactions with continuous variables, **always center the continuous variables**.

Diagnosing influential cases
======================================================================
- Occasionally, you get **outliers** in your data. These are cases that differ quite a bit from the rest of the data. Often (but not always) outliers are caused by an error in measurement or coding. Outliers definitely merit closer attention.
- In SPSS, you can get a number of diagnostic values for each observation. You can save these to the Data Editor using the `Save...` button in the Linear Regression module.

Why you always need to look at your data
======================================================================
- These datasets all have the same regression line, but they look very different:

![plot of chunk unnamed-chunk-18](Class4-figure/unnamed-chunk-18-1.png)

Diagnosing influential cases (2)
======================================================================
- Diagnostic values you can save:
      - DFBetas (one for each predictor, including the intercept) 
          - Difference between the parameter when this case is excluded and when it is included
          - Should not be much larger than that of the other cases
          - Absolute value should not be > 1
      - DFFit
          - Difference between the predicted value for a case when this case is excluded and when it is included
          - Should not be much larger than that of the other cases
      - Covariance ratio
          - The farther it is from 1 and the smaller it is the more this case increases the error variance

Diagnosing influential cases (4)
========================================================================
- More diagnostic values you can save to the Data Editor:
  - Cook's distance
      - Measure of the overall influence of a case on the model
        - Values > 1 are possibly problematic
  - Hat = leverage
      - How strongly does this case influence the prediction?
      - Average value is $p/n$, where $p$ is the number of predictors (including the intercept, so 4 for our model) and $n$ is the number of observations(30 for our model, so our average should be 0.133)
      - Values over 2 or 3 times the average should be cause for concern

General strategy for diagnosing influential cases
==========================================================================
- Check if any cases have a Cook's distance of > 1
  - Then check if they have an undue effect on the model using the other statistics
  - SPSS can also give you standardised residuals (i.e. residuals transformed into *z*-values) above a certain cutoff (e.g. 3 standard deviations).
    - You can get these from `Statistics...` under `Casewise diagnostics` in the Linear Regression module
  - Outliers outside 3 standard deviations are potentially problematic
  
Testing the regression assumptions
===========================================================================
- Normality of the residuals:
  - Make a histogram of the standardised residuals (`Plot...` button in the `Linear Regression` module)
    - Does it look roughly normal?
    
![plot of chunk unnamed-chunk-19](Class4-figure/unnamed-chunk-19-1.png)

More assumption tests (3)
===========================================================================
- Heteroskedasticity
  - Make a plot of *z*-transformed predicted values against *z*-transformed residuals
      - In the `Plot...` window, choose ZPRED as the y-value and ZRESID as the x-value
      - Does it look like there is more variance for certain predicted values?
      
![plot of chunk unnamed-chunk-20](Class4-figure/unnamed-chunk-20-1.png)

Reporting the regression results
===================================================================

|                                   | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------------------------|--------:|----------:|-------:|------------------:|
|(Intercept)                        |  103.128|      2.073|  49.751|              0.000|
|CatWeight_centered                 |   17.082|      3.632|   4.704|              0.000|
|CatAge_centered                    |    0.441|      0.087|   5.069|              0.000|
|CatWeight_centered:CatAge_centered |    0.103|      0.131|   0.789|              0.437|

1. Make a table with the model coefficients (see above.)
2. Introductory paragraph: In order to test the hypothesis that cat weight and cat age can predict how much food a cat eats, we performed a multiple regression analysis  with food eaten (in g) as the dependent variable and cat weight and cat age (both mean-centered) as well aas their interactions as continuous independent variables. The model explained a very high amount of the variance in the dependent variable, with an adjusted $R^2$ of 0.555.


Reporting the regression results: Coefficients
===================================================================
Our results show that both cat weight (b = 17.082, SE = 3.632, t = 4.704, *p* < .01) and cat age (b = 0.441, SE = 0.087, t = 5.069, *p* < .01)) had a significant effect on the food eaten. On average, an increase in weight by one kg went along with an increase in food eaten of 17.082 g. Similarly, an increase in age by one month went along with an increase in food eaten of 0.441 g.

There was no significant interaction between cat weight and cat age (p > .05), suggesting that the effects of cat weight and cat age were additive. Assumption tests and visual inspection of residual plots showed that there was no evidence of violations of normality, independence, or homoscedasticity. [If you removed influential cases, say this here.]

Discrete variables
==================================================================
- Is it possible to perform a regression analysis with discrete (instead of continuous) variables?
  - **Yes!**
  - In fact, when you ask SPSS or R to perform an ANOVA, what it does behind the scenes is run a linear model and then do model comparisons using the F-Test
      - Minds blown (maybe)!
  - How can we put discrete (that is, non-numerical) variables into the regression model?
      - We make up numbers, of course.
      - This is called *dummy coding*.
      
Example
=================================================================

- Let's just stay with the cat data for a little bit longer
- Let's say our cats came from two breeds, shorthair and manx.
    - Does breed have an influence on food eaten?
    - The corresponding file is on myBU (`catfood_breed.sav`; first 6 rows of the table shown)
    

| CatWeight| CatAge|CatBreed  | FoodEaten|
|---------:|------:|:---------|---------:|
|     0.432|  -29.7|Shorthair |      81.8|
|     0.461|  -36.7|Shorthair |      82.9|
|    -0.667|    6.9|Shorthair |      81.7|
|     1.011|  -24.7|Shorthair |      87.5|
|    -0.467|  -33.8|Shorthair |      64.6|
|    -0.008|  -46.5|Shorthair |      56.6|

We could do a t-test
=================================================================

```

	Two Sample t-test

data:  FoodEaten by CatBreed
t = 6, df = 30, p-value = 0.000005
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 20.9 44.9
sample estimates:
     mean in group Manx mean in group Shorthair 
                  119.0                    86.1 
```

Or an ANOVA
==================================================================

```
            Df Sum Sq Mean Sq F value    Pr(>F)    
CatBreed     1   8124    8124    31.6 0.0000051 ***
Residuals   28   7204     257                      
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Or we could assign dummy values and do a regression
==================================================================
- Let's recode our variable and assign "0" to all Shorthairs and "1" to all Manxes
- We can do this in SPSS under `Data` --> `Recode into Different Variables...`
    - We recode our cat breed variable into a variable called `dummy`, containing 0s and 1s

## Dummy analysis

|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |     86.1|       4.14|   20.78|                  0|
|dummy       |     32.9|       5.86|    5.62|                  0|

Let's plot the situation
=================================================================
![plot of chunk unnamed-chunk-27](Class4-figure/unnamed-chunk-27-1.png)

Interpreting dummy variables
=================================================================
- Now, the intercept is the mean for group "shorthair" and the slope gives the difference between group "shorthair" and group "manx"
- Remember the regression equation: $y_i = \alpha + \beta_1 x_{i} + \epsilon_i$
- If $x_i$ is 0 (shorthair group), the predicted value y is the intercept ($\alpha$)
- If $x_i$ is 1 (manx group), the predicted value is the sum of the intercept ($\alpha$) and the slope ($\beta_1$). 

Different dummy values
================================================================
- Nobody forces us to set the values to 0 and 1
- We could use any values we want, e.g. 99 and 23419 (although have fun interpreting *that* equation)
- -1 and 1 might be reasonable. We use `Data` --> `Recode into Different Variables...` to make a new dummy variable containing -1s for Shorthair and 1s for Manxes.


Re-run the analysis
================================================================


|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |    102.5|       2.93|   35.01|                  0|
|dummy       |     16.5|       2.93|    5.62|                  0|

- Note that the numbers are different: now the intercept represents the grand (overall) mean.
- The slope tells you how far the means of shorthair and manx are from the grand mean.
     - The prediction for shorthair is $102.525 - 16.456 = 86.069$
     - The prediction for manx is $102.525 + 16.456 = 118.981$
    - The *t* and *p* values are exactly the same.

Analysis of Covariance (ANCOVA)
=================================================================
- Now we have all the elements in place to perform a simple ANCOVA
- The idea behind the ANCOVA is that sometimes our dependent variable in the ANOVA is influenced by non-discrete covariates
- For example, someone's IQ might influence their performance in a memory experiment
- By including the covariate in the model, we can explain more variance (and take it out of the error variance)

Analysis of Covariance (ANCOVA)
=================================================================
- Still with the cats! Sorry, I'm just too lazy to make up a new data set...
- Let's see if there is an effect of cat breed if we enter cat age and cat weight into the analysis as covariates (we don't care about their interaction, which we have shown to not be significant in the first place).

Use the Linear Regression module
================================================================

|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |  102.525|      1.932|   53.06|                  0|
|CatWeight   |   17.794|      3.537|    5.03|                  0|
|CatAge      |    0.477|      0.091|    5.24|                  0|
|dummy       |   13.560|      2.080|    6.52|                  0|

- We can reject the null hypothesis. Cat Breed (represented by our dummy variable) does indeed have a significant effect on food eaten.
- Note that, since we are coding Cat Breed as -1 and 1 , our intercept is still the grand mean of FoodEaten. Our dummy variable tells us the distance between the mean of the Shorthair group and the grand mean (on the left) and the distance between the Manx group and the grand mean (on the right)

Using the General Linear Model (Univariate) module
================================================================
- We can do an F-test by using the `Univariate` test from the `General Linear Model` module (in the `Analyze` menu)

```
Anova Table (Type III tests)

Response: FoodEaten
            Sum Sq Df F value     Pr(>F)    
(Intercept) 315343  1  2815.2    < 2e-16 ***
CatWeight     2835  1    25.3 0.00003097 ***
CatAge        3074  1    27.4 0.00001794 ***
dummy         4763  1    42.5 0.00000065 ***
Residuals     2912 26                       
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Assumption tests: Homogeneity of regression slopes
===============================================================
- This is an ANCOVA-specific assumption: is there an interaction between the covariate(s) and the discrete factor(s)?
- If there is, you can still use the linear model, but you can't call it an "ANCOVA" anymore
    - Also, the interpretation of the results will be much more complicated
- How to check this? Use `Transform` --> `Compute Variable...` to make a interaction terms for the dummy variable and the covariates, then fit a new model using the `Linear Regression` module and see if the interaction terms reach siugnificance.

Assumption tests: Homogeneity of regression slopes (2)
===============================================================

|                       | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:----------------------|--------:|----------:|-------:|------------------:|
|(Intercept)            |  103.314|      2.372|  43.558|              0.000|
|CatWeight              |   14.632|      4.967|   2.946|              0.007|
|CatAge                 |    0.457|      0.099|   4.620|              0.000|
|dummy                  |   14.176|      2.372|   5.977|              0.000|
|CatWeight:CatAge       |    0.128|      0.179|   0.715|              0.482|
|CatWeight:dummy        |   -1.156|      4.967|  -0.233|              0.818|
|CatAge:dummy           |   -0.048|      0.099|  -0.486|              0.632|
|CatWeight:CatAge:dummy |    0.159|      0.179|   0.892|              0.382|

- No evidence for any interaction. (Check multicollinearity, of course!)

Summary: Contrasts
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
  


The data
========================================================
- The data are in the file `dogs.sav` on myBU
- Let's calculate the means:

## Means table

|              | Mean number of objects known|
|:-------------|----------------------------:|
|Beagle        |                         10.4|
|Border Collie |                         61.8|
|Terrier       |                         13.9|

Comparing the means
========================================================
- We can always do pairwise *t*-tests. Those give us all the comparisons, but at the cost of making multiple comparisons.


```

	Pairwise comparisons using t tests with pooled SD 

data:  dogs$objects and dogs$breed 

              Beagle Border Collie
Border Collie <2e-16 -            
Terrier       0.1    <2e-16       

P value adjustment method: holm 
```

Adding contrasts
========================================================
- Let's make two dummy variables, called `x1` and `x2`:


|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|

- $x_1$ will be 1 for all "Border Collie" cases, and 0 otherwise
- $x_2$ will be 1 for all "Terrier" cases, and 0 otherwise
- This will make "Beagle" the baseline

How contrasts work
=========================================================
- Remember the linear regression equation:
- $y_{i} = \alpha + \beta_1 x_{1} + \beta_2 x_{2} + \epsilon_i$
- i.e. the predicted value for $y_i$ is $\hat{y_i} = \alpha + \beta_1 x_{1} + \beta_2 x_{2}$
- Now let's substitute in the values from the table if breed is "Beagle":

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|

- $\hat{y_{i}} = \alpha + \beta_1 \times 0 + \beta_2 \times 0 = \alpha$
- The predicted value for the Beagle group is $\alpha$, the intercept
- That means that in this analysis, the intercept will reflect the mean for the Beagle group (10)

How contrasts work (2)
=========================================================
- The predicted value for $y_i$ is still $\hat{y_i} = \alpha + \beta_1 x_{1} + \beta_2 x_{2}$
- Now let's substitute in the values from the table if breed is "Border Collie":


|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|

- $\hat{y_{i}} = \alpha + \beta_1 \times 1 + \beta_2 \times 0 = \alpha + \beta_1$
- The predicted value for the Border Collie group is $\alpha + \beta_1$, i.e. the sum of the intercept and the first slope $\beta_1$
- That means that in this analysis, the slope $\beta_1$ will reflect the difference between the mean for the Border Collie group and the mean for the Beagle group ($60 - 10 = 50$)

How contrasts work (2)
=========================================================
- The predicted value for $y_i$ is still $\hat{y_i} = \alpha + \beta_1 x_{1} + \beta_2 x_{2}$
- Now let's substitute in the values from the table if breed is "Terrier":

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  0|  0|
|Border Collie |  1|  0|
|Terrier       |  0|  1|

- $\hat{y_{i}} = \alpha + \beta_1 \times 0 + \beta_2 \times 1 = \alpha + \beta_2$
- The predicted value for the Border Collie group is $\alpha + \beta_2$, i.e. the sum of the intercept and the second slope $\beta_2$
- That means that in this analysis, the slope $\beta_1$ will reflect the difference between the mean for the Terrier group and the mean for the Beagle group ($15 - 10 = 5$)

Let's run the regression analysis
==========================================================

|                   | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:------------------|--------:|----------:|-------:|------------------:|
|(Intercept)        |    10.40|       1.65|    6.31|              0.000|
|breedBorder Collie |    51.40|       2.33|   22.05|              0.000|
|breedTerrier       |     3.53|       2.33|    1.52|              0.137|

- Looks just about right (remember, the means differ from the true population means because this is a -- simulated -- sample and contains random error)

We can also do a standard ANOVA
==========================================================

|          | Df| Sum Sq| Mean Sq| F value| Pr(>F)|
|:---------|--:|------:|-------:|-------:|------:|
|breed     |  2|  24728| 12364.2|     304|      0|
|Residuals | 42|   1711|    40.7|      NA|     NA|

- Note that the contrasts give us more information: they tell us which of the factor levels differ from the "Beagle" baseline
    - These are not multiple comparisons -- the ANOVA F-test simply compares a model without any of the contrasts (just the intercept) to a model with all the contrasts, while the *t*-tests compare the coefficient for each contrast to 0.
        - The classic ANOVA is simply a regression with (implicit) standard contrasts.
     - As a consequence, we get the contrasts "for free", but we can only have as many contrasts as the factor has degrees of freedom (i.e. $k-1$, where $k$ is the number of factor levels)

Interpreting the hypothesis tests
========================================================
- Note that we are testing the $H_0$ that $\alpha$, $\beta_1$, $\beta_2$ are 0.
- In this examples, we call the observed coefficients $b_1$ `breedBorder Collie` and $b_2$ `breedTerrier`.
- Remember what we said about the coefficients?
- $\alpha$ (the intercept) reflects the mean for the Beagle group
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

Using contrasts in SPSS
==========================================================
- To be honest, SPSS is terrible with contrasts -- it's really inconsistent
- You can specify your own contrasts using the Univariate ANOVA module, but you can't do that for the General Linear Model module
    - Instead, you have to pick a number of standard contrasts
- In theory, you could define your own contrasts, but it's a bit tricky

Standard contrasts
========================================================
- Simple
    - Compares each level to the reference level, the intercept is the grand mean
- Deviation
    - Compares each level to the overall mean of the dependent variable (the reference level is not compared)
- Helmert
    - Compares each level to the mean of the subsequent ones
- Difference (reverse Helmert)
    - Compares each level to the mean of the previous ones
- Repeated (successive differences)
    - Compares each level to the subsequent level 

Applying deviation contrasts
==========================================================

|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |     28.7|      0.951|    30.2|                  0|
|breed1      |    -18.3|      1.346|   -13.6|                  0|
|breed2      |     33.1|      1.346|    24.6|                  0|

Interpreting sum/deviation contrasts
===========================================================
- The intercept $\alpha$ is the grand mean of all the observations ($28.33$)
- $\beta_1$ is the difference between the grand mean and the mean of Beagle ($10 - 28.33 = -18.33$)
- $\beta_2$ is the difference between the grand mean and the mean of Border Collie ($60 - 28.33 = 31.67$)
- Terrier is never explicitly compared to the grand mean.
- In general: each level (except for the last level) is compared to the grand mean.

Applying difference (reverse Helmert) contrasts
==========================================================

|            | Estimate| Std. Error| t value| Pr(>&#124;t&#124;)|
|:-----------|--------:|----------:|-------:|------------------:|
|(Intercept) |    28.71|      0.951|    30.2|                  0|
|breed1      |    25.70|      1.165|    22.1|                  0|
|breed2      |    -7.39|      0.673|   -11.0|                  0|

Interpreting (reverse) Helmert contrasts
========================================================
- The intercept $\alpha$ is the grand mean of all the observations ($28.33$)
- $beta_1$ is half of the difference between the mean of Beagle and the mean of Border Collie ($(60 - 10)/2 = 25$)
- $beta_2$ is half of the difference between the joint mean of Beagle and Border Collie and the mean of Terrier ($(15 - (60+10)/2)/2 = -10$)
- In general: each level is compared to the mean of the previous levels

Make your own contrasts?
==========================================================
- **DANGER**: If you apply your contrasts directly as dummy variables, you must use the **inverse** of your contrast matrix
- If your contrasts are not orthogonal, and you don't use the inverse of your matrix, you won't be comparing what you think you're comparing.
- If you don't know what this means, don't use your own contrasts until you do. 
- For more background information on regression and linear models, see John Fox's book below (Warning: it does involve matrix algebra). Check Chapter 6 for information about how the contrasts work and why you need to be careful.

>Fox, J. (2008). Applied regression analysis and generalized linear models. 2nd Edition. Sage Publications, Thousand Oaks, CA, USA.
or the newer version
>Fox, J. (2015). Applied regression analysis and generalized linear models. 3rd Edition. Sage Publications, Thousand Oaks, CA, USA.

