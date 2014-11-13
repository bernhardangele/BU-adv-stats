library(knitr)
library(ggplot2)
library(ez)
library(lme4)
library(car)

# As always, replace this with your own working directory!
setwd("~/Documents/Teaching/Winter 2014/Advanced Statistics/BU-adv-stats/Class6")

options(digits = 2, scipen = 4) # only print 2 digits from here on out

scene_liking <- read.csv("Class 6 exercise data.csv")

# make subject and item into factors
scene_liking$subject <- factor(scene_liking$subject)
scene_liking$item <- factor(scene_liking$item)

# use nicer condition names for scene
levels(scene_liking$scene) <- c("No people present", "People present")

# Plotting a continuous effect is a little trickier than plotting a factorial design
# We will use the "smooth" geom from ggplot2 to plot smoothed conditional means for each value of mood and for each scene type.
# In ggplot2, a "geom" is a particular type of data visualisation. For example, there are geoms for scatterplots ("point"), line graphs ("line"), barplots ("bar"), and many more.
# The "smooth" geom is particularly attractive for plotting continuous factors since it includes a smoothed estimate of the standard error
# The easiest way to get started with ggplot2 is to use qplot ("quick plot")
library(ggplot2)
scene_liking_plot <- qplot(data = scene_liking, # the data frame that you want to use
                           y = rating,          # the variable that goes on the y axis
                           x = mood,            # the variable that goes on the x axis
                           colour = scene,      # draw different colour lines for the levels of this factor
                           geom = "smooth"      # use the "smooth" geom to draw this plot
                           )

# now add axis and legend labels
scene_liking_plot <- scene_liking_plot + xlab("Mood rating") + ylab("Scene Rating") + labs(colour = "Scene type")

ggsave(scene_liking_plot, filename = "Scene liking by mood and scene type.png")
# make sure to center the mood predictor -- remember the multicollinearity issues we ran into!:

scene_liking$mood_raw <- scene_liking$mood

scene_liking$mood <- scale(scene_liking$mood, scale = FALSE)

scene_liking_lm <- lm(data = scene_liking, rating ~ scene * mood) 

scene_liking_lm_coef <- coef(summary(scene_liking_lm))

scene_liking_lm_predict <- predict(scene_liking_lm)
scene_liking_lm_resid <- resid(scene_liking_lm)
scene_liking_lm_shapiro <- shapiro.test(scene_liking_lm_resid)

scene_liking_lm_vif <- vif(scene_liking_lm)
scene_liking_lm_influence <- influence.measures(scene_liking_lm)
#colnames(data) <- c("subject ID", "item ID", "Confederate scene in room", "mood", "rating probability rating")
#kable(data)
scene_liking_lmm_random_intercepts_only <- lmer(data = scene_liking, rating ~ scene * mood + (1|subject) + (1|item)) 

scene_liking_lmm <- lmer(data = scene_liking, rating ~ scene * mood + (1|subject) + (mood|item)) 

scene_liking_mood_slope_test <- anova(scene_liking_lmm, scene_liking_lmm_random_intercepts_only)

scene_liking_lmm_coef <- coef(summary(scene_liking_lmm))

scene_liking_lmm_predict <- predict(scene_liking_lmm)
scene_liking_lmm_resid <- resid(scene_liking_lmm)
scene_liking_lmm_shapiro <- shapiro.test(scene_liking_lmm_resid)
