# Homework 5: Getting you started
# Bernhard Angele
# 30/10/2014
#########################################

# For this homwework, we'll need the following packages: ez, knitr, car, and heplots
# if you are still missing one or more of them, run the following line (without the #):
# install.packages(c("ez", "knitr", "car", "heplots", "ggplot2"))
library(ez)
library(knitr)
library(car)
library(heplots)
library(ggplot2)

# round all numbers to the 2nd digit; prefer normal notation unless it is more than 4 digits longer than the scientific (e.g. 2.4e-02) notation
options(digits = 2, scipen = 4)

# IMPORTANT: if you get a "cannot change working directory" error, this line is to blame
# You MUST set it to the correct working directory (i.e. a directory that contains the file "alcohol_Baseline.Alertness.csv")
# The directory that is currently in the command below is DEFINITELY not the correct directory, 
# unless your name is Bernhard and you teach Advanced Statistics.
setwd("~/Documents/Teaching/Winter 2014/Advanced Statistics/BU-adv-stats/Homework5")


alcohol <- read.csv("alcohol_alertness.csv")

# These are the same alcohol and driving performance data from Homework 3. 
# As before, our researchers are trying to test how having drunk alcohol, 
# being under the impression of having drunk alcohol (but actually being sober), 
# and not having drunk any alcohol (and not being under the impression of having drunk any) 
# affect driving score (measured on a scale from 80 = perfect to 0 = catastrophic). 
# Now our researchers also have measured baseline alertness for each participant 
# (i.e. how alert the person was while sober, measured on a scale from 100 = perfectly alert 
# to 0 = essentially unconscious). 
# Does including alertness in the analysis change our findings about the alcohol effect?

# Important hint: you have a factor with three levels, so you need to use a contrast that makes sense. 
# I suggest using the following command to set *Helmert* contrasts. 

contrasts(alcohol$Alcohol.Condition) <- contr.helmert(3)

# The command above produces two contrasts. The first contrast compares the alcohol to the alcohol placebo condition. 
# The second contrast compares the mean of the alcohol and the alcohol placebo conditions to the no drink control condition. 
# Make sure to interpret those contrasts accordingly!


# We can still use ez for some shortcuts, such as computing means and plotting them
# In order to do that, we once again add a subject column to the data
# It's very simple: each observation is a different person, so put a different number in each row.
# nrow(alcohol) gives you the number of rows in the data frame "alcohol"
# 1:nrow(alcohol) gives you a vector counting up from 1 to the number of rows in the data frame "alcohol"
# Also, "subject" is a discrete variable, so make the new column a factor()

alcohol$subject <- factor(1:nrow(alcohol))
