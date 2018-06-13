setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\Categorical Variables")
dataset=read.csv("depression.csv")
View(dataset)
names(dataset)
str(dataset)


library(dplyr)
x1=filter(dataset,TRT=='A')
x2=filter(dataset,TRT=='B')
x3=filter(dataset,TRT=='C')

ggplot()+
  geom_point(aes(x=age,y=y,color=TRT),data=dataset)+
  geom_smooth(aes(x=age,y=y),data = x1,method='lm',color='red',se=FALSE)+
  geom_smooth(aes(x=age,y=y),data = x2,method='lm',color='blue',se=FALSE)+
  geom_smooth(aes(x=age,y=y),data = x3,method='lm',color='green',se=FALSE)
##it is interactive model

regressor=lm(y~.,dataset)
summary(regressor)
