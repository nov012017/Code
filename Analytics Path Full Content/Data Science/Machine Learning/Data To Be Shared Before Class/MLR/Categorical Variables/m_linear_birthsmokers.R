setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Categorical Variables")
dataset=read.csv("birthsmokers.csv")
View(dataset)
names(dataset)
str(dataset)

##visualiztion
library(ggplot2)
#x=gest,y=weight
#ggplot(dataset,aes(Gest,Wgt))+geom_point()

ggplot(dataset,aes(Gest,Wgt,color=Smoke))+
  geom_point()+
  geom_smooth(method='lm',aes(x=Gest,y=Wgt),color='blue',se=FALSE)

library(dplyr)
x1=filter(dataset,Smoke=='no')
x2=filter(dataset,Smoke=='yes')

ggplot()+
  geom_point(aes(x=Gest,y=Wgt,color=Smoke),data=dataset)+
  geom_smooth(aes(x=Gest,y=Wgt),data = x1,method='lm',color='red',se=FALSE)+
  geom_smooth(aes(x=Gest,y=Wgt),data = x2,method='lm',color='blue',se=FALSE)
  
##slope is same for both lines but intercepts are different.
regressor=lm(Wgt~.,dataset)
summary(regressor)
anova(regressor)
###intercept here is not interpreted
