library(MASS)
data(Boston)
?Boston
Boston

##log or sqrt transformation

Boston$medv_sqrt = sqrt(Boston$medv)
Boston$medv_log = log(Boston$medv)

### 
rows = 1:nrow(Boston)
trainRows = sample(rows,round(0.7*nrow(Boston)))
testRows = rows[-trainRows]
trainData = Boston[trainRows,]
testData = Boston[testRows,]
#### Modeling
mod1 = lm(medv_log~ lstat+crim+age,data=trainData)
summary(mod1$residuals)
summary(mod1)
plot(mod1)
trainData$predicted=predict(mod1)
trainData$residuals=residuals(mod1)
View(trainData)

#### Predictions on train
preds_train = predict(mod1,trainData)
summary(preds_train)
trainData$predicted_log=preds_train
trainData$residuals_log=trainData$predicted_log-trainData$medv_log
trainData$predicted=preds_train
trainData$preds = 2.718**preds_train
errors=trainData$preds-trainData$medv
View(trainData)
summary(sqrt(errors))
View(errors)

#### Predictions on test
preds_test = predict(mod1,testData)
testData$preds = 2.718**preds_test

##RMSE Trainset 
sqrt(sum((trainData$preds- trainData$medv)**2)/nrow(trainData))

##RMSE Testset 
sqrt(sum((testData$preds- testData$medv)**2)/nrow(testData))
