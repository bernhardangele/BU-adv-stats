---
output:
  html_document: default
  pdf_document: default
---
3 Multiple comparisons, power, and limitations of NHST
========================================================
author: Bernhard Angele
date: 28/02/2018
autosize: true

Type I and Type II error
========================================================
- We already mentioned this in the previous lecture

|                  | H0 is true            | H1 is true            |
|------------------|-----------------------|-----------------------|
|H0 not rejected   | correct               | $\beta$, Type II error|
|H0 rejected       | $\alpha$, Type I error| Power                 |


Controlling the Type I error rate
=======================================================
- Seems trivial: just set $\alpha$ to an appropriate level (0.05)
- However, there are many factors that can increase the Type I error rate:
  - Multiple comparisons
      - See Week 3 In-Class activity Question 1
      - Each test has an individual $\alpha$ of .05.
          - But if you do a lot of tests, these individual alphas add up
          
Type I error rate for multiple comparisons
=======================================================
This is not particularly complicated, it's just the function $$y = .95^x$$
![plot of chunk plot_typeI](3 Limitations of NHST-figure/plot_typeI-1.png)


The family-wise Type I error rate
========================================================
- A family of hypothesis tests is a number of tests that would each, on their own, lead you to reject the null hypothesis if they came out significant
- Example: You are testing an intervention on depression. You want to see if the treatment group differs from the control group in terms of mood, activity, and sleep quality and conduct one t-test for each of these measures
    - You will reject the null hypothesis that the intervention has no effect if any one of the t-tests shows a significant effect.
    - What is the family-wise Type I error rate for the three tests (assuming they are two-tailed with a 5% $\alpha$?
        - It's $1-.95^3 = 0.142625$  
        
        

Controlling the family-wise Type I error rate
========================================================
- The simplest approach is applying a Bonferroni correction
- Simply divide the $\alpha$ by the number of tests: $\alpha_{corr}=\frac{\alpha}{n_{Tests}}$
- In our example, that would mean using an $\alpha$ of $\frac{.05}{3}=0.0166667$
- Let's see what this does to our Type I error rate: $1-0.9833333^3 = 0.0491713$
- The correction is effective! Now our Type I error rate is below .05, just like we wanted.



```
Error in eval(expr, envir, enclos) : object 'p' not found
```
