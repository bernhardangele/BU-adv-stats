# Homework 5 example: R Script version
# Bernhard Angele
# 30/10/2014
#########################################

# For this example, we'll need the following packages: ez, knitr, car, and heplots
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
# You MUST set it to the correct working directory (i.e. a directory that contains the file "pain_aggression.csv")
# The directory that is currently in the command below is DEFINITELY not the correct directory, 
# unless your name is Bernhard and you teach Advanced Statistics.
setwd("C:/Bernhard/Documents/Teaching/Winter 2014/Advanced Statistics/BU-adv-stats/Homework5")


pain <- read.csv("pain_aggression.csv")

# This is the same data we had for Homework 3, just with an added covariate, state aggression.

# We can still use ez for some shortcuts, such as computing means and plotting them
# In order to do that, we once again add a subject column to the data
# It's very simple: each observation is a different person, so put a different number in each row.
# nrow(pain) gives you the number of rows in the data frame "pain"
# 1:nrow(pain) gives you a vector counting up from 1 to the number of rows in the data frame "pain"
# Also, "subject" is a discrete variable, so make the new column a factor()
pain$subject <- factor(1:nrow(pain))

# now we can use ezStats to get means
pain_stats <- ezStats(data = pain, 
                       dv = Time.In.Cold.Water, 
                       wid = subject, 
                       between =  Swear.Condition)

# if you add Aggression as a between-subjects covariate, ezStats will give you the 
# partial effects of the swear condition when controlling for Aggression
# In theory, we could do the ANCOVA like this, too, but it produces estimates that are slightly off
# (if you want to know why, ask me!)

# People's opinions vary as to whether you should report the raw means or the partial effect means. I would always report the raw means unless the partial means are radically different.
# In this case, they are quite similar, as you can see below (as always, type the name of the object in the Console to see its contents)

pain_stats_controlling_for_aggression <- ezStats(data = pain, 
                                         dv = Time.In.Cold.Water, 
                                         wid = subject, 
                                         between =  Swear.Condition,
                                         between_covariate = Aggression)

# get rid of the last column of pain_stats (you don't need Fisher's LSD in a results section)
pain_stats <- pain_stats[,1:4]
# Rename the first column to make the table look more professional
colnames(pain_stats)[1] <- "Condition"
# instead, add a standard error column
pain_stats$SE <- pain_stats$SD/sqrt(pain_stats$N)

# Again, it is mostly up to you whether you want to report the raw means or the partial effects in this plot.
# In this case, it doesn't matter much because they are nearly the same.

pain_plot <- ezPlot(data = pain, 
                dv = Time.In.Cold.Water, 
                wid = subject, 
                between =  Swear.Condition,
                x = Swear.Condition,
                x_lab = "Swear Condition",
                y_lab = "Time until hand retraction in s")


ggsave(pain_plot, file = "pain_plot.png")


# Now we perform the actual ANCOVA using lm

# Before you start, think about what you want the contrasts to be and which conditions you want to compare. Note that the number of comparisons you can make is limited (more about that in Class 6)

# Since we are mostly interested in whether swearing or saying neutral words is better than remaining quiet, we can use treatment (simple) contrasts here, comparing each factor level to our chosen baseline (i.e. the quiet condition)
# Treatment contrasts are the default, so we don't need to specify them, but we do need to make sure that "Quiet" is the baseline level for Swear.Condition

pain$Swear.Condition <- relevel(pain$Swear.Condition, ref = "Quiet")

# If we had more than one covariate and were interested in their interaction, we would need to center them here using scale(x, scale = FALSE)
# Since we only have one covariate, we are fine.

# this gives you the individual t-tests. Note that Swear.Condition is now split into two contrasts,
# one comparing the quiet and the neutral word conditions and one comparing the quiet and the swear word conditions

pain_lm <- lm(data = pain, formula = Time.In.Cold.Water ~ Swear.Condition + Aggression)

pain_lm_summary_coef <- coef(summary(pain_lm))

# use Anova for testing the overall effects of Swear.Condition and Aggression
# note that it doesn't matter if we use Type II or Type III sums of squares here, since we don't have an interaction
pain_ancova <- Anova(pain_lm)

# etasq from the heplots package will give you the same table, but with effect size estimates
pain_ancova_eta <- etasq(pain_lm, anova = TRUE)

# get the residuals for normality check
pain_lm_resid <- resid(pain_lm)

# Perform the Shapiro-Wilk test
pain_lm_shapiro <- shapiro.test(resid(pain_lm))

# Perform the Durbin-Watson test
# Warning: the Durbin-Watson test is only relevant if your data have a natural order 
# (i.e. if it matters that Subject 1 was measured before Subject 2 etc. 
# If the order doesn't matter, the test is MEANINGLESS and you can ignore these results. 
# I'm including the D-W test for completeness and so you can get the exact equivalent of the SPSS output.)
pain_lm_durbin <- durbinWatsonTest(pain_lm)

# Perform Levene's test
pain_lm_levene <- leveneTest(y = Time.In.Cold.Water ~ Swear.Condition, data = pain)

# Multicollinearity (note that we are getting generalised variance inflation factors instead of the usual ones here, but that's perfectly fine -- they are interpretable just like the ordinary ones)
pain_lm_vif <- vif(pain_lm)

# Look at influential cases
pain_lm_influence <- influence.measures(pain_lm)

# Test for the homogeneity of regression slopes
# We fit a model that includes the interaction:
pain_lm_interaction <- lm(data = pain, formula = Time.In.Cold.Water ~ Swear.Condition * Aggression)
# And then we compare it to the model without the interaction:
pain_lm_interaction_anova <- anova(pain_lm, pain_lm_interaction)

# We don't need to do pairwise t-tests now since we have our planned contrasts in the lm summary

# To avoid flooding you with output, this code doesn't actually print any of the results to the Console when you first run it
# Instead, you have to ask R to print each element by typing its name in the Console, e.g. pain_lm_summary_coef

# Look at all this output very carefully before you start writing it up, especially if you are using R Markdown!