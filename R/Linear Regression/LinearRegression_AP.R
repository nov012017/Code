library(MASS)
data(Boston)
?Boston
Boston
summary(Boston$medv)
write.csv(Boston,"Boston.csv")
getwd()
View(Boston)
##log or sqrt transformation
hist(Boston$medv)
hist(log(Boston$medv))
summary(log(Boston$medv))
hist(sqrt(Boston$medv))
summary(sqrt(Boston$medv))

Boston$medv_sqrt = sqrt(Boston$medv)
Boston$medv_log = log(Boston$medv)
hist(Boston$black)
boxplot(Boston$black)
### 
quantile(Boston$black,probs = seq(0,1,0.01))
rows = 1:nrow(Boston)
trainRows = sample(rows,round(0.7*nrow(Boston)))
testRows = rows[-trainRows]

trainData = Boston[trainRows,]
testData = Boston[testRows,]

plot(Boston$lstat,Boston$medv)
#abline(mod1)

plot(Boston$lstat,Boston$medv_log)
abline(mod2)
###
summary(Boston$medv_log)

#### Modeling
mod1 = lm(medv_log~ lstat+crim+age,data=trainData)
summary(mod1$residuals)
summary(mod1)

mod1 = lm(medv_log~ .-medv-medv_sqrt-zn-indus-age,data=trainData)
summary(mod1)

hist(trainData$medv_log)
hist(mod1$residuals)
summary(mod1$residuals)

plot(mod1)

#### Predictions on train
preds_train = predict(mod1,trainData)
summary(preds_train)
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

#####
mod1 = lm(medv_log~ lstat,data=trainData)
summary(mod1)

mod2 = lm(medv_sqrt ~ lstat+ black+ crim, data=Boston)
summary(mod2)

mod3 = lm(medv_sqrt ~ .-medv-indus-age-lstat , data=Boston)
summary(mod3)

summary(mod3$residuals)
plot(mod3)

View(cor(Boston[,-c(3,7,14,15)]))

hist(log(Boston$medv))
summary(log(Boston$medv))
hist(sqrt(Boston$medv))
summary(sqrt(Boston$medv))

Boston$medv_sqrt =  sqrt(Boston$medv)

#### Outliers
mean(Boston$medv_sqrt) + 3*sd(Boston$medv_sqrt)
mean(Boston$medv_sqrt) - 3*sd(Boston$medv_sqrt)

Boston = Boston[Boston$med_sqrt < 7 & Boston$med_sqrt > 2, ]


###indus

Boston$indus_cat = ifelse(Boston$indus > 17, 'High','Normal')
Boston$indus_cat = as.factor(Boston$indus_cat)

## plots
plot(Boston$lstat, Boston$medv)
fit0 = lm(medv~lstat, data=Boston)
abline(fit0)


plot(Boston$lstat, Boston$med_sqrt)
# cor(Boston$lstat, Boston$medv)

fit1 = lm(med_sqrt~lstat, data=Boston)
fit1
summary(fit1)
abline(fit1)

hist(fit0$residuals) ## Original Feature
summary(fit0$residuals)

hist(fit1$residuals) ## sqrt transformed
summary(fit1$residuals)

names(fit1)
fit1$residuals

hist(sqrt(Boston$lstat))
summary(sqrt(Boston$lstat))
hist(log(Boston$lstat))
summary(log(Boston$lstat))

Boston$lstat_sqrt  =sqrt(Boston$lstat)

fit3 = lm(med_sqrt~lstat_sqrt,data=Boston)
summary(fit3)
summary(fit3$residuals)
hist(fit3$residuals)
plot(fit3)

plot(fit1)


fit2 = lm(med_sqrt~lstat_sqrt+ crim +black + age + zn + tax, data=Boston)
summary(fit2)
plot(fit2)

fit3 = lm(medv ~ . - age - indus, data=Boston)
summary(fit3)
# par(mfrow = c(2,2))
# par(mfrow = c(1,1))

hist(Boston$medv)

plot(fit3)

View(cor(Boston[,-c(14)]))
fit4 = lm(medv ~ .-age-indus, data=Boston)
hist(Boston$medv)
fit4 = lm(I(log(medv)) ~ .-age-indus, data=Boston)
summary(fit4)
plot(fit4)

fit5 = lm(medv ~ lstat + I(lstat^2), data=Boston)
summary(fit5)
plot(fit5)

######
data(Boston)
Boston
Boston$med_sqrt =  sqrt(Boston$medv)
Boston$lstat_sqrt =  sqrt(Boston$lstat)

Boston = Boston[Boston$med_sqrt < 7 & Boston$med_sqrt > 2, ]

## Trian test split
rows = 1: nrow(Boston)
trainRows = sample(rows,round(0.7*nrow(Boston)))
trainData = Boston[trainRows,]
testData = Boston[-trainRows,]


## Model Building
fit2 = lm(med_sqrt~lstat_sqrt+ crim +black + age + zn + tax, data=trainData)
summary(fit2)
# plot(fit2)


### Predict
preds = predict(fit2,testData)

## Computing Metrics
rmse = sqrt(mean((testData$med_sqrt-preds)^2))

rmse = sqrt(mean((testData$med_sqrt**2-preds**2)^2))
