rm(list = ls())
setwd("~/Dropbox/Documents/Teaching/Winter 2014/Advanced Statistics/Coursework/Assignment 1/Homework 4/")

#setwd("~/Documents/Teaching/Winter 2014/Advanced Statistics/Coursework/Assignment 1")
n_participants <- 40#15

set.seed("12135")

overall_intercept <- 100

subject <- rep(1:n_participants, each = 4)
fish <- rep(1:2, each = 2, len = 4*n_participants)
beef <- rep(1:2, len = 4*n_participants)
breed <- subject %% 4

subject_intercept <- rnorm(length(subject), mean = 0, sd = 30)

fish_mean <- c(20, -20)
beef_mean <- c(10, -10)
breed_mean <- c(-12,-12,-12,36)

fish_sd <- c(2, 2)
beef_sd <- c(3, 3)

random_error <- rnorm(length(subject), mean = 0, sd = 10)

df <- data.frame(subject, fish, beef, breed)

df$eaten <- round(with(df, overall_intercept + subject_intercept[subject] + fish_mean[fish] + beef_mean[beef] + breed_mean[breed+1] + ifelse(fish == 1 & beef == 1, -50, 0) + random_error),0)


df$fish <- factor(df$fish, levels = c(1,2), labels = c("yes", "no"))
df$beef <- factor(df$beef, levels = c(1,2), labels = c("yes", "no"))
df$breed <- factor(df$breed, levels = c(0,1,2,3), labels = c("Shorthair", "Persian", "Siamese", "Manx"))
df$subject <- factor(df$subject)

library(ez)

ezStats(data = df, dv = eaten, wid = subject, within = .(fish, beef))

shapiro.test(df$eaten)

ezStats(data = df, dv = eaten, wid = subject, within = .(fish, beef), between = breed)

ezPlot(data = df, dv = eaten, wid = subject, within = .(fish, beef), between = breed, x = fish, split = beef, row = breed)

ezANOVA(data = df, dv = eaten, wid = subject, within = .(fish, beef), between = breed, type = 3)

library(reshape)
df.m <- melt(df, measure = "eaten")
df.c <- cast(df, subject + breed ~ fish + beef, mean)

colnames(df.c) <- c("subject", "breed", "fish_beef", "fish_no_beef", "no_fish_beef", "no_fish_no_beef")

write.csv(x = df, file = "Homework4_data.csv")

write.csv(x = df.c, file = "Homework4_data_spss.csv")

