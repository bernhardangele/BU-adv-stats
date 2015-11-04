rm(list = ls())

substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

if(!(substrRight(getwd(), 10) ==  "Homework 4"))
{
  project_dir <- getwd()
  
  setwd(paste0(project_dir, "/../Coursework/Assignment 1/Homework 4"))  
}

n_participants <- 24#15

set.seed("12355")

overall_intercept <- 50

subject <- rep(1:n_participants, each = 3)
pet <- rep(1:3, len = 3*n_participants)

subject_intercept <- rnorm(length(subject), mean = 0, sd = 3)

pet_mean <- c(-5, -5, 5)

random_error <- rnorm(length(subject), mean = 0, sd = 6)

df <- data.frame(subject, pet)

df$pet <- factor(df$pet, labels = c("Cat","Dog","No animal"))

df$stress <- round(with(df, overall_intercept + subject_intercept[subject] + pet_mean[pet] + random_error),0)

df$subject <- factor(df$subject)

library(ez)

ezStats(data = df, dv = stress, wid = subject, within = .(pet))

shapiro.test(df$stress)

ezPlot(data = df, dv = stress, wid = subject, within = .(pet), x = pet)

df_aov <- ezANOVA(data = df, dv = stress, wid = subject, within = .(pet), return_aov = TRUE)

pairwise.t.test(df$stress, df$pet, p.adjust.method = "none", paired = TRUE)

write.csv(x = df, file = "Practice_assignment_data.csv")
