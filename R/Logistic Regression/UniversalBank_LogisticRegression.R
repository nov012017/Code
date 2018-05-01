getwd()
total=read.csv(file = "UniversalBank.csv", header = T, sep = ",")

# Pre processing the output variable
class(total$Personal.Loan)
total$Personal.Loan=as.factor(total$Personal.Loan)
library(ggplot2)
ggplot(total, aes(Personal.Loan))+geom_bar()
barplot(total$Personal.Loan)
str(total)

sum(is.na(total))

## Consider column Age
hist(total$Age)

## Consider Experience ---- No need to use Experience as there is 0.9 correlation with age
hist(total$Experience)

cor(total$Experience,total$Age)

## Consider Income lable
hist(sqrt(total$Income))
total$Income=sqrt(total$Income)
cor(total$Income,total$Age)

## Consider Zip Code variable
class(total$ZIP.Code)
unique(total$ZIP.Code)
total$ZIP.Code=as.factor(total$ZIP.Code)

str(total)

## Consider Family
class(total$Family)
unique(total$Family)
total$Family=as.factor(total$Family)

## Condider CCAvg
class(total$CCAvg)
unique(total$CCAvg)
cor(total$Income,total$CCAvg)

## Consider Eduction
total$Education=as.factor(total$Education)

# Consider Mortage
unique(total$Mortgage)
total$Mortgage=as.factor(total$Mortgage)

# Consider securities account
class(total$Securities.Account)
unique(total$Securities.Account)
total$Securities.Account=as.factor(total$Securities.Account)

## Consider online variable
class(total$Online)
unique(total$Online)
total$Online=as.factor(total$Online)

## Consider Credit card
class(total$CreditCard)
unique(total$CreditCard)
total$CreditCard=as.factor(total$CreditCard)

## Delete column
total$ID=NULL
total$ZIP.Code=NULL
total$Mortgage=NULL


## Sampling
rows= 1:nrow(total)
trainRows = sample(rows,round(0.7*nrow(total)))
testrows<-rows[-trainRows]
traindata<-total[trainRows,]
testdata<-total[testrows,]

#model
ub_model=glm(Personal.Loan ~ .-Experience-Personal.Loan-Age,data=traindata,family = binomial(link = "logit"))
summary(ub_model)

## Predictions
preds = predict(ub_model,testdata, type='response')
testdata$preds = preds

##Metrics
testdata$preds2 = ifelse(testdata$preds > 0.5,1,0)
table(testdata$Personal.Loan,testdata$preds2,dnn=c('actuals','preds'))

TN=table(testdata$Personal.Loan,testdata$preds2,dnn=c('actuals','preds'))[1]
FN=table(testdata$Personal.Loan,testdata$preds2,dnn=c('actuals','preds'))[2]
FP=table(testdata$Personal.Loan,testdata$preds2,dnn=c('actuals','preds'))[1,2]
TP=table(testdata$Personal.Loan,testdata$preds2,dnn=c('actuals','preds'))[2,2]

Recall=TP/(TP+FN)
Precision=TP/(FP+TP)

Recall
Precision
install.packages("ROCR")
library(ROCR)
pred <- prediction(ub_model,testdata)
perf <- performance(pred,"tpr","fpr")
