setwd("D:\\Data science  notes\\Data To Be Shared Before Class\\MLR")
dataset=read.csv("50_Startups.csv")
View(dataset)
names(dataset)
str(dataset)

#R automatically converts categorical into factors
dataset$State=factor(dataset$State,
                     levels = c('New York','California','Florida'),
                     labels=c(1,2,3))

##Split the data
set.seed(123)
library(caTools)
split=sample.split(dataset$Profit,SplitRatio = 0.8)
training_set=subset(dataset,split==TRUE)
test_set=subset(dataset,split==FALSE)

##model
regressor=lm(Profit~.,data=training_set)
#predicting the test_set results
y_pred=predict(regressor,newdata = test_set)
y_pred

summary(regressor)
##backward elimination
#remove state=2
##model2
regressor=lm(Profit~.-State,data=training_set)
summary(regressor)

##model3
regressor=lm(Profit~.-State-Administration,data=training_set)
summary(regressor)


##model3
regressor=lm(Profit~.-State-Administration-Marketing.Spend,data=training_set)
summary(regressor)
#multicollianarity
table(dataset$State)

