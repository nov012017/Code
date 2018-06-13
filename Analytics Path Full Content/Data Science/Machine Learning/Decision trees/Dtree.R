setwd("D:\\Data science  notes")

library(ISLR)

data("Default")
View(Default)
library(rpart)

head(Default)

### rpart for cart 

default_tree = rpart(default ~ . , data = Default )

plot(default_tree)
text(default_tree)

library(rpart)				        # Popular decision tree algorithm
library(rattle)					# Fancy tree plot
library(rpart.plot)				# Enhanced tree plots
library(RColorBrewer)				# Color selection for fancy tree plot
library(party)					# Alternative decision tree algorithm
library(partykit)				# Convert rpart object to BinaryTree
library(caret)

fancyRpartPlot(default_tree)
##### 

df1 = read.csv("Churn.csv")
head(df1)

names(df1)

df1 = df1[,-c(19:21)]

table(df1$Churn)

prop.table(table(df1$Churn))

df1$Churn = ifelse(df1$Churn == 1, "Yes", "No")

table(df1$Churn)

prop.table(table(df1$Churn))

set.seed(1238)

ids = sample(nrow(df1), nrow(df1)*0.8)

train = df1[ids,]
test = df1[-ids,]

### cart model 
library(rpart)
?rpart
churntree = rpart( Churn ~ ., data=train, method="class")
attributes(churntree)

library(rpart)				        # Popular decision tree algorithm
library(rattle)					# Fancy tree plot
library(rpart.plot)				# Enhanced tree plots
library(RColorBrewer)				# Color selection for fancy tree plot
library(party)					# Alternative decision tree algorithm
library(partykit)				# Convert rpart object to BinaryTree
library(caret)

fancyRpartPlot(churntree)

test$pred = predict( churntree, newdata = test, type="class")


## not adding the predictions to train dataset 
trainpred = predict( churntree, newdata = train, type="class")

### performance on train
table(train$Churn, trainpred)
### [erformance on test]
table(test$Churn, test$pred)

trainaccu = (284+2254)/2666 ## 0.95 
testaccu = (74+551)/667 ## 0.93

(27+103)/nrow(train)

(7+26)/nrow(test)

## train error is 0.048 
## test error is 0.049


precision = 67/78
recall = 67/(67+32)

f_1 = 2*precision*recall/(precision+recall)

### CP matrix to check the cp and relative error 
printcp(churntree)


### Pruning a tree 

prunedtree = prune(churntree, cp = 0.013055)

fancyRpartPlot(prunedtree)

printcp(prunedtree)

## performance of pruned tree 


test$pruned_pred = predict(prunedtree, newdata = test, type="class")


table(test$Churn, test$pruned_pred)

(552+70)/667

(8+26)/nrow(test)
### randomforest 

head(train)

## ensemble techniques ## using re sampling methods
library(randomForest)

rftrees = randomForest(as.factor(Churn) ~ ., data=train ) #, ntree = 30, mtry = 6, classwt = c( 0.7, 0.3))
test$pred_rf = predict(rftrees, newdata = test )

table(test$Churn, test$pred_rf)
precision = 97/100
recall = 97/100

2*precision*recall/(precision+recall)

names(rftrees)
## number of trees by defult picked by randomforest 

rftrees$ntree

?randomForest
### parameter tuning of randomforest 

rftree2 = randomForest(as.factor(Churn) ~ ., data=train, ntree=50, mtry = 17, classwt = c( 0.7,0.3), nodesize = 10, maxnodes = 30) 

pred = predict(rftree2, newdata = test)

## confusion matrix 

table(test$Churn, pred)

precision = 75/90
recall = 75/(99)

2*precision*recall/(precision+recall)

names(rftrees)

importance(rftrees, decreasing = T)

varImpPlot(rftrees)


### bagging using Ipred 

library(ipred)

bagtree = bagging( as.factor(Churn) ~ . , data = train, nbagg = 10 , coob = T)
?bagging

names(bagtree)

bagtree$err
### predictions from bagging model
bagpred = predict(bagtree, test )

## performance of bag tree 

table( test$Churn, bagpred)

 ### cross validation + Random forest + Grid search

## use caret package 

library(caret)
library(randomForest)
library(mlbench)
control = trainControl(method="repeatedcv", number=5, search = "grid") 
set.seed(1238)
tunegrid = expand.grid(.mtry=c(4:9))
rf_gridsearch = train(Churn~., data=train, method="rf", metric="Accuracy", tuneGrid=tunegrid, trControl=control)
print(rf_gridsearch)
plot(rf_gridsearch)
rf_gridsearch$results

names(rf_gridsearch)
## performance of the model by caret RF
pred_rs = predict(rf_gridsearch, test)

table(test$Churn, pred_rs)


