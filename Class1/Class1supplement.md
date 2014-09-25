Advanced Statistics
========================================================
author: Bernhard Angele
date: Class 1 (supplement), October 2, 2014


R commands and functions used so far
========================================================
- Distribution functions
  - Get an overview of all of them by typing `?Distributions` at the command prompt
  - The function names follow a common pattern, where `xxx` stands for the abbreviated name of the distribution
    - Probability density function (PDF): `dxxx`, e.g. `dnorm`
    - Cumulative probability function (CDF) = area under the curve: `pxxx`, e.g. `pnorm`
    - Quantile function (allows you to specify the area under the curve and gives you the corresponding x value) = area under the curve: `pxxx`, e.g. `rnorm`
    - Random generator (generates random samples from the distribution): `rxxx`, e.g. `rnorm`

Using distribution functions
========================================================
- Examples
  - Generate 4 numbers from a normal distribution with mean = 10 and sd  = 5
  
  ```r
  rnorm(n = 4, mean = 10, sd = 5)
  ```
  
  ```
  [1]  7.891  4.771 11.012 12.660
  ```
  - What's the probability of getting a value greater or equal to 22 from that distribution?
  
  ```r
  1 - pnorm(22, mean = 10, sd = 5)
  ```
  
  ```
  [1] 0.008198
  ```

Using distribution functions
========================================================
- More examples
  - What x value is greater or equal to 95% of the samples from that distribution (mean = 10, sd = 5)?
  
  ```r
  qnorm(.95, mean = 10, sd = 5)
  ```
  
  ```
  [1] 18.22
  ```
  - Draw the curve of that distribution:
  
  ```r
  curve(dnorm(x, mean = 10, sd = 5), from = 6, to = 14)
  ```
  
  ![plot of chunk unnamed-chunk-4](Class1supplement-figure/unnamed-chunk-4.png) 

More R techniques used so far
=======================================================
- Calling functions with arguments
  - Most functions will expect some kind of input
    - e.g. `mean` expects a vector of numbers
    
    ```r
    my_data <- c(23,6,78,4,3,2)
    mean(x = my_data)
    ```
    
    ```
    [1] 19.33
    ```
  - You do not have to call the arguments by name:
    
    ```r
    my_data <- c(23,6,78,4,3,2)
    mean(my_data)
    ```
    
    ```
    [1] 19.33
    ```
    
Function arguments
=======================================================    
- If you do not name the arguments of a function, they will be interpreted in the order that they are specified in the help file for the function (which you can get like this: `?rnorm`):
  - e.g. `rnorm` expects the arguments `n`, `mean`, and `sd`

```r
  rnorm(n = 5, mean = 10, sd = 2)
```

```
[1] 10.552 10.150 11.316  7.338  8.916
```

```r
  rnorm(5,10,2)
```

```
[1] 14.283  9.709 13.051  6.610  7.719
```
- Specifying non-existent arguments will give you an error:








```
Error in rnorm(cats = 3) : unused argument (cats = 3)
```
