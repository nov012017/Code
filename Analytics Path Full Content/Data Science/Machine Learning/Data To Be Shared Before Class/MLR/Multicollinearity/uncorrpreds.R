# uncorrpreds

dataset = read.csv('uncorrpreds.csv')


# Pair plots
library(GGally)
ggpairs(dataset)

# Regresssion y on x1
regressor1 = lm(y ~ x1, data = dataset)
summary(regressor1)
anova(regressor1)

# Regresssion y on x2
regressor1 = lm(y ~ x2, data = dataset)
summary(regressor1)
anova(regressor1)

# Regresssion y on both x1 and x2
regressor1 = lm(y ~ x1 + x2, data = dataset)
summary(regressor1)
anova(regressor1)
