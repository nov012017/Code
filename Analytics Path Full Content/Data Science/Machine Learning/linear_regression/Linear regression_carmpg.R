setwd("D:\\Data Science\\Machine Learning")
dataset=read.csv("carmpg.csv")
View(dataset)
names(dataset)

#######################################
#2-EDA
#######################################
#UNDERSTANDING the structue of the data
summary(dataset)
str(dataset)
dataset$cylinders=factor(dataset$cylinders)
dataset$horsepower=as.numeric(dataset$horsepower)
dataset$model.year=factor(dataset$model.year)
dataset$origin=factor(dataset$origin)
dataset$car.name=as.character(dataset$car.name)
##check the data again
str(dataset)

###Univariate Analysis(Dependent variable)
#Histogram
hist(dataset$mpg)
summary(dataset$mpg)
#skewness & Kurtosis
library(e1071)
skewness(dataset$mpg)## +ve indicates---right skewness
kurtosis(dataset$mpg)## -ve indicates---the peak of the distribution is less than 
                                        #the normal distribution.

#slightly normal distribution

### Bivarient Analysis(relationship b/w dep n indep variables)
#mpg vs cylenders
library(ggplot2)
ggplot(dataset,aes(x=cylinders,y=mpg,color='cylinders'))+geom_boxplot()

#potential outliers present

#mpg & displacement--both are numeric n cont--scatterplot
ggplot(dataset,aes(displacement,mpg))+
  geom_point(color='blue')+
  geom_smooth(method = 'lm',color='red',se=FALSE)
##Non-linear trend,might be outliers,may need trail n data transformations


#mpg vs horsepower
ggplot(dataset,aes(x=horsepower,y=mpg,color=cylinders))+
  geom_point()+
  geom_smooth(method = 'lm',color='red',se=FALSE)

#May neeed to divide  the hp(<50 or >50)before feeding

#mpg vs weights
ggplot(dataset,aes(displacement,mpg))+
  geom_point(color='blue')+
  geom_smooth(method = 'lm',color='red',se=FALSE)
##Exponentially decreasing trend,may need some transformation

#mpg vs acceleration
ggplot(dataset,aes(acceleration,mpg))+
  geom_point(color='blue')+
  geom_smooth(method = 'lm',color='red',se=FALSE)
##(Non-constant variance)Heteroscedacity + non-linearity 

#mpg vs model.year
ggplot(dataset,aes(model.year,mpg))+
  geom_boxplot(color='blue')

#mpg vs origin
ggplot(dataset,aes(origin,mpg))+
  geom_boxplot(color='blue')
##some potential outliers origin=2

###Objective Bivarient Analysis
str(dataset)
names(dataset)
## Identify non-numeric variables and--mpg,displa,horsepower,weight,acceleration
sub_dataset= dataset[,c('mpg','displacement','horsepower','weight','acceleration')]

#Pairplot
library(GGally)
ggpairs(sub_dataset)
##correlation plot
library(corrplot)
corrmat=cor(sub_dataset)
corrplot.mixed(corrmat)
##High corr observed b/w disp and weight
##Mild correlation bw displa and acceleration

##########################################
#####DATA PREPROCESSING###################
##########################################

sum(is.na(dataset$mpg))
sapply(dataset,function(x) sum(is.na(x)))

###################
##Splitting data into training and test sets
#####################
library(caTools)
set.seed(567)
split=sample.split(dataset$mpg,SplitRatio = 0.7)
train_data=subset(dataset,split==TRUE)
test_data=subset(dataset,split==FALSE)
#View(train_data)
#View(test_data)

train_data$car.name<-NULL
test_data$car.name<-NULL

######################################################
#First version of the model on training data
#####################################################
regressor1=lm(mpg~.,train_data)
y_pred=predict(regressor1,newdata = test_data)
#y_pred

##Testing the assumptions
#Assumption1-Linearity(residuals vs test_data)
residuals=resid(lm(mpg~.,data = test_data))
library(MASS)
standres=stdres(lm(mpg~.,data = test_data))

##Residuals vs fits plot
ggplot(test_data,aes(x=y_pred,y=standres))+geom_point()+
  geom_smooth(method = 'lm',se=FALSE)

##Non-liear distribution,heteroscedacity,potential influential points


##Data Transformation 
#Lets Transformation for mpg
hist(dataset$mpg)
skewness(dataset$mpg)#+ve right skewed
kurtosis(dataset$mpg)#-ve below the peak

dataset$mpg=log(dataset$mpg)
hist(dataset$mpg)
skewness(dataset$mpg)#-ve left skewed
kurtosis(dataset$mpg)# -ve

#Bivarient Analysis(Post transormation)

ggplot(dataset,aes(x=cylinders,y=mpg,color='cylinders'))+geom_boxplot()
###Do this for all Bivariant variables
##Again do model

###########################################################################3
#Create second version of the model
#Splitting the data into....
#####################
library(caTools)
set.seed(567)
split=sample.split(dataset$mpg,SplitRatio = 0.7)
train_data=subset(dataset,split==TRUE)
test_data=subset(dataset,split==FALSE)
#View(train_data)
#View(test_data)


train_data$car.name<-NULL
test_data$car.name<-NULL

###################################
#Create the second version model
regressor2=lm(mpg~.,train_data)
y_pred2=predict(regressor2,newdata = test_data)
#y_pred
y_pred_train=predict(regressor2,newdata = train_data)

###Testing the Assumptions
#Assumption 1-Linearity
standres2=stdres(regressor2)
ggplot(aes(x=y_pred_train,y=standres2),data=train_data)+
  geom_point()+
  geom_smooth(method = 'lm',se=FALSE)

##For test data
#ggplot(aes(x=y_pred2,y=stdres(lm(mpg~.,data=test_data)))+
# geom_point()

#Assumption 2-Independent of residuals
library(car)
durbinWatsonTest(regressor2)
##Assumption 2 is valid...i.e.:No independence b/w variables---1.6 lies b/w 1.5 & 2.5

##Assumptio 3-Normal distribution of residuals
hist(resid(regressor2))
skewness(resid(regressor2))
kurtosis(resid(regressor2))
qqPlot(regressor2)
##Residuals are normally distributed

##Assumption 4:Equal variances
standres2=stdres(regressor2)
ggplot(aes(x=y_pred_train,y=standres2),data=train_data)+
  geom_point()
#No prominent heteroscedacity observed

#Multicollinearity
library(car)
vif(regressor2)#variance inflation factor

##remove displacement variable--which is having high vif value
dataset$displacement<-NULL
dataset$car.name<-NULL
##
#Splitting the data into....
#####################
library(caTools)
set.seed(567)
split=sample.split(dataset$mpg,SplitRatio = 0.7)
train_data=subset(dataset,split==TRUE)
test_data=subset(dataset,split==FALSE)
#View(train_data)
#View(test_data)

##Rebuild the model
regressor3=lm(mpg~.,data = train_data)
vif(regressor3)

#Lets check for influential points,if any
plot(regressor3)

train_data$leverages=cooks.distance(regressor3)
max(train_data$leverages)

#No major influential points in the data
#0.5 to 1.0--may be influential
#Greater than 1--must be potential point

###Predict on test data
y_pred3=predict()
##summary
summary(regressor3)
anova(regressor3)
