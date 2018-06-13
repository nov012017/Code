setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\SLR\\Residuals vs Fits Plot")
dataset=read.csv("alcoholarm.csv")
str(dataset)
names(dataset)

regressor=lm(strength~alcohol,dataset)
summary(regressor)
anova(regressor)

y_pred=predict(regressor,newdata = dataset)
plot(y_pred,resid(regressor))
