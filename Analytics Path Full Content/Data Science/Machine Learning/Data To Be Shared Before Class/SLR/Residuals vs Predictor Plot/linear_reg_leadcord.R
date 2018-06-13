setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\SLR\\p-value & CI")
dataset=read.csv("leadcord.csv")
str(dataset)
names(dataset)

library(ggplot2)
ggplot(dataset,aes(Sold,Cord))+geom_point()+
  geom_smooth(method = 'lm',color="red",se=FALSE)

##build model
regressor1=lm(Cord~Sold,dataset)
summary(regressor1)
anova(regressor1)
