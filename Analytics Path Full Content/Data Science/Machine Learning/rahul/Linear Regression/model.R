dataset = read.csv('bloodpress.csv')
regressor = lm(BP ~ Dur, data = dataset)
library(ggplot2)
ggplot(data = dataset, aes(x = Dur, y = BP)) +
  geom_point(color = 'blue') +
  geom_smooth(method = 'lm', se = FALSE, color = 'red')
summary(regressor)
anova(regressor)
plot(dataset$Age, resid(regressor))
