setwd("D:\\Data science  notes")
wine = read.csv("winequality-red.csv")
str(wine)
View(wine)

head(wine)
#To check quality of wine
wine$good_wine<-ifelse(wine$quality>6,1,0)

summary(wine)
#To check class imbalance
table(wine$good_wine)
#probability table
prop.table(table(wine$good_wine))
#to explore the data
plot(wine)


#Libraries needed
library(ggplot2)
library(ggthemes)
library(corrplot)
library(reshape2)
library(dplyr)

#correlation plot
corrplot(cor(wine))
#
View(cor(wine))
#here alcohol has highest correlation with quality of wine
#find missing values of wine.
sum(is.na(wine))
names(wine)
ggplot(wine,aes(good_wine,quality))+geom_boxplot()

#Distribution of wine quality ratings
ggplot(wine,aes(x=quality))+geom_bar(stat = "count",position = "dodge")+
  scale_x_continuous(breaks = seq(3,8,1))+
  ggtitle("Distribution of Red Wine Quality Ratings")+
  theme_few()

#Distribution of good/bad wines
ggplot(wine,aes(x=good_wine,fill=factor(good_wine)))+geom_bar(stat = "count",position = "dodge")+
  scale_x_continuous(breaks = seq(0,1,1))+
  ggtitle("Distribution of Good/Bad Wines")+
  theme_few()

##split the data into train and test

set.seed(178)
#nrow(wine)
ids = sample( nrow(wine), nrow(wine)*0.7)

train = wine[ ids,]
test =  wine[-ids,]


# build logistic regression model using glm 

logreg=glm(good_wine~.-quality-pH-citric.acid,data=train,family = binomial(link='logit'))
summary(logreg)


preds = predict(logreg,test,type = 'response')
preds_01 = ifelse(preds > 0.6,1,0)


table(test$good_wine,preds_01,dnn=c('Actuals','Preds'))
#Accuracy
#(397+19)/(397+19+47+17)
#0.866 for 0.5 and 0.88 for 0.6
#precision
#19/(19+17)  #0.52
#recall
#19/(19+47)#0.28
### add the ROC graph on the same plot 
library(ROCR)
pred = prediction(preds , test$good_wine)
perf= performance(pred, "tpr","fpr")
plot(perf,colorize = T)

### AUC for model 

AUC_1 = performance(pred, measure = 'auc')@y.values[[1]]
AUC_1
