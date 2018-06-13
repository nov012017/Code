data1 = read.csv("C:/Users/phsivale/Documents/Trainings/Logistic Regression/Churn.csv")
head(df)
data1$Phone = NULL

summary(data1)
data1$Area.Code = as.factor(data1$Area.Code)
data1$Churn = as.factor(data1$Churn)
levels(data1$State)

rows <- 1:nrow(data1)
set.seed(123)

train_rows<- sample(rows,2300)
test_rows <- rows[-train_rows]

train <- data1[train_rows,]
test <- data1[test_rows,]

table(train$Churn)

library(rpart)
dtree = rpart(Churn~.,data = train)
preds = predict(dtree,test,type='response')
table(test$Churn,preds$class,dnn=c('acts','preds'))



# Bagging
library(adabag)
bagModel = bagging(Churn~.,data = train,mfinal = 50)
preds = predict(bagModel,test,type='response')
preds_train = predict(bagModel,train,type='response')
table(test$Churn,preds$class,dnn=c('acts','preds'))
table(train$Churn,preds_train$class,dnn=c('acts','preds'))


###
library(randomForest)
rfmod = randomForest(Churn~.,data=train,ntree=300,mtry=8,classwt=c(30,1),
                     nodesize=2,strata=train$Churn)
#classwt=c(20,1)strata=train$Churn
preds = predict(rfmod,test,type='response')
preds_train = predict(rfmod,train,type='response')
table(test$Churn,preds,dnn=c('acts','preds'))
table(train$Churn,preds_train,dnn=c('acts','preds'))

importance(rfmod)

tuneRF(y=train$Churn,x=train[,-8])

importance(rfmod)

#### Adaboost

library(adabag)
adaboost = boosting(Churn ~ .,data = train,mfinal =20,boos = TRUE)
#importanceplot(adaboost)
adaboost$importance
preds = predict(adaboost,test)
table(test$Churn,preds$class,dnn = c('acts','preds'))
head(preds)
preds$error

#### GBM

library(gbm)
train$Churn = as.numeric(as.character(train$Churn))
gbmmodel = gbm(Churn ~ .,data = train,
               distribution = 'bernoulli',
               n.trees = 2500,
               interaction.depth = 4,
               bag.fraction = 0.5,
               n.minobsinnode = 10,
               verbose = F,
               train.fraction = 1)


preds = predict(gbmmodel,test,n.trees = 2500,type = 'response')
preds_class = ifelse(preds >0.4,1,0)
table(test$Churn, preds_class,dnn = c('acts','preds'))

