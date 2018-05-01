library(ggplot2)
install.packages("ggplot2")

### 
home_est=read.csv("house_pricing_kaggle.csv", head = T, sep = ",")
master=home_est
MASTER

### Handling target variable
home_est$sp=log(home_est$SalePrice)
UW=qnorm(0.75,mean(home_est$sp),sd(home_est$sp))+(1.5*IQR(home_est$sp))
LW=qnorm(0.25,mean(home_est$sp),sd(home_est$sp))-(1.5*IQR(home_est$sp))
home_est[home_est$sp>UW,]=quantile(home_est$sp,probs = c(0.95))
home_est[home_est$sp<LW,]=quantile(home_est$sp,probs = c(0.05))
test=quantile(home_est$sp,probs = c(0.95))

master$sp=log(master$SalePrice)
UW=qnorm(0.75,mean(master$sp),sd(master$sp))+(1.5*IQR(master$sp))
LW=qnorm(0.25,mean(master$sp),sd(master$sp))-(1.5*IQR(master$sp))
master[master$sp>UW,]=quantile(master$sp,probs = c(0.95))
master[master$sp<LW,]=quantile(master$sp,probs = c(0.05))

### Working on character of factor columns
### Working with Unique value columns
### ID contains unique values and Hence removing the column
home_est$Id=NULL

## Converting few column to factors as per the business knowledge
## Converting MSSubclass to Factor
home_est$MSSubClass=as.factor(home_est$MSSubClass)
home_est$GarageCars=as.factor(home_est$GarageCars)

## Checking for the significance of Factor variable with the output variable and removing if the significance level is greater than 0.05
## Used anova
## HO= All the variables means are same
## HA = All the variables means are not same


for (col in colnames(home_est)){
  if (is.factor(home_est[,col])=="TRUE"){
    a=summary(aov(home_est$SalePrice~home_est[,col]))
    b=a[[1]][5]
    c=round(b[[1]][1],10)
    if(c>0.05){
      home_est[,col]=NULL
      cat("Deleted :",col,", which as a significance level ",c,"\n")
    }
  }
}

ggplot(home_est,aes(Street,SalePrice))+geom_boxplot()
table(home_est$Street)
ggplot(master,aes(Utilities,SalePrice))+geom_boxplot()
ggplot(master,aes(LandSlope,SalePrice))+geom_boxplot()
ggplot(master,aes(PoolQC,SalePrice))+geom_boxplot()
ggplot(master,aes(MiscFeature,SalePrice))+geom_boxplot()

master$Street=factor(master$Street,levels = c('Grvl','Pave'))

feqStreet=table(master$Street)

tapply(home_est$SalePrice,home_est$Street,median)
a=aov(master$SalePrice~master$Street)
model.tables(a,"means")
TukeyHSD(a)
summary(a)

a=aov(master$SalePrice~master$Street+master$MSSubClass+master$Street:master$MSSubClass)
model.tables(a,"means")
TukeyHSD(a)
summary(a)
  ## Total 5 columns had deleted using the above code

## Checking the significance of Integer variables with the output
for(col in colnames(home_est)){
  if (is.integer(home_est[,col])=="TRUE"){
    a=cor(home_est[is.na(home_est[,col])==0,"SalePrice"],home_est[is.na(home_est[,col])==0,col])
    cat(col,":",a,"\n")
    if ((a > -0.55 & a<0) | (a>0 & a <0.55 )){
      home_est[,col]=NULL
      cat("Deleted :",col,", which has a significance level ",a,"\n")
    }
  }
}

## Total 28 columns are deleted using the above code
#install.packages("dplyr")
library("dplyr")
int_col=names(select_if(home_est, is.numeric))
cor(home_est[,int_col])

## TotalBsmtSF is linear to X1stFlrSF
## GrLivArea is linear to FullBath
## GarageCars is linear to GarageArea

home_est$X1stFlrSF=NULL
home_est$FullBath=NULL
home_est$GarageArea=NULL

