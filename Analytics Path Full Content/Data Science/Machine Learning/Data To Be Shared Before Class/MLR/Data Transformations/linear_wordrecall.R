setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Data Transformations")
dataset=read.csv("wordrecall.csv")
View(dataset)
names(dataset)
str(dataset)

library(ggplot2)
ggplot(dataset,aes(time,prop))+geom_point()

##
regressor=lm(prop~time,dataset)

y_pred=predict(regressor,newdata=dataset)

plot(y_pred,resid(regressor))

##transfermation
dataset$logtime=log(dataset$time)
##after t/f
ggplot(dataset,aes(logtime,prop))+geom_point()

##model2 
regressor=lm(prop~logtime,dataset)

y_pred=predict(regressor,newdata=dataset)

plot(y_pred,resid(regressor))

summary(regressor)
