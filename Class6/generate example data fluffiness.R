sigma <- 20
fluffiness<- rnorm(100, 50, 20)
animal <- rep(c("cat","dog"), each = 50)
fluffiness <- fluffiness + ifelse(animal == "cat", 60, -60)

positive_feelings <- 200 + 1*(fluffiness-50) + ifelse(animal == "cat", -100, 100) + rnorm(100, 0, sigma)
positive_feelings <- positive_feelings/10

fluffiness <- scale(fluffiness)*25 +45
positive_feelings <- scale(positive_feelings)*20+50

plot(y = positive_feelings, x = fluffiness)

lm(positive_feelings ~ fluffiness)

lm(positive_feelings ~ fluffiness + factor(animal))

write.csv(data.frame(positive_feelings = round(positive_feelings), fluffiness = round(fluffiness), animal), file = "fluffy.csv", row.names = FALSE)

