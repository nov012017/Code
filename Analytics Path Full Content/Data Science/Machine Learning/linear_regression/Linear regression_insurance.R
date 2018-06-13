setwd("D:\\Data Science\\Machine Learning")

insurance = read.csv("insurance.csv")
head(insurance)


#######################################
#2-EDA
#######################################
#UNDERSTANDING the structue of the data
summary(insurance)
str(insurance)
insurance$children=factor(insurance$children)

###Univariate Analysis(Dependent variable)
#Histogram
hist(insurance$charges)
summary(insurance$charges)

#skewness & Kurtosis
library(e1071)
skewness(insurance$charges)## +ve indicates---right skewness
kurtosis(insurance$charges)## +ve indicates---the peak of the distribution is more than the normal distr.

#no normal distribution

### Bivarient Analysis(relationship b/w dep n indep variables)
###############################################################
#mpg vs charges
library(ggplot2)
ggplot(insurance,aes(x=age,y=charges,color='age'))+
  geom_point()+
  geom_smooth(method = 'lm',color='blue',se=FALSE)
##sex vs charges
ggplot(insurance,aes(x=sex,y=charges))+
  geom_boxplot()
##outliers
##bmi vs charges
ggplot(insurance,aes(x=bmi,y=charges,color='age'))+
  geom_point()+
  geom_smooth(method = 'lm',color='blue',se=FALSE)
##Hetero scadacity + Non Linearity
##children vs charges
ggplot(insurance,aes(x=children,y=charges))+
  geom_boxplot()
##outliers problem
##smoker vs charges
ggplot(insurance,aes(x=smoker,y=charges))+
  geom_boxplot()
##No smokers has outliers and charges are high for smokers
#region vs charges
ggplot(insurance,aes(x=region,y=charges))+
  geom_boxplot()
##Many outliers 

#############################################
###Objective Bivarient Analysis
#############################################
##Identify non-numerical data
sub_dataset=insurance[,c(1,3)]
#Pairplot
library(GGally)
ggpairs(sub_dataset)
##correlation plot
library(corrplot)
corrmat=cor(sub_dataset)
corrplot.mixed(corrmat)
##less correlation between age and bmi.So they are independent
##########################################
#####DATA PREPROCESSING###################
##########################################

sum(is.na(insurance))
sapply(insurance,function(x) sum(is.na(x)))

###################
#  Splitting data into training and test sets
#####################
library(caTools)
set.seed(123)
split=sample.split(insurance$charges,SplitRatio = 0.7)
train_data=subset(insurance,split==TRUE)
test_data=subset(insurance,split==FALSE)


######################################################
#First version of the model on training data
#####################################################
regressor1=lm(charges~.,train_data)
y_pred=predict(regressor1,newdata = test_data)
#y_pred

##Testing the assumptions
#Assumption1-Linearity(residuals vs test_data)
fits=lm(charges~.,data=test_data)
residuals=resid(fits)
##Residuals vs fits plot

ggplot(test_data,aes(x=y_pred,y=residuals))+
  geom_point()+
  geom_smooth(method = 'lm',color='blue',se=FALSE)

##
library(MASS)
standres=stdres(fits)
ggplot(test_data,aes(x=y_pred,y=standres))+
  geom_point()+
  geom_smooth(method = 'lm',se=FALSE)

##Data Transformation 
#Lets Transformation for charges
hist(insurance$charges)
skewness(insurance$charges)
kurtosis(insurance$charges)
##log transformation
insurance$charges=log(insurance$charges)
hist(insurance$charges)
skewness(insurance$charges)
kurtosis(insurance$charges)

##Again repeat Bivarient 
##Same steps as before

### Bivarient Analysis(relationship b/w dep n indep variables)
###############################################################
#mpg vs charges
library(ggplot2)
ggplot(insurance,aes(x=age,y=charges,color='age'))+
  geom_point()+
  geom_smooth(method = 'lm',color='blue',se=FALSE)
##improved linearity
##sex vs charges
ggplot(insurance,aes(x=sex,y=charges))+
  geom_boxplot()
##outliers are removed after trans
##bmi vs charges
ggplot(insurance,aes(x=bmi,y=charges,color='age'))+
  geom_point()+
  geom_smooth(method = 'lm',color='blue',se=FALSE)
##Hetero scadacity + Non Linearity---no improvement
##children vs charges
ggplot(insurance,aes(x=children,y=charges))+
  geom_boxplot()
##outliers removed
##smoker vs charges
ggplot(insurance,aes(x=smoker,y=charges))+
  geom_boxplot()
## outliers removed and charges are high for smokers
#region vs charges
ggplot(insurance,aes(x=region,y=charges))+
  geom_boxplot()
## outliers removed
############################################
##Repeat the model

###################
#  Splitting data into training and test sets
#####################
library(caTools)
set.seed(123)
split=sample.split(insurance$charges,SplitRatio = 0.7)
train_data=subset(insurance,split==TRUE)
test_data=subset(insurance,split==FALSE)


######################################################
#Second version of the model on training data
#####################################################
regressor2=lm(charges~.,train_data)
y_pred2=predict(regressor2,newdata = test_data)

y_pred_train=predict(regressor2,newdata = train_data)

###Testing the Assumptions
#Assumption 1-Linearity
standres2=stdres(regressor2)
ggplot(aes(x=y_pred_train,y=standres2),data=train_data)+
  geom_point()+
  geom_smooth(method = 'lm',se=FALSE)


#Assumption 2-Independent of residuals
library(car)
durbinWatsonTest(regressor2)
##Assumption 2 is valid...i.e.:No independence b/w variables---2.07 lies b/w 1.5 & 2.5


##Assumptio 3-Normal distribution of residuals
hist(resid(regressor2))
skewness(resid(regressor2))
kurtosis(resid(regressor2))
qqPlot(regressor2)
##Residuals are normally distributed


##Assumption 4:Equal variances
standres2=stdres(regressor2)
ggplot(aes(x=y_pred_train,y=standres2),data=train_data)+
  geom_point()+
  geom_smooth(method = 'lm',color='blue',se=FALSE)
#No prominent heteroscedacity observed

#Multicollinearity
library(car)
vif(regressor2)
###No multicollinearity..i.e. All values are in the range of 1.0

#Lets check for influential points,if any
plot(regressor2)

train_data$leverages=cooks.distance(regressor3)
max(train_data$leverages)



##Remove the outliers and leverages
#103,517,1028
train_data=train_data[-c(103,517,1028),]
#model3
regressor3=lm(charges~.,data=train_data)

plot(regressor3)
plot(regressor3,which = 3)

summary(regressor3)
anova(regressor3)

# Now let's make a prediction and write a submission file
Prediction <- predict(regressor3, test_data, type = "response")
#submit <- data.frame(Id = test$, charges = Prediction)
write.csv(submit, file = "submit_charges.csv", row.names = FALSE)