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
- Contrasts can be, but don't have to be **orthogonal**
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
- Note that we are testing the $H_0$ that $beta_0$, $beta_1$, $beta_2$ are 0.
- R helpfully calls the observed coefficients $b_1$ `breedBorder Collie` and $b_2$ `breedTerrier`.
- Remember what we said about the coefficients?
- $beta_0$ (the intercept) reflects the mean for the Beagle group
- If the intercept is significantly different from 0, that's not that interesting (but at least it is evidence that the beagles can learn more than 0 object names)
- The first slope $beta_1$ reflects the difference between the Border Collie group and the Beagle group
- If this difference is significant, it means that there is evidence that Border Collies know more object names than Beagles

Interpreting the hypothesis tests (2)
========================================================
- The second slope $beta_2$ reflects the difference between the Terrier group and the Beagle group
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
- Sum (or deviation) contrasts

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        |  1|  0|
|Border Collie |  0|  1|
|Terrier       | -1| -1|
- The prediction for Beagle is $\hat{y_{i}} = \beta_0 + \beta_1 \cdot 1 + \beta_2 \cdot 0 = \beta_0 + \beta_1$
- The prediction for Border Collie is $\hat{y_{i}} = \beta_0 + \beta_1 \cdot 0 + \beta_2 \cdot 1 = \beta_0 + \beta_2$
- The prediction for Terrier is $\hat{y_{i}} = \beta_0 + \beta_1 \cdot -1 + \beta_2 \cdot -1 = \beta_0 - \beta_1 - \beta_2$
- The intercept $beta_0$ is the grand mean of all the observations ($28.33$)
- $beta_1$ is the difference between the grand mean and the mean of Beagle ($10 - 28.33 = -18.33$)
- $beta_2$ is the difference between the grand mean and the mean of Border Collie ($60 - 28.33 = 31.67$)
- Terrier is never explicitly compared to the grand mean.

Using the sum/deviance contrasts
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

What other contrasts does R have?
========================================================
- Helmert (or reverse Helmert) contrasts

|              | x1| x2|
|:-------------|--:|--:|
|Beagle        | -1| -1|
|Border Collie |  1| -1|
|Terrier       |  0|  2|
- The prediction for Beagle is $\hat{y_{i}} = \beta_0 + \beta_1 \cdot -1 + \beta_2 \cdot -1 = \beta_0 - \beta_1 - \beta_2$
- The prediction for Border Collie is $\hat{y_{i}} = \beta_0 + \beta_1 \cdot 1 + \beta_2 \cdot -1 = \beta_0 - \beta_1 + \beta_2$
- The prediction for Terrier is $\hat{y_{i}} = \beta_0 + \beta_1 \cdot 0 + \beta_2 \cdot 2 = \beta_0 + 2\beta_2$
- The intercept $beta_0$ is the grand mean of all the observations ($28.33$)
- $beta_1$ is the difference between the mean of Beagle and the mean of Border Collie ($60 - 10 = 50$)
- $beta_2$ is the difference between the joint mean of Beagle and Border Collie and the mean of Terrier ($15 - (60+10)/2 = -20$)

Using the helmert contrasts
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

