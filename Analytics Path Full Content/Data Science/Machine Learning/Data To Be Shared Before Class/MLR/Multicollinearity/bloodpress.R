setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Multicollinearity")
dataset = read.csv('bloodpress.csv')
View(dataset)
dataset = dataset[,-1]

# Pair plots
library(GGally)
ggpairs(dataset)

# Correlation plot
library(corrplot)
M = cor(dataset)
corrplot.mixed(M)

# MLR
regressor = lm(BP ~ ., data = dataset)
summary(regressor)
anova(regressor)

# VIF
library(car)
vif(regressor)
#vif values--factors by which the se/variances of the independent variable are inflated.

# Validating the VIF values
regressor2 = lm(Weight ~ Age + BSA + Dur + Pulse + Stress, data = dataset)
summary(regressor2)
##formula for vif=1/(1-R2)
# Rerunning the model after removing the correlated variables BSA and Pulse
regressor3 = lm(BP ~ Age + Weight + Dur + Stress, data = dataset)
summary(regressor3)
vif(regressor3)
