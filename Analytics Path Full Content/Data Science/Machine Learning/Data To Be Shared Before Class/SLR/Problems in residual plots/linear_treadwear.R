setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\SLR\\Problems in residual plots")
dataset=read.csv("treadwear.csv")
View(dataset)
names(dataset)

library(ggplot2)
ggplot(dataset,aes(mileage,groove))+geom_point(color='blue')+
  geom_smooth(method='lm',color='red',se=FALSE)

##model
regressor=lm(groove~mileage,dataset)
summary(regressor)

y_pred=predict(regressor,newdata = dataset)
residuals=resid(regressor)

##plot residuals vs fits plot
plot(y_pred,residuals)
##plot here,following a pattren--here it is non-ideal residuals.
##for ideal,the plot is random and horizontal pattern

##plot residuals vs predictor
plot(dataset$mileage,residuals)

