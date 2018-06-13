setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\SLR\\Problems in residual plots")
dataset=read.csv("alphapluto.csv")
View(dataset)
names(dataset)


regressor=lm(pluto~alpha,dataset)
summary(regressor)

y_pred=predict(regressor,newdata = dataset)
residuals=resid(regressor)

library(MASS)
std_resid=stdres(regressor)
##plot residuals vs fits plot
plot(y_pred,residuals)


##plot residuals vs predictor
plot(dataset$alpha,residuals)

