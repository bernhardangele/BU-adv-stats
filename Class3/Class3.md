Advanced Statistics
========================================================
author: Bernhard Angele 
date: Class 3, October 16, 2014

Your last serving of R basics
========================================================
- Working with files
  - R can open all kinds of data files
  - You do have to tell it where to find them
- R's working directory
  - This is where R looks for files to open
  - You change it using `setwd("C:/My_example_R_directory")
  - No backslashes `\` allowed! Use forward slashes instead `/`
 
Setting your working directory
==========================================================
 - Don't know where your working directory should be?
  - Start by putting your script files in a location that is sensible (to you)
    - e.g. `C:\Some_Document_Folder\AdvStats\Class3\` or `/home/My_Name/Documents/MastersProject/Data`
    - That directory should also be your working directory for the current session
    - In RStudio, open your script file, then use the menu bar and go to Session --> Set Working Directory --> To Source File Location
      - RStudio will write a setwd command to the console.
      - Copy and paste this command to your script, and you're set. Every time you run the script, the working directory will be automatically set
- When you use R Markdown, Knitr sets your working directory to the location of the Rmd file automatically.
      
Opening files and importing data
========================================================
- If you have data in Excel:
  - Save them as comma-separated values (CSV)
  - If you are using Excel formulas and other bells and whistles, check that your data are exported correctly
  - Make sure the first row of every column contains its column name
  - Save this file in your working directory (remember where that was?)
  - Now you can import the file using `new_object_with_a_sensible_name <- read.csv(file = "my_filename.csv")`
  - If there is an error/warning message, check that there are no missing cells
    - Same number of data points in each row


Data Frames
========================================================
- A Data Frame is a combination of a list and a matrix
- It gets its row/column structure from the matrix
- But you can use columns of any data type (numeric, logical, factor (discrete), logical, character)
- Perfect for the kind of analyses we would like to do
- Very similar to SPSS data files
- Get a column by using `object_name$column_name`
- Get a column by slicing: `object_name[,1]`
- Get a row by slicing: `object_name[1,]`
- Get a cell by slicing: `object_name[1,1]`

Packages
========================================================
- Many authors have worked on extending R and teaching it new tricks
- Packages are collections of functions that help you perform a certain task
  - For example, the `ez` package has all kinds of useful functions for performing ANOVAs
- To install a package, type `install.packages("package_name")` at the Console.
  - e.g. `install.packages("ez")`
- You can ask R to install multiple packages at once:
  - Run this line in the console now: `install.packages(c("ez","reshape","ggplot2","lme4", "plyr"))

Loading packages
=========================================================
- Installed packages are not loaded automatically
- If you want to use a command from a package, you need to load it: `library(package_name)`
  - e.g. `library(ez)`
- Once it is loaded, the package and all of its commands are ready to go until you restart R.

Starting a script
==========================================================
Good practice when starting a script:

```r
# My_testscript.R
# Author: Bernhard Angele
# Description: Demonstrates how to start a script
###########################

rm(list = ls()) # clear the workspace to avoid problems caused by old objects
library(ez) # load (only) those libraries that you need
library(reshape)
library(ggplot2)
# Set your working directory
setwd("C:/I_know_my_working_directory_and_this_is_it/")
# Now load your data, do your analyses and win fame and fortune!
```

Starting an Rmd file
========================================================
- Fill in the header:

```r
---
title: "My fantastic results section"
output: word_document
---
```
- Then do the same things as above in the first code chunk
  - Hint: you can tell R to hide this boring code by adding `hide = TRUE` to the header. It will still get evaluated

```r
Start your code chunk like this: ```{r, hide = TRUE}
```
    
Comparing multiple groups
========================================================
- t-tests are nice if you only have two groups that you want to compare.
- But maybe you have more groups
- Example:
> A researcher wants to find out if there is a systematic difference in intelligence between MSc students from different universities. She performs intelligence tests on 10 students each from BU, University of Southampton and Oxford University and records the results.

Making fake data for our example
========================================================
- Let's assume that the true state of affairs is that there is no difference in intelligence
- In that case, all intelligence scores would come from the same distribution: a normal distribution with mean = 100 and sd = 15
- Let's generate 3 data sets according to this criterion:

```r
bu <- rnorm(n = 10, mean = 100, sd = 15)
soton <- rnorm(n = 10, mean = 100, sd = 15)
oxford <- rnorm(n = 10, mean = 100, sd = 15)
```

What if we use t-tests?
========================================================
- We could simply perform t-tests on these data
- How many would we need?
  - 3: BU vs. Soton, BU vs. Oxford, Soton vs. Oxford

BU vs Soton
=========================================================

```r
t.test(bu, soton)
```

```

	Welch Two Sample t-test

data:  bu and soton
t = 0.238, df = 13.15, p-value = 0.8155
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -13.13  16.39
sample estimates:
mean of x mean of y 
    104.3     102.7 
```

BU vs Oxford
=========================================================

```r
t.test(bu, oxford)
```

```

	Welch Two Sample t-test

data:  bu and oxford
t = 1.204, df = 15.72, p-value = 0.2464
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -6.785 24.562
sample estimates:
mean of x mean of y 
   104.30     95.41 
```

Soton vs Oxford
=========================================================

```r
t.test(soton, oxford)
```

```

	Welch Two Sample t-test

