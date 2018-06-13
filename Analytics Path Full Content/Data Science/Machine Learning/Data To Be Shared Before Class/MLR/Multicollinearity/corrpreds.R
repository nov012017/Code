# corrpreds
setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Multicollinearity")

dataset = read.csv('corrpreds.csv')


# Pair plots
library(GGally)
ggpairs(dataset)

# Regresssion y on x1
regressor1 = lm(y ~ x1, data = dataset)
summary(regressor1)
anova(regressor1)

# Regresssion y on x2
regressor2 = lm(y ~ x2, data = dataset)
summary(regressor2)
anova(regressor2)

# Regresssion y on both x1 and x2
regressor3 = lm(y ~ x1 + x2, data = dataset)
summary(regressor3)
anova(regressor3)
