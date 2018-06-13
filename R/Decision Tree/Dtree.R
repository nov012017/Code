setwd("C:\\Users\\KASTU1\\Desktop\\Analytics Path\\R\\Data")


df1 = read.csv("Teleco_Cust_Attr_1.csv")
table(df1$Churn)

head(df1)x``

names(df1)

df1 = df1[,-c(19:21)]

df1$Churn = ifelse(df1$Churn == 1, "Yes", "No")

table(df1$Churn)

prop.table(table(df1$Churn))



set.seed(1234)

ids = sample(nrow(df1), nrow(df1)*0.8)

train = df1[ids,]
test = df1[-ids,]

### cart model 
library(rpart)
churntree = rpart( Churn ~ ., data=train, method="class")
churntree$terms

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

## train error is 0.046 
## test error is 0.067


precision = 67/78
recall = 67/(67+32)

f_1 = 2*precision*recall/(precision+recall)

### CP matrix to check the cp and relative error 
printcp(churntree)


### Pruning a tree 

prunedtree = prune(churntree, cp = 0.013021)

fancyRpartPlot(prunedtree)

printcp(prunedtree)


## performance of pruned tree 


test$pruned_pred = predict(prunedtree, newdata = test, type="class")


table(test$Churn, test$pruned_pred)
### randomforest 

head(train)

## ensemble techniques ## using re sampling methods
library(randomForest)

rftrees = randomForest(as.factor(Churn) ~ ., data=train ) #, ntree = 30, mtry = 6, classwt = c( 0.7, 0.3))
test$pred_rf = predict(rftrees, newdata = test )


table(test$Churn, test$pred_rf)
precision = 66/75
recall = 66/(99)

2*precision*recall/(precision+recall)

names(rftrees)
## number of trees by defult picked by randomforest 

rftrees$ntree

?randomForest
### parameter tuning of randomforest 

rftree2 = randomForest(as.factor(Churn) ~ ., data=train, ntree=40, mtry=5, classwt = c(0.7, 0.3), nodesize = 20  )

pred = predict(rftree2, newdata = test)

## confusion matrix 

table(test$Churn, pred)

precision = 75/90
recall = 75/(99)

2*precision*recall/(precision+recall)

names(rftrees)

importance(rftrees, decreasing = T)

varImpPlot(rftrees)
  