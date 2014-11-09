# Homework 4 template
# Advanced Statistics Class 4, Oct 23 2014
# Bernhard Angele
# Description: Demonstrates how to do a mixed ANOVA analysis without using Knitr to automatically generate a report.
# Instead, you have to copy and paste the correct numbers into your report document.
# Much easier, but also more error-prone. 

#1. Preparations
#####################################################

rm(list = ls())

# the following path will NOT work on your computer. Change it to the actual source file location
# You can get this from RStudio by selecting Session --> Set Working Directory --> To Source File Location
# copy and paste the resulting setwd command over the command below.
setwd("~/Documents/Teaching/Winter 2014/Advanced Statistics/BU-adv-stats/Homework 4")

# loading necessary libraries
library(ez)

# round all numbers to the 2nd digit
options(digits = 2)

#loading food data
food <- read.csv("Homework4_data.csv")

# "subject" is a discrete variable, so I'm making it a factor()
food$subject <- factor(food$subject)

# 2. Calculate descriptice statistics
#########################################################

# note here that fish and beef are specified as within-subjects factors
# use .(factor1, factor2, factor3, ...) to specify multiple factors
(food_stats <- ezStats(data = food, 
                       dv = eaten, 
                       wid = subject, 
                       between =  breed,
                       within = .(fish, beef)))


# if you use ezStats (and any function from ez) to collapse over a predictor, add its name to between_full or within_full. 
# This will ensure that means are computed correctly, even for unbalanced designs.
# First: collapse over breed to get a table of fish/beef means
food_stats_collapsed <- ezStats(data = food, 
                       dv = eaten, 
                       wid = subject, 
                       between_full =  breed,
                       within = .(fish, beef))

# Second: collapse over fish and beef to get a table of breed means
food_stats_by_breed <- ezStats(data = food, 
                       dv = eaten, 
                       wid = subject, 
                       between =  breed,
                       within_full = .(fish, beef))

# add a column for standard error
food_stats$SE <- food_stats$SD/sqrt(food_stats$N)

# now you can copy these data into your table. Don't forget to give your table a number and a caption.

# 3. Making a plot
###############################################################

# I know I told you to use barplots and that CIs based on Fisher's LSD aren't ideal, but for this homework and for Assignment 1, it's fine to use them -- everything is just so much easier with ezPlot. If you want to know the details of how to make a plot without ezPlot, please ask me.

food_plot <- (ezPlot(data = food, 
  dv = eaten, 
  wid = subject, 
  between =  breed,
  within = .(fish, beef),
  x = fish,
  split = beef,
  row = breed,
  x_lab = "Fish",
  y_lab = "Mean cat food eaten (in g)",
  split_lab = "Beef"))

food_plot <- (ezPlot(data = food, 
                     dv = eaten, 
                     wid = subject, 
                     between =  breed,
                     within = .(fish, beef),
                     x = breed,
                     split = fish,
                     row = beef,
                     x_lab = "Breed",
                     y_lab = "Mean cat food eaten (in g)",
                     split_lab = "Fish"))

library(ggplot2)
# saving the plot as food_plot.png in your working directory
ggsave(filename = "food_plot.png", plot = food_plot)
# now you can import it in Word -- don't forget the caption!

# perform the actual ANOVA so we can use the results when writing our report
(food_anova <- ezANOVA(data = food, 
                      dv = eaten,
                      wid = subject, 
                      between = breed,
                      within = .(fish, beef)
                      ))

# also perform an ANOVA with just breed
# note the use of within_full
food_anova_just_breed <- ezANOVA(data = food, 
                      dv = eaten,
                      wid = subject, 
                      between = breed,
                      within_full = .(fish, beef))
# this last ANOVA gives us Levene's test for the betwen-subjects predictor breed

# We can't perform the Shapiro-Wilk test on residuals, since it's a repeated measures analysis
# This is not ideal, but can't be helped (see Class 4 presentation)
# We do the test on the raw data instead:
food_anova_shapiro <- shapiro.test(food$eaten)

# in order to do the pairwise t-test properly, we need to collapse over the within subject variables
# This can be done most easily with "melt" and "cast" from the "reshape" package
# I'm just doing this here for the sake of completeness.
# You won't have to do it in the assignment.

library(reshape)
food.m <- melt(food, measure = "eaten")
food.c <- cast(food.m, subject + breed ~ variable, mean)

(food_anova_pairwise <- pairwise.t.test(x = food.c$eaten, g = food.c$breed))
