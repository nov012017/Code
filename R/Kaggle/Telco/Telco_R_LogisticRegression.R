setwd("C:\\Users\\KASTU1\\Desktop\\Analytics Path\\R\\Data")
options(scipen = 999)
#setwd("C:\\Users\\Prudhvi\\Desktop\\Prudhvi\\Data Science\\Data")
telco=read.csv("Teleco_Cust_Attr.csv")

preprocess <- function(data) {
  print(nrow(data))
  print(ncol(data))
  ## Deleting the unique columns
  data$customerID=NULL
  ## Gender does not have much variance with churn variable
  data$gender=NULL
  ## Phone Service is independent of chrun data and we can't find much variance in the data
  telco$PhoneService=NULL
  ## We should not take decision by comparing old and new customers and hence droping total charges
  data$TotalCharges=NULL
  data$tenure=NULL
  data$OnlineSecurity=NULL
  data$Dependents=NULL
  data$MultipleLines=NULL
  data$StreamingMovies=NULL
  data$DeviceProtection=NULL
  data$SeniorCitizen=as.factor(data$SeniorCitizen)
  #data$SeniorCitizen=NULL
  data$PaymentMethod=NULL
  ### Replacing
  ## data_preprop1=data.frame(data[,c("TechSupport","StreamingTV","DeviceProtection","OnlineBackup","OnlineSecurity")])
  for (col in colnames(data)){
    if (is.factor(data[,col])=="TRUE"){
      data[,col]=as.character(data[,col])
      for (row in 1:nrow(data)) {
        replace_text <- data[row, col]
        if(replace_text=="No internet service"){
          data[row, col]="No"
        }
        if(replace_text=="No phone service"){
          data[row, col]="No"
        }
      }
      data[,col]=as.factor(data[,col])
    }
  }
  ####################################End of For Loop###########################################
  ## Monthly charges binning into 4 bins low, medium, high, very high
  for(i in 1:nrow(telco)){
    if(telco[i,"MonthlyCharges"]<=25){
      telco$MonthlyCharges_der[i]="Low"
    }else if (telco[i,"MonthlyCharges"]>25 & telco[i,"MonthlyCharges"]<=50){
      telco$MonthlyCharges_der[i]="Medium"
    }else if (telco[i,"MonthlyCharges"]>50 & telco[i,"MonthlyCharges"]<=75){
      telco$MonthlyCharges_der[i]="High"
    } else {
      telco$MonthlyCharges_der[i]="Very High"
    }
  }
  
  return(data)
}

telco <- preprocess(telco)

#######  Sampling #########
set.seed(123)
rows= 1:nrow(telco)
trainRows = sample(rows,round(0.7*nrow(telco)))
testrows<-rows[-trainRows]
telco_train<-telco[trainRows,]
telco_test<-telco[testrows,]
###################################################



##### Applying model

model1=glm(Churn~.-MonthlyCharges,data=telco_train,family = binomial(link = "logit"))
summary(model1)
Predicted_model1 <- predict(model1,telco_train,type="response")
telco_train$Predicted_model1=Predicted_model1
telco_train$Predicted_model1_pred = ifelse(telco_train$Predicted_model1 > 0.45,1,0)
CM_Model1_Train=table(telco_train$Churn,telco_train$Predicted_model1_pred)

TN=CM_Model1_Train[1]
FN=CM_Model1_Train[2]
FP=CM_Model1_Train[3]
TP=CM_Model1_Train[4]

Precision_Train=(TP)/(TP+FP)
Recall_Train=(TP)/(TP+FN)
cat("Accuracy_Train: ",Accuracy_Train=(TN+TP)/(TN+FN+FP+TP))
cat("Precision_Train: ",Precision_Train=(TP)/(TP+FP))
cat("Recall_Train: ",Recall_Train=(TP)/(TP+FN))
cat("F1Score_Train: ",F1Score_Train=2*(Precision_Train*Recall_Train)/(Precision_Train+Recall_Train))

library(ROCR)
pred <- prediction(Predicted_model1,telco_train)
perf <- performance(pred,"tpr","fpr")

Predicted_model1 <- predict(model1,telco_test,type="response")
telco_test$Predicted_model1=Predicted_model1
telco_test$Predicted_model1_pred = ifelse(telco_test$Predicted_model1 > 0.45,1,0)
CM_Model1_Test=table(telco_test$Churn,telco_test$Predicted_model1_pred)

TN=CM_Model1_Test[1]
FN=CM_Model1_Test[2]
FP=CM_Model1_Test[3]
TP=CM_Model1_Test[4]

cat("Accuracy_Test: ",Accuracy_Test=(TN+TP)/(TN+FN+FP+TP))
cat("Precision_Test: ",Precision_Test=(TP)/(TP+FP))
cat("Recall_Test: ",Recall_Test=(TP)/(TP+FN))
#cat("F1Score_Test: ",F1Score=2*(Precision_Test*Recall_Test)/(Precision_Test+Recall_Test))
#cat("F1Score_Train: ",F1Score_Test=2*(Precision_Test*Recall_Test)/(Precision_Test+Recall_Test))

