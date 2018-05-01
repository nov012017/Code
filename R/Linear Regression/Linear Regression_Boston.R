library(MASS)
data("Boston")
View(Boston)
##########################################################
Boston$medv_log=log(Boston$medv)
hist(Boston$medv_log)

## Removing the outliers
Boston_medv_filtered<-Boston[Boston$medv_log>(mean(Boston$medv_log)-3*sd(Boston$medv_log)) & 
          Boston$medv_log<(mean(Boston$medv_log)+3*sd(Boston$medv_log)),]

hist(Boston_medv_filtered$medv_log)

boxplot(Boston_medv_filtered$medv_log)

##First Input variable lstat
cor(Boston[,c("crim","zn","lstat","medv_log")])

hist(Boston$lstat)
hist(sqrt(Boston_medv_filtered$lstat))
Boston_medv_filtered$lstat_sqrt=sqrt(Boston_medv_filtered$lstat)

##Second INput variable -- not use full
hist(Boston_medv_filtered$crim)
quantile(Boston_medv_filtered$crim,probs = seq(0,1,0.1))
View(Boston_medv_filtered)
names(Boston_medv_filtered)

Boston_medv_filtered$crim_status=cut(Boston_medv_filtered$crim,breaks = c(0,1,5,100),labels = c("low","medium","high"))

## Third input variable ptratio
hist(sqrt(Boston_medv_filtered$ptratio))
summary(Boston_medv_filtered$ptratio)
cor(Boston_medv_filtered$ptratio,Boston_medv_filtered$medv)
quantile(Boston_medv_filtered$ptratio,probs = seq(0,1,0.1))
Boston_medv_filtered$ptratio=sqrt(Boston_medv_filtered$ptratio)
boxplot(Boston_medv_filtered$ptratio)
Boston_medv_filtered<-Boston[Boston$ptratio>(mean(Boston$ptratio)-2*sd(Boston$ptratio)) & 
                               Boston$ptratio<(mean(Boston$ptratio)+2*sd(Boston$ptratio)),]

##Fourth input variable - not use full
hist(log(Boston_medv_filtered$dis))
Boston_medv_filtered$dis_log=log(Boston_medv_filtered$dis)
cor(Boston[.c(Boston_medv_filtered$dis,Boston_medv_filtered$lstat,Boston_medv_filtered$ptratio,Boston_medv_filtered$medv)])
cor(Boston_medv_filtered[,c("dis","lstat","ptratio","medv")])

##Fifth input variable
hist((Boston_medv_filtered$age**2))
boxplot(Boston_medv_filtered$age)

##Sampling
rows= 1:nrow(Boston_medv_filtered)
trainRows = sample(rows,round(0.7*nrow(Boston_medv_filtered)))
testrows<-rows[-trainRows]

traindata<-Boston_medv_filtered[trainRows,]
testdata<-Boston_medv_filtered[testrows,]


nrow(traindata)
nrow(testdata)

##Model 1 building
model_2V=lm(medv_log ~ lstat_sqrt, data=traindata)
summary(model_2V)
plot(model_2V)
hist(model_2V$residuals)

## Predictions
preds_train = predict(model_2V,traindata)
traindata$preds = 2.718**preds_train
rmse_train_model_2V=sqrt(sum((traindata$preds- traindata$medv)**2)/nrow(traindata))

preds_train = predict(model_2V,testdata)
testdata$preds = 2.718**preds_train
rmse_test_model_2V=sqrt(sum((testdata$preds- testdata$medv)**2)/nrow(testdata))

rmse_train_model_2V
rmse_test_model_2V

####-----------------------------------------------------######

#Model 2 building with three variables
model_2V=lm(medv_log ~ lstat_sqrt+ptratio, data=traindata)
summary(model_2V)
plot(model_2V)
hist(model_2V$residuals)

## Predictions
preds_train = predict(model_2V,traindata)
traindata$preds = 2.718**preds_train
rmse_train_model_2V=sqrt(sum((traindata$preds- traindata$medv)**2)/nrow(traindata))

preds_train = predict(model_2V,testdata)
testdata$preds = 2.718**preds_train
rmse_test_model_2V=sqrt(sum((testdata$preds- testdata$medv)**2)/nrow(testdata))

rmse_train_model_2V
rmse_test_model_2V

View(testdata)

##_______________________________________________________________#

model_3V=lm(medv_log ~ lstat_sqrt+ptratio, data=traindata)
summary(model_3V)
plot(model_3V)
hist(model_3V$residuals)

## Predictions
preds_train = predict(model_3V,traindata)
traindata$preds = 2.718**preds_train
rmse_train_model_2V=sqrt(sum((traindata$preds- traindata$medv)**2)/nrow(traindata))

preds_train = predict(model_3V,testdata)
testdata$preds = 2.718**preds_train
rmse_test_model_2V=sqrt(sum((testdata$preds- testdata$medv)**2)/nrow(testdata))

rmse_train_model_2V
rmse_test_model_2V


