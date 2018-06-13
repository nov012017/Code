setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Data Transformations")
dataset=read.csv("mammgest.csv")
View(dataset)
names(dataset)
str(dataset)

##ggplot

ggplot(dataset,aes(Gestation,Birthwgt))+geom_point()
##model1
regressor=lm(Gestation~Birthwgt,dataset)

y_pred=predict(regressor,newdata = dataset)

plot(y_pred,resid(regressor))
plot(regressor)
##transermation
dataset$loggest=log(dataset$Gestation)

##model2
regressor=lm(loggest~Birthwgt,dataset)

y_pred=predict(regressor,newdata = dataset)

plot(y_pred,resid(regressor))
plot(regressor)

summary(regressor)