library(ggplot2)

ggplot(telco,aes(MonthlyCharges))+geom_histogram()
ggplot(telco,aes(Churn,fill=gender))+geom_bar()
chisq.test(telco$gender,telco$Churn)

#telco$gender=NULL
ggplot(telco,aes(Churn,fill=Partner))+geom_bar()

## Partner
chisq.test(telco$Partner,telco$Churn)
#h0= independent
#ha = dependent # 0.00000000000000022
table(telco$Partner,telco$Churn)
prop.table(table(telco$Partner,telco$Churn))

ggplot(telco,aes(Churn,fill=Dependents))+geom_bar()
chisq.test(telco$Dependents,telco$Churn)

ggplot(telco,aes(Churn,fill=PhoneService))+geom_bar()
prop.table(table(telco$Churn,telco$PhoneService))
chisq.test(telco$PhoneService,telco$Churn)

ggplot(telco,aes(Churn,fill=MultipleLines))+geom_bar()
chisq.test(telco$MultipleLines,telco$Churn)

ggplot(telco,aes(Churn,fill=InternetService))+geom_bar()
chisq.test(telco$InternetService,telco$Churn)

ggplot(telco,aes(Churn,fill=OnlineSecurity))+geom_bar()
chisq.test(telco$OnlineSecurity,telco$Churn)

ggplot(telco,aes(Churn,fill=OnlineBackup))+geom_bar()
chisq.test(telco$OnlineBackup,telco$Churn)

ggplot(telco,aes(OnlineSecurity,fill=OnlineBackup))+geom_bar()
chisq.test(telco$OnlineBackup,telco$OnlineSecurity)

ggplot(telco,aes(Churn,fill=DeviceProtection))+geom_bar()
chisq.test(telco$DeviceProtection,telco$Churn)



ggplot(telco,aes(Churn,fill=TechSupport))+geom_bar()
chisq.test(telco$TechSupport,telco$Churn)

ggplot(telco,aes(Churn,fill=StreamingTV))+geom_bar()
chisq.test(telco$StreamingTV,telco$Churn)

ggplot(telco,aes(Churn,fill=StreamingMovies))+geom_bar()
chisq.test(telco$StreamingMovies,telco$Churn)

ggplot(telco,aes(Churn,fill=Contract))+geom_bar()
chisq.test(telco$StreamingMovies,telco$Churn)

ggplot(telco,aes(Churn,fill=PaperlessBilling))+geom_bar()
chisq.test(telco$PaperlessBilling,telco$Churn)

ggplot(telco,aes(Churn,fill=PaymentMethod))+geom_bar()
chisq.test(telco$PaymentMethod,telco$Churn)

telco$SeniorCitizen=as.factor(telco$SeniorCitizen)
ggplot(telco,aes(Churn,fill=SeniorCitizen))+geom_bar()
chisq.test(telco$SeniorCitizen,telco$Churn)


ggplot(telco,aes(Churn,fill=MonthlyCharges_der))+geom_bar()
chisq.test(telco$MonthlyCharges_der,telco$Churn)

ggplot(telco,aes(telco$TotalCharges,telco$MonthlyCharges, color=Churn))+geom_point()

ggplot(telco,aes(telco$tenure,telco$MonthlyCharges, color=Churn))+geom_point()

################################ Second Model ###################################


#setwd("C:\\Users\\KASTU1\\Desktop\\Analytics Path\\R\\Data")
setwd("C:\\Users\\Prudhvi\\Desktop\\Prudhvi\\Data Science\\Data")
options(scipen = 999)
#setwd("C:\\Users\\Prudhvi\\Desktop\\Prudhvi\\Data Science\\Data")
telco=read.csv("Teleco_Cust_Attr.csv")



preprocess<-function(data){
  data$customerID=NULL
  data$gender=NULL
  data$SeniorCitizen=as.factor(data$SeniorCitizen)
  data$PhoneService=NULL
  data$TotalCharges=NULL
    for (i in 1:nrow(data)){
      data$Charges[i]=data$tenure[i]/data$MonthlyCharges[i]
    }
    for (i in 1:nrow(data)){
      data$Charges_log[i]=log(data$Charges[i])
    }
  data$tenure=NULL
  data$MonthlyCharges=NULL
  data$StreamingTV=NULL
  #data$OnlineSecurity=NULL
  data$DeviceProtection=NULL
  data$PaymentMethod=NULL
  data$MultipleLines=NULL
  data$Dependents=NULL
  data$Partner=NULL
  
  for (col in colnames(data)){
    if (is.factor(data[,col])=="TRUE"){
      data[,col]=as.character(data[,col])
      for (row in 1:nrow(data)) {
        replace_text <- data[row, col]
        if(replace_text=="No internet service"){
          data[row, col]="No"
        }
        if(replace_text=="No phone service"){
          data[row, col]="No"
        }
      }
      data[,col]=as.factor(data[,col])
    }
  }
  
  return(data)
}