## Chi square test
## H0= Both the categorical values are independent
## HA = BOth the categorical values are dependent
options(scipen = 999)
chisq.test(home_est$MSSubClass,home_est$MSZoning) ## HA
home_est$MSSubClass = NULL
chisq.test(home_est$Alley,home_est$MSZoning) ## HA
home_est$Alley = NULL
chisq.test(home_est$LotShape,home_est$MSZoning) ## HA
home_est$LotShape = NULL
chisq.test(home_est$Condition1,home_est$Condition2) # HA
home_est$Condition1 = NULL
chisq.test(home_est$Condition1,home_est$MSZoning) # HA
home_est$Condition2 = NULL
chisq.test(home_est$BldgType,home_est$MSZoning) # HA
home_est$BldgType = NULL
chisq.test(home_est$HouseStyle,home_est$MSZoning) # HA
home_est$HouseStyle = NULL
chisq.test(home_est$RoofStyle,home_est$MSZoning) # HA
home_est$RoofStyle = NULL
chisq.test(home_est$RoofMatl,home_est$MSZoning) # HO
chisq.test(home_est$Exterior1st,home_est$Exterior2nd) #HA
home_est$Exterior1st = NULL
chisq.test(home_est$Exterior2nd,home_est$MSZoning) #HA
home_est$Exterior2nd = NULL
chisq.test(home_est$MasVnrType,home_est$MSZoning) #HA
home_est$MasVnrType = NULL
chisq.test(home_est$ExterQual,home_est$ExterCond) #HA
home_est$ExterQual = NULL
chisq.test(home_est$ExterCond,home_est$MSZoning) #HA
home_est$ExterCond = NULL
chisq.test(home_est$Foundation,home_est$MSZoning) #HA
home_est$Foundation = NULL
chisq.test(home_est$BsmtQual,home_est$BsmtCond) #HA
home_est$BsmtQual = NULL
chisq.test(home_est$BsmtExposure,home_est$MSZoning) #HA
home_est$BsmtExposure = NULL
chisq.test(home_est$BsmtFinType1,home_est$MSZoning) #HA
home_est$BsmtFinType1 = NULL
chisq.test(home_est$BsmtFinType2,home_est$MSZoning) #HO
chisq.test(home_est$Heating,home_est$MSZoning) #HA
home_est$Heating = NULL
chisq.test(home_est$HeatingQC,home_est$MSZoning) #HA
home_est$HeatingQC = NULL
chisq.test(home_est$CentralAir,home_est$MSZoning) #HA
home_est$CentralAir = NULL
chisq.test(home_est$Electrical,home_est$MSZoning) #HA
home_est$Electrical = NULL
chisq.test(home_est$Functional,home_est$MSZoning) #Ho
chisq.test(home_est$FireplaceQu,home_est$MSZoning) #Ho
chisq.test(home_est$GarageType,home_est$MSZoning) #HA
home_est$GarageType = NULL
chisq.test(home_est$GarageFinish,home_est$MSZoning) #HA
home_est$GarageFinish = NULL
chisq.test(home_est$GarageQual,home_est$MSZoning) #HA
home_est$GarageQual = NULL
chisq.test(home_est$GarageCond,home_est$MSZoning) #HA
home_est$GarageCond = NULL
chisq.test(home_est$PavedDrive,home_est$MSZoning) #HA
home_est$PavedDrive = NULL
chisq.test(home_est$Fence,home_est$MSZoning) #Ho
chisq.test(home_est$SaleType,home_est$MSZoning) #HA
home_est$SaleType = NULL
chisq.test(home_est$SaleCondition,home_est$MSZoning) #HA
home_est$SaleCondition = NULL
chisq.test(home_est$KitchenQual,home_est$MSZoning) #HA
home_est$KitchenQual = NULL
chisq.test(home_est$GarageCars,home_est$MSZoning) #HA
home_est$GarageCars = NULL

## Handling NULL values - Categorical values
## Converting all the categorical values to charater values
for (col in colnames(home_est)){
  if (is.factor(home_est[,col]) == "TRUE"){
    new_col = home_est[,col]
    home_est[col] = as.character(new_col)
  }
}
home_est[is.na(home_est$BsmtFinType2)==1,c("BsmtFinType2")]="No Basement"
home_est[is.na(home_est$BsmtCond)==1,c("BsmtCond")]="No Basement"
home_est[is.na(home_est$Fence)==1,"Fence"]="No Fence"
home_est[is.na(home_est$BsmtCond)==1,c("BsmtCond")]="No Basement"
home_est[is.na(home_est$FireplaceQu)==1,"FireplaceQu"]="No FirePlace"

for (col in colnames(home_est)){
  if (is.character(home_est[,col]) == "TRUE"){
    new_col = home_est[,col]
    home_est[col] = as.factor(new_col)
  }
}

summary(home_est)

### Handling Outliers
ggplot(home_est,aes(SalePrice))+geom_histogram()
ggplot(home_est,aes(OverallQual,SalePrice))+geom_boxplot()

rows = 1:nrow(home_est)
trainRows = sample(rows,round(0.7*nrow(home_est)))
testRows = rows[-trainRows]

trainData = home_est[trainRows,]
testData = home_est[testRows,]

## Model with test and train
mod1 = lm(SalePrice~., data=trainData)
summary(mod1)
plot(mod1)

preds_train = predict(mod1,trainData)
preds_test = predict(mod1,testData)
trainData$preds = preds_train
testData$preds = preds_test

## Model
library(MASS)
mod1 = lm(sp~.-SalePrice, data=home_est)
summary(mod1)
qqPlot(mod1)
preds_train = predict(mod1,home_est)
summary(preds_train)
home_est$preds = 2.718**preds_train
errors=home_est$preds_train-home_est$SalePrice
sqrt(sum((home_est$preds_train- home_est$SalePrice)**2)/nrow(home_est))
par(mfrow=c(2,2))
plot(mod1)
##RMSE Trainset 
sqrt(sum((trainData$preds- trainData$SalePrice)**2)/nrow(trainData))
sqrt(sum((trainData$preds- trainData$SalePrice)**2)/nrow(trainData))
#home_est=read.csv("house_pricing_kaggle_train.csv", head = T, sep = ",")
sum(trainData$preds- trainData$medv)

hist(mod1$residuals)
##### Doubts 
# How to handle "Neighborhood" field
home_est$Neighborhood=NULL
## How to handle Land counter ... NULL WHICH IS SPACE
home_est$LandContour=NULL

unique(home_est$Neighborhood)
unique(home_est$LandContour)

##install.packages("ggplot2")
library("ggplot2")
ggplot(home_est,aes(SalePrice,LotConfig))+geom_box
########################################