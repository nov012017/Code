dataset = read.csv('birthsmokers.csv')
library(GGally)
ggpairs(dataset)
library(ggplot2)
library(dplyr)
x1 = filter(dataset, Smoke == 'no')
x2 = filter(dataset, Smoke == 'yes')
ggplot() +
  geom_point(aes(x = Gest, y = Wgt, color = Smoke), data = dataset) +
  geom_smooth(aes(x = Gest, y = Wgt), data = x1, method = 'lm', color = 'red', se = FALSE) +
  geom_smooth(aes(x = Gest, y = Wgt), data = x2, method = 'lm', color = 'blue', se = FALSE)

regressor = lm(Wgt ~ ., data = dataset)
summary(regressor)