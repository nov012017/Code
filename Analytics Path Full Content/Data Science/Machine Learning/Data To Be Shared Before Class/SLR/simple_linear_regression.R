setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\SLR")
dataset=read.csv("Salary Data.csv")
View(dataset)
names(dataset)

##EDA
library(ggplot2)
ggplot(dataset,aes(YearsExperience,Salary))+geom_point(color="blue")

##Model building
regressor=lm(formula =Salary~YearsExperience ,data = dataset)

ggplot(dataset,aes(YearsExperience,Salary))+geom_point(color="blue")+
  geom_smooth(method = 'lm',color='red',se=FALSE)

##making predictions using the model
y_pred=predict(regressor,newdata = dataset)
#y_pred

dataset$predicted=y_pred

summary(regressor)
anova(regressor)

###############
library(caTools)
set.seed(123)    ##for replication
split=sample.split(dataset$Salary,SplitRatio = 2/3)
training_set=subset(dataset,split==TRUE)     #2/3-->TRUE--66.66%
test_set=subset(dataset,split==FALSE)        #1/3-->FALSE-33.33%

