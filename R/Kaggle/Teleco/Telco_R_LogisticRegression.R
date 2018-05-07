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
  
  data$Dependents=NULL
  data$MultipleLines=NULL
  data$StreamingMovies=NULL
  data$DeviceProtection=NULL
  data$SeniorCitizen=NULL
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
telco_train$Predicted_model1_pred = ifelse(telco_train$Predicted_model1 > 0.5,1,0)
CM_Model1_Train=table(telco_train$Churn,telco_train$Predicted_model1_pred)

TN=CM_Model1_Train[1]
FN=CM_Model1_Train[2]
FP=CM_Model1_Train[3]
TP=CM_Model1_Train[4]

Precision_Train=(TP)/(TP+FP)
cat("Accuracy_Train: ",Accuracy_Train=(TN+TP)/(TN+FN+FP+TP))
cat("Precision_Train: ",Precision_Train=(TP)/(TP+FP))
cat("Recall_Train: ",Recall_Train=(TP)/(TP+FN))
cat("F1Score_Train: ",F1Score_Train=2*(Precision_Train*Recall_Train)/(Precision_Train+Recall_Train))

Predicted_model1 <- predict(model1,telco_test,type="response")
telco_test$Predicted_model1=Predicted_model1
telco_test$Predicted_model1_pred = ifelse(telco_test$Predicted_model1 > 0.5,1,0)
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

ggplot(telco,aes(Churn,fill=MonthlyCharges_der))+geom_bar()
chisq.test(telco$MonthlyCharges_der,telco$Churn)

ggplot(telco,aes(telco$TotalCharges,telco$MonthlyCharges, color=Churn))+geom_point()

ggplot(telco,aes(telco$tenure,telco$MonthlyCharges, color=Churn))+geom_point()