data:  soton and oxford
t = 1.422, df = 16.56, p-value = 0.1737
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -3.536 18.056
sample estimates:
mean of x mean of y 
   102.67     95.41 
```

Anything wrong with that?
========================================================
- We are doing three independent t-tests
- Each t-test has a 5% chance of producing a spurious result ($\alpha$)
- What is the chance that we get at least one spuriously significant result?
  - It's 1 - the chance that we get no spurious results
  - $1 - .95*.95*.95 = .14$
  - We have a problem: our $\alpha$ is almost three times as high as it should be.
  - SPSS calls this LSD (least significant differences) - don't use it!
  
Solutions
=========================================================
- We can adjust the $\alpha$ level of each t-test:
  - If we divide the alpha level by the number of tests, we get $.05/3 = .0167$
  - Our total $\alpha$ is then: $1-(1-.05/3)^3 = .049$
  - This is called a **Bonferroni correction**
  - Problem solved?
  - Yes, but the lower the $\alpha$ level, the lower the power.
- Better ways (but still lowering power):
  - Tukey's HSD (honestly significant differences)
  - Scheffe's test
- Maybe we just want to know if there is a difference at all between these three means
  - One-way ANOVA


Putting our fake data in a different format
========================================================
- Usually, we aren't getting our data neatly in different objects
- Instead, we'll have a big table with our data
- If we are going to put our data in this format, we need a variable (or column) identifying the group
- Let's add that to each of our data sets

```r
bu <- data.frame(iq = bu, group = "BU")
soton <- data.frame(iq = soton, group = "Soton")
oxford <- data.frame(iq = oxford, group = "Oxford")
```

Looking at these data now
=========================================================

```r
bu
```

```
       iq group
1  104.32    BU
2  113.80    BU
3   70.85    BU
4  101.82    BU
5  130.75    BU
6  106.50    BU
7  129.40    BU
8  111.70    BU
9   96.31    BU
10  77.51    BU
```

Putting it all together
=========================================================

```r
iqdata <- rbind(bu, soton, oxford)
str(iqdata)
```

```
'data.frame':	30 obs. of  2 variables:
 $ iq   : num  104.3 113.8 70.9 101.8 130.7 ...
 $ group: Factor w/ 3 levels "BU","Soton","Oxford": 1 1 1 1 1 1 1 1 1 1 ...
```
- Data frames are smart: 
  - R has automatically converted `group` into a factor
    - A factor is a discrete variable (nominal scale)
  - R left `iq` as a numeric variable
    - Numeric variables are continuous (interval or ratio scale)

Running an ANOVA -- by hand!
========================================================
- One-way ANOVAs are so simple, all you need is a calculator (or R, even better)
- First, we need an estimate of the total variance in the data: calculate the total sum of squared deviations from the mean (or short, sum of squares, SS)
- $SS_{total} = \sum{(x_i - \bar{x})^2}$, where $x_i$ is each individual value and $\bar{x}$ is the grand mean of the data.

```r
(SS_tot <- sum((iqdata$iq - mean(iqdata$iq))^2))
```

```
[1] 6181
```

Running an ANOVA -- by hand! (2)
========================================================
- Now we need an estimate of the variance explained by `group`
- $SS_{model} = n_k(\bar{x}_k - \bar{x})^2$, where $\bar{x}_k$ denotes the mean for each group, $n_k$ is the number of subjects in each group, and $\bar{x}$ is the grand mean of the data.

```r
bu_mean <- mean(subset(iqdata, group == "BU")$iq)
soton_mean <- mean(subset(iqdata, group == "Soton")$iq)
oxford_mean <- mean(subset(iqdata, group == "Oxford")$iq)
n <- 10

(SS_model <- sum(n*(bu_mean - mean(iqdata$iq))^2, n*(soton_mean - mean(iqdata$iq))^2, n*(oxford_mean - mean(iqdata$iq))^2))
```

```
[1] 447.9
```

Running an ANOVA -- by hand! (3)
========================================================
- Now get an estimate of the variance that is *not* explained by `group`, i.e. the error.
- Easy: Just subtract $SS_{model}$ from $SS_{total}$.
- $SS_{error} = SS_{total} - SS_{model}$

```r
(SS_error <- SS_tot - SS_model)
```

```
[1] 5733
```

Running an ANOVA -- by hand! (4)
========================================================
- With $SS_{model}$ and $SS_Error$, we can compute the ratio of explained variance to error (or unexplained) variance.
- First, we need to take into account the number of measurements which went into each SS
- These are called the degrees of freedom
- This is equivalent to calculating the variance as a descriptive statistic ($SS/df$)
- $df_{total} = n*k-1$, where $n$ is the number of observations per group (10) and $k$ is the number of groups
  - Why -1? Very good question. Short answer: Whenever we want to make conclusions about the population, we use n-1 instead of n.
  - Long answer (if you are REALLY interested and won't shut up about it): [Here](http://nebula.deanza.edu/~bloom/Math10/M10DivideBy_nminus1.pdf)
  
Running an ANOVA -- by hand! (5)
========================================================
- $df_{total} = n*k-1$
- $df_{model} = k-1$, where $k$ is the number of groups.
- $df_{error} = df_{total} - df_{error} = n*k - k$


```
Error in parse(text = x, srcfile = src) : <text>:6:9: unexpected symbol
5: 
6: Running an
           ^
```