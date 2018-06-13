setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Influential Points")
dataset=read.csv("influence2.csv")
View(dataset)
names(dataset)
str(dataset) 

library(ggplot2)
ggplot(dataset,aes(x,y))+geom_point(color='blue')

##model
regressor=lm(y~x,dataset)
summary(regressor)
##leverages
dataset$leverages=hatvalues(regressor)
#sum of hatvalues=no.of coeff+intercept
sum(dataset$leverages)
##To plot leverages
ggplot(dataset,aes(x,leverages))+geom_point(color='blue')
##potential high leverages
#h>3(p/n)--->p=2(# of coeff),n=21(# of observations)
3*2/21

