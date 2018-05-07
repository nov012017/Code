setwd("C:\\Users\\Prudhvi\\Desktop\\Prudhvi\\Data Science\\Data")
telco=read.csv("Teleco_Cust_Attr.csv")
head(telco)

#telco$customerID=NULL

preprocess <- function(data) {
  print(nrow(data))
  print(ncol(data))
## Deleting the unique columns
  data$customerID=NULL
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
  
  return(data)
}

telco<-preprocess(telco)





