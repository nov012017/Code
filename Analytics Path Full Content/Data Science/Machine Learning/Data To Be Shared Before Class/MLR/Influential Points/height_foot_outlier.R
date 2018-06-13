setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Influential Points")
dataset=read.csv("height_foot.csv")
View(dataset)
names(dataset)
str(dataset)

library(ggplot2)
ggplot(dataset,aes(foot,height))+geom_point(color='blue')

##model
regressor=lm(height~foot,dataset)
summary(regressor)
##leverages
dataset$leverages=hatvalues(regressor)
#sum of hatvalues=no.of coeff+intercept
sum(dataset$leverages)
##To plot leverages
ggplot(dataset,aes(foot,leverages))+geom_point(color='blue')
##potential high leverages
#h>3(p/n)--->p=(# of coeff),n=(# of observations)
3*2/21

#std residuals vs fits plot
y_pred=predict(regressor,newdata = dataset)

library(MASS)
dataset$stdres=stdres(regressor)

ggplot(dataset,aes(y_pred,stdres))+geom_point(color='blue')

###Calculating DFFITS
dataset$dffits=dffits(regressor)

##Calculating Cook's distance
dataset$cooks=cooks.distance(regressor)

#boxplot(dataset)
names(regressor)
plot(regressor)

