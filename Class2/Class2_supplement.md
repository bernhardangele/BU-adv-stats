Advanced Statistics
========================================================
author: Bernhard Angele 
date: Class 2 supplement, October 9, 2014

New stuff we did with R this week
========================================================
- Select a named entry of a list with `$`

```r
my_new_list <- list(animal = "cat", ears = "pointy", sound = "meow")
my_new_list$animal
```

```
[1] "cat"
```

```r
my_new_list$sound
```

```
[1] "meow"
```

More practical example
========================================================
- Some functions output a list (although that may be cleverly hidden by the `print` command)
- To find out the **structure** of an object, use `str(object_name)`:

```r
my_new_list <- list(animal = "cat", ears = "pointy", sound = "meow")
str(my_new_list)
```

```
List of 3
 $ animal: chr "cat"
 $ ears  : chr "pointy"
 $ sound : chr "meow"
```

Structure of the t.test() output
========================================================

```r
t_results <- t.test( rnorm(n = 10, mean = 3, sd = 1))
str(t_results)
```

```
List of 9
 $ statistic  : Named num 14.9
  ..- attr(*, "names")= chr "t"
 $ parameter  : Named num 9
  ..- attr(*, "names")= chr "df"
 $ p.value    : num 1.18e-07
 $ conf.int   : atomic [1:2] 2.49 3.38
  ..- attr(*, "conf.level")= num 0.95
 $ estimate   : Named num 2.94
  ..- attr(*, "names")= chr "mean of x"
 $ null.value : Named num 0
  ..- attr(*, "names")= chr "mean"
 $ alternative: chr "two.sided"
 $ method     : chr "One Sample t-test"
 $ data.name  : chr "rnorm(n = 10, mean = 3, sd = 1)"
 - attr(*, "class")= chr "htest"
```

Getting the CI from the t.test() output
========================================================

```r
t_results$conf.int
```

```
[1] 2.491 3.382
attr(,"conf.level")
[1] 0.95
```
You can also extract elements by number (slicing):

```r
t_results$conf.int[1]
```

```
[1] 2.491
```

```r
t_results$conf.int[2]
```

```
[1] 3.382
```

Logical tests
========================================================
- You can use `>`, `<`, `==`, `>=`, `<=` to perform a test. The result of a test is either `true` or `false`
Is 3 part of the CI?

```r
3 > t_results$conf.int[1] & 3 < t_results$conf.int[2]
```

```
[1] TRUE
```

Count table
========================================================
`table(variable)` will give you a table with the counts of each unique element in `variable`

```r
test_array <- c(1,1,1,1,1,2,3,3,3,3,3,3,4,4)
table(test_array)
```

```
test_array
1 2 3 4 
5 1 6 2 
```
