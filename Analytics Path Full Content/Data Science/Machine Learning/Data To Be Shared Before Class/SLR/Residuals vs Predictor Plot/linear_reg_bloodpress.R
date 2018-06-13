setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\SLR\\Residuals vs Predictor Plot")
dataset=read.csv("bloodpress.csv")
str(dataset)
names(dataset)

library(ggplot2)
regressor=lm(BP~Dur,dataset)
summary(regressor)
anova(regressor)
##plot residuals vs predictor values

residuals_model<-resid(regressor)

plot(dataset$Dur,residuals_model)

plot(dataset$Age,residuals_model)

plot(dataset$Weight,residuals_model)
