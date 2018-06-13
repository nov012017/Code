setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\SLR\\Problems in residual plots")
dataset=read.csv("alcoholtobacco.csv")
View(dataset)
names(dataset)


regressor=lm(Tobacco~Alcohol,dataset)
summary(regressor)

y_pred=predict(regressor,newdata = dataset)
residuals=resid(regressor)

##plot residuals vs fits plot(residuals vs predicted values(x))
plot(y_pred,residuals)


##plot residuals vs predictor
plot(dataset$Alcohol,residuals)

###for standardized residuals
library(MASS)
std_resid=stdres(regressor)

plot(y_pred,std_resid)
