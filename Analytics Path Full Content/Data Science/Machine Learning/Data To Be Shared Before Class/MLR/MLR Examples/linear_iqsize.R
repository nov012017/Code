setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR\\MLR Examples")
dataset=read.csv("iqsize.csv")
View(dataset)
names(dataset)

library(ggplot2)
##plot IQ vs Brain
ggplot(dataset,aes(Brain,PIQ))+geom_point(color='blue')

##plot
ggplot(dataset,aes(Weight,PIQ))+geom_point(color='blue')
##
ggplot(dataset,aes(Height,PIQ))+geom_point(color='blue')

#install.packages("GGally")
library(GGally)

ggpairs(dataset)

regressor=lm(PIQ~.,dataset)
#regressor=lm(PIQ~Brain+Height+Weight,dataset)
summary(regressor)
anova(regressor)

y_pred=predict(regressor,newdata = dataset)
#residuals=resid(regressor)
 
library(MASS)
std_resid=stdres(regressor)
 plot(y_pred,std_resid)

##qq plot
#install.packages("nloptr")
#install.packages("car",dependencies=TRUE)

library(car)
qqPlot(std_resid)

#calculation of R-squared value
#-----------------------------------------
#From Anova()
#ssto=2697.1+2875.6+13321.8=18894.5
#R-squared=1-(sse/ssto)=1-(13321.8/18894.5)=0.2949377
#-------------------------------------------------------
 
