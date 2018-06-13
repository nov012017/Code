##x and y transfermation
setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Data Transformations")
dataset=read.csv("shortleaf.csv")
View(dataset)
names(dataset)
str(dataset)

##
regressor=lm(Vol~Diam,dataset)

y_pred=predict(regressor,newdata=dataset)

plot(y_pred,resid(regressor))
plot(regressor)

##transfermation
dataset$logDiam=log(dataset$Diam)
dataset$ligVol=log(dataset$Vol)

##model2
regressor=lm(logVol~logDiam,dataset)

y_pred=predict(regressor,newdata=dataset)

plot(y_pred,resid(regressor))
plot(regressor)
summary(regressor)