#######  Sampling #########
set.seed(123)
rows= 1:nrow(telco)
trainRows = sample(rows,round(0.7*nrow(telco)))
testrows<-rows[-trainRows]
telco_train<-telco[trainRows,]
telco_test<-telco[testrows,]
###################################################

telco_train=preprocess(telco_train)
telco_test=preprocess(telco_test)

hist(telco_train$Charges_log)
min(telco_train$Charges_log)

### Model

model1=glm(Churn~.-Churn-Charges,data=telco_train,family = binomial(link = "logit"))
summary(model1)
Predicted_model1 <- predict(model1,telco_train,type="response")
telco_train$Predicted_model1=Predicted_model1
telco_train$Predicted_model1_pred = ifelse(telco_train$Predicted_model1 > 0.44,1,0)
CM_Model1_Train=table(telco_train$Churn,telco_train$Predicted_model1_pred)

TN=CM_Model1_Train[1]
FN=CM_Model1_Train[2]
FP=CM_Model1_Train[3]
TP=CM_Model1_Train[4]

Precision_Train=(TP)/(TP+FP)
Recall_Train=(TP)/(TP+FN)
cat("Accuracy_Train: ",Accuracy_Train=(TN+TP)/(TN+FN+FP+TP))
cat("Precision_Train: ",Precision_Train=(TP)/(TP+FP))
cat("Recall_Train: ",Recall_Train=(TP)/(TP+FN))
cat("F1Score_Train: ",F1Score_Train=2*(Precision_Train*Recall_Train)/(Precision_Train+Recall_Train))

### EDA
min(telco$tenure)
min(telco$MonthlyCharges)


library(ggplot2)
### Gender (No Variance)
  ggplot(telco_train,aes(Churn,fill=gender))+geom_bar(position = "dodge")
  chisq.test(telco_train$Churn,telco_train$gender) ## p-value = 0.3563
  # Conclusion: Two classes cannot explain the output variable. There is no much variance. Droping the Gender Column
###
### Partner (Variance)
  ggplot(telco_train,aes(Churn,fill=Partner))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$Partner) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### Dependents (Variance)
  ggplot(telco_train,aes(Churn,fill=Dependents))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$Dependents) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### PhoneService (How?) (No Variance)
  ggplot(telco_train,aes(Churn,fill=PhoneService))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$PhoneService) ## p-value = 0.1786
  table(telco_train$Churn,telco_train$PhoneService)
  prop.table(table(telco_train$Churn,telco_train$PhoneService))
  # Conclusion: Most of the people has phone service. In this only one class (Yes) is explaining the targert 
                #variable and other (NO (<10%)) is not explaining much, hence dropping this variable
### 
### MultipleLines (Partial vairance)
  ggplot(telco_train,aes(Churn,fill=MultipleLines))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$MultipleLines) ## p-value = 0.0114
  # Conclusion: This variable is explaining the output variable with a little variance. 
                #Hence considering this to be a part of the model for time being.
###
### InternetService (Variance)
  ggplot(telco_train,aes(Churn,fill=InternetService))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$InternetService) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### OnlineSecurity (Variance)
  ggplot(telco_train,aes(Churn,fill=OnlineSecurity))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$OnlineSecurity) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### OnlineBackup (Variance)
  ggplot(telco_train,aes(Churn,fill=OnlineBackup))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$OnlineBackup) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### DeviceProtection (Variance)
  ggplot(telco_train,aes(Churn,fill=DeviceProtection))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$DeviceProtection) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### TechSupport (Variance)
  ggplot(telco_train,aes(Churn,fill=TechSupport))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$TechSupport) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### StreamingTV (Variance)
  ggplot(telco_train,aes(Churn,fill=StreamingTV))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$StreamingTV) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### StreamingMovies (Variance)
  ggplot(telco_train,aes(Churn,fill=StreamingMovies))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$StreamingMovies) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###
### Contract (Variance)
  ggplot(telco_train,aes(Churn,fill=Contract))+geom_bar(position = c("dodge"))
  chisq.test(telco_train$Churn,telco_train$Contract) ## p-value = 0.00000000000000022
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###

### MonthlyCharges
  ggplot(telco_train,aes(Churn,MonthlyCharges))+geom_boxplot()
###
### Tenure  
  ggplot(telco_train,aes(Churn,tenure))+geom_boxplot()
###
### SeniorCitizen
  telco_train$SeniorCitizen=as.factor(telco_train$SeniorCitizen)
  ggplot(telco_train,aes(Churn,fill=SeniorCitizen))+geom_bar(position = c("dodge"))
  # Conclusion: This variable is explaining the output variable. Hence considering this to be a part of the model.
###