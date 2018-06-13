data1 = read.csv("D:\\Data Science\\Machine Learning\\titanic3.csv")
names(data1)
colsToUse = c('pclass','survived','sex','age','fare','sibsp','parch','embarked')
data1 = data1[,colsToUse]
View(data1)

str(data1)

data1$pclass = as.factor(data1$pclass)
data1$sex = as.factor(data1$sex)
data1$survived = as.factor(data1$survived)

summary(data1)

#### Handling Sibsp and Parch

table(data1$sibsp)
table(data1$parch)

data1$sibsp_cat = ifelse(data1$sibsp > 2,'>2',data1$sibsp)
data1$sibsp_cat = as.factor(data1$sibsp_cat)


data1$parch_cat = ifelse(data1$parch > 1,'>1',data1$parch)
data1$parch_cat = as.factor(data1$parch_cat)

### Dropping sibsp and parch
data1$sibsp = NULL
data1$parch = NULL


#### Handling anomalies in Embarked

data1$embarked = as.character(data1$embarked)
data1$embarked[data1$embarked == ""] = NA
data1$embarked = as.factor(data1$embarked)

summary(data1)


### Handling Missing values
median(data1$fare,na.rm = T)
data1$fare[is.na(data1$fare)] = median(data1$fare,na.rm = T)

median(data1$age,na.rm = T)
data1$age[is.na(data1$age)] = median(data1$age,na.rm = T)

data1 = na.omit(data1)

##### train test split
rows = 1:nrow(data1)
trainRows = sample(rows,round(0.7*nrow(data1)))

trainData = data1[trainRows,]
testData = data1[-trainRows,]


#### Model building
logreg = glm(survived~.-embarked-fare-parch_cat,
             data=trainData,family=binomial(link = "logit"))


summary(logreg)

preds = predict(logreg,testData,type = 'response')
preds_01 = ifelse(preds > 0.5,1,0)

table(testData$survived,preds_01,dnn=c('Actuals','Preds'))


library(ROCR)

### add the ROC graph of credit_model1 on the same plot 
pred = prediction(preds , testData$survived)
perf= performance(pred, "tpr","fpr")
plot(perf,colorize = T)

### AUC for churn model 
AUC_1 = performance(pred, measure = 'auc')@y.values[[1]]
AUC_1
