Assumptions and dealing with assumption violations
========================================================
author: Bernhard Angele
date: Advanced Statistics
autosize: true


Repeated measures
=============================================================
- Remember the paired *t*-tests? We can have the same situation (more than one data point from one participant) in a more complex design.
- This is bad, because we violate the independence assumption in the standard ANOVA.
- This is good, because we can use a repeated-measures ANOVA to remove all between-participant variance
- ${SS}_{total} = {SS}_{betweenParticipants} + {SS}_{withinParticipants}$
- ${SS}_{withinParticipants} = {SS}_{model} + {SS}_{residual}$ (we call this the residual sum of squares rather than the error sum of squares, since technically the variance between participants is also error variance)
- Result: Less unexplained variance and higher power.
- In the between-subjects ANOVA the variance between participants is completely confounded with the error variance within participants.
- In the repeated measures ANOVA, we can separate them!

Repeated measures data matrix
=============================================================
- Almost the same as for the standard one-way ANOVA
  - Columns are factor levels, rows are **participants**
- $i$ = factor level, $p$ = number of factor levels
- $m$ = **participant**, $n$ = number of **participants**

$$
\begin{matrix}
x_{11} &  x_{12}  & \ldots & x_{1i} & \ldots & x_{1p}\\
x_{21} &  x_{22}  & \ldots & x_{2i} & \ldots & x_{2p}\\
\vdots & \vdots   &       & \vdots  &        &\vdots \\
x_{m1} &  x_{m2}  & \ldots & x_{mi} & \ldots & x_{mp}\\
\vdots & \vdots   &       & \vdots  &        &\vdots \\
x_{n1} &  x_{n2}  & \ldots & x_{ni} & \ldots & x_{np}\\
\end{matrix}
$$

Calculating the sums of squares
=============================================================
- The total sum of squares is still ${SS}_{total} = \sum\limits_{m=1}^{n}\sum\limits_{i = 1}^{p}(x_{mi} - \bar{x})^2$
- ${df}_{total} = n\cdot p-1$
- The between participants sum of squares is new. It is $${SS}_{betweenParticipants} = p \cdot \sum\limits_{m=1}^{n}(\bar{P}_{m} - \bar{x})^2,$$
where $\bar{P}_m$ is the mean for Participant $m$ and $p$ is the number of factor levels
- Same for the within participans sum of squares: $${SS}_{withinParticipants} = \sum\limits_{i=1}^{p}\sum\limits_{m=1}^{n}(x_{mi} - \bar{P}_{m})^2,$$
where $\bar{P}_m$ is the mean for Participant $m$ and $i$ is the factor level

Calculating the sums of squares (2)
=============================================================
- Finally, the model SS is just as before: $${SS}_{model} = n \cdot \sum\limits_{i=1}^{p}(\bar{A}_{i} - \bar{x})^2,$$ where $n$ is the number of participants, $\bar{A}_{i}$ is the mean of level $i$ of the group factor, and $p$ is the number of factor levels.
- The residual SS is a little bit more complicated (this is already a simplified version): $${SS}_{residual} = \sum\limits_{i=1}^{p}\sum\limits_{m=1}^{n}(x_{mi} - \bar{A}_i-\bar{P}_{m}+\bar{x})^2$$
  - Of course, you can just get it by subtracting the model SS from the within participant SS: $${SS}_{residual} = {SS}_{withinParticipants} - {SS}_{model}$$
  
Degrees of freedom
============================================================
- ${df}_{total} = p\cdot n - 1$
- ${df}_{betweenParticipants} = n - 1$
- ${df}_{withinParticipants} = n \cdot (p - 1)$
- ${df}_{model} = p - 1$
- ${df}_{residual} = (n-1) \cdot (p - 1)$
  - Where $p$ is the number of factor levels and $n$ is the number of participants

Test statistic
==============================================================
- Important: You get the *F*-value by dividing the model mean squares by the **residual** mean squares: $F_{A} = \frac{{MS}_{model}}{{MS}_{residual}}$
- The degrees of freedom of this *F*-value are ${df}_{numerator} = {df}_{model}$ and ${df}_{denominator} = {df}_{residual}$

Quick example by hand
=============================================================
- 10 cats were asked to try 3 different brands of cat food: Whiskers, Paws, and Industrial Waste. They received the same amount of each food after not having eaten for 8 hours. The dependent variable amount of food (in grammes) that they ate of each brand. Do cats prefer one or more brands over others or do they eat the same amount of each?

Copy this table into Excel (or SPSS)
==============================================================

|Subject | Whiskers| Paws| Industrial Waste|
|:-------|--------:|----:|----------------:|
|Cali    |      105|  105|               28|
|Callie  |      124|  113|               48|
|Casper  |      146|  133|               48|
|Charlie |       98|   98|               12|
|Chester |      148|  123|               59|
|Chloe   |      103|  124|               62|
|Cleo    |      123|  119|               60|
|Coco    |      150|  161|               66|
|Cookie  |       74|   84|                3|
|Cuddles |      177|  172|               80|

Doing the ANOVA in Excel
==============================================================
- Start by calculating subject and condition means using `=AVERAGE`. You should have one mean for each of the $n = 10$ cats (we'll assume that those are in `E2:E11`) and one mean for each of the $p = 3$ conditions (We'll assume that these are in `B12:D12`)
- Calculate your Sums of Squares
  - ${SS}_{model} = n \cdot \sum\limits_{i=1}^{p}(\bar{A}_{i} - \bar{x})^2$; in Excel: `=10*DEVSQ(B12:D12)`
    - Remember, `DEVSQ` is the squared deviation of the input values from their mean. Since we have a balanced design (all sample sizes are equal), the mean of the group means (and the mean of the subject means) is the overall mean.
  - ${SS}_{betweenParticipants} = p \cdot \sum\limits_{m=1}^{n}(\bar{P}_{m} - \bar{x})^2$; in Excel: `=3*DEVSQ(E2:E11)` (same principle as above)
  
Sums of squares (continued)
===============================================================
- ${SS}_{total} = \sum\limits_{m=1}^{n}\sum\limits_{i = 1}^{p}(x_{mi} - \bar{x})^2$; in Excel: `=DEVSQ(B2:D11)`, assuming that your data are in `B2:D11`
- ${SS}_{withinParticipants}$ requires a bit of extra work to calculate in Excel. The easiest way is to just subtract ${SS}_{betweenParticipants}$ from ${SS}_{total}$: ${SS}_{withinParticipants} = {SS}_{total} - {SS}_{betweenParticipants}$
- ${SS}_{residual}$ is also tricky. The easiest way is again to subtract: ${SS}_{residual} = {SS}_{withinParticipants} - {SS}_{model}$
- Then calculate the degrees of freedom and the MS as shown earlier
- Important: remember that the *F* value is calculated as $F_{A} = \frac{{MS}_{model}}{{MS}_{residual}}$

Final step
==============================================================
- Look up the *p*-value: `=F.DIST.RT(E15,2,18)`, where `E15` contains the *F*-value
- For comparison: ANOVA output form R



```
Error in summary(ezANOVA(data = df, wid = Subject, within = Brand, dv = eaten,  : 
  could not find function "ezANOVA"
```
