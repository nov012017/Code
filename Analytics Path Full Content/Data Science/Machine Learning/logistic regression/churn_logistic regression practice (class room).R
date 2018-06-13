setwd("D:\\Data Science\\Machine Learning")
df = read.csv("Churn.csv")
View(df)
head(df)

### Check Class imbalance 

table( df$Churn) ## freq table 

prop.table(table( df$Churn) )

### ignore the variable state, areacode and phone.num 
names(df)

df = df[ , -c( 19:21)]

### find out variables that are higly correlated 

View(cor(df))


#### EDA to select the most important variables 
str(df)

df$Churn = as.factor( df$Churn)

#### relationship b/w Churn and Day.charges 
library(ggplot2)
ggplot( df, aes( Churn, Day.Charge)) + geom_boxplot()

ggplot( df, aes( Churn, Eve.Charge)) + geom_boxplot()

ggplot( df, aes( Churn, Night.Charge)) + geom_boxplot()

### cor of day charges with night and evening 

plot(df$Day.Charge, df$Day.Mins)
plot( df$Eve.Charge, df$Eve.Mins)

cor(df$Day.Charge, df$Day.Mins)
cor( df$Eve.Charge, df$Night.Charge)

### explore with factor variables 

plot(df$Churn,df$VMail.Plan)
ggplot( df, aes(VMail.Plan, fill = Churn )) + geom_bar(position = "fill")

ggplot( df, aes( Intl.Plan, fill = Churn)) + geom_bar(position = "fill")

### convert Vmailplan and Intl.plan to factor variables 

df$VMail.Plan = as.factor(df$VMail.Plan)
df$Intl.Plan = as.factor(df$Intl.Plan)

table(df$VMail.Plan)

prop.table(table(df$VMail.Plan))

## divide the dataset into training and test set 

set.seed( 1234)

ids = sample( nrow(df), nrow(df)*0.8)

train = df[ ids,]
test =  df[-ids,]


#### build logistic regression model using glm 

churn_model = glm( Churn ~ Account.Length + VMail.Plan + Intl.Plan+
                     CustServ.Calls + Day.Charge + Eve.Charge, 
                   data = train, 
                   family="binomial")


churn_model2 = glm( Churn ~  VMail.Plan + Intl.Plan+
                     CustServ.Calls + Day.Charge + Eve.Charge + Night.Mins, 
                   data = train, 
                   family="binomial")
summary(churn_model)
summary(churn_model2)

colnames(train)

### Predict the test observations 

test$pred = predict( churn_model , newdata = test, type="response")

test$pred2 = predict( churn_model2 , newdata = test, type="response")
##test$pred_class = predict(churn_model , newdata = test, type="link")

test$pred_class = ifelse( test$pred >= 0.5, 1 , 0)

test$pred_class2 = ifelse( test$pred2 >= 0.5, 1 , 0)
### confusion matrix 
table(test$pred_class, test$Churn )
table(test$pred_class2, test$Churn )
568/667
## ROC graphs 

library(ROCR)

### add the ROC graph of credit_model1 on the same plot 
pred = prediction(test$pred , test$Churn)
pred2 = prediction(test$pred2 , test$Churn)
perf= performance(pred, "tpr","fpr")
perf2= performance(pred2, "tpr","fpr")
plot(perf)
plot(perf2, add = T, colorize = T)
### AUC for churn model 

AUC_1 = performance(pred, measure = 'auc')@y.values[[1]]
AUC_1

AUC_2 = performance(pred2, measure = 'auc')@y.values[[1]]
AUC_2


### The model performance is not good 
## improve the model performance 

### precison vs Recall curve 

library("DMwR")

PRcurve(test$pred, test$Churn)




### change the cutoff 

test$pred_class2 = ifelse( test$pred >=0.3, 1, 0)

table( test$pred_class2, test$Churn)
64/(64+35)
 64/(64+99)
 
 (510+40)/667
 
 ### add few more variables to imporve the model performance 
 names(df)
 churn_model2 = glm(Churn ~  VMail.Message + Intl.Charge+
                  CustServ.Calls + Night.Charge + Day.Charge + Eve.Charge, 
                data =train, 
                family = "binomial")
 summary(churn_model)
 summary(churn_model2)
 
 ### predict using model2 
 
 test$pred2 = predict( churn_model2, newdata = test, type = "response")

 test$pred2 = ifelse( test$pred2 > 0.5, 1 , 0) 
 
 ## confusion matrix 
 
 table( test$pred2, test$Churn)
 
 
 ### lets try to balance the training datset 
 
 train_1 = train[ train$Churn == 1,]
 train_0 = train[ train$Churn == 0,]
 
 ## select a random sample of 1000 obs from 0 
 
 ids_0 = sample( nrow(train_0), nrow(train_0) * 0.4)
 
 train_0_samp = train_0[ ids_0, ]
 
 train1 = rbind( train_0_samp, train_1)
 
 prop.table( table( train1$Churn))
 
 ### retrain the model with train1 
 
 
 churn_model_1 = glm( Churn ~ Account.Length + VMail.Plan + Intl.Plan+
                      CustServ.Calls + Day.Charge + Eve.Charge, 
                    data = train1, 

                      family="binomial")
 
 #### predcict the test 
 

  test$pred_s = predict( churn_model_1, newdata = test, type="response")
 
  test$pred_s_class = ifelse( test$pred_s > 0.5, 1, 0)
  
  table( test$pred_s_class, test$Churn)
  
  41/(41+61)
  
  41/(41+58)
  ### add the ROC graph of credit_model1 on the same plot 
  pred = prediction(test$pred_s , test$Churn)
  perf= performance(pred, "tpr","fpr")
  plot(perf)
  
  ### AUC for churn model 
  
  AUC_1 = performance(pred, measure = 'auc')@y.values[[1]]
  AUC_1
  
  
  ### precison vs Recall curve 
  
  library("DMwR")
  
  PRcurve(test$pred, test$Churn)
  
  
  #### variable selection by fwd, bwd approaches 
  
  model = glm( Churn ~ ., data = train, family="binomial")
  
  model_a = step(model, method="forward")
  
  ### preformance of forward selection model 
  
  test$pred_fwd = predict( model_a, newdata = test, type="response")

  test$pred_fwd_class = ifelse( test$pred_fwd >= 0.5, 1, 0)  
  
  table( test$Churn, test$pred_fwd_class)
  
  
  ### backward selection method 
  
  model_b = step( model, method="backward")

  #### hybrid selection 
  
  model_h = step(model, method="both")
  