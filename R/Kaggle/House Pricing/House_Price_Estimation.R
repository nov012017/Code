library(ggplot2)

#setwd("C:/Users/Admin/Desktop/Analytics Path/R/Data/Kaggle/house_pricing_kaggle.csv")
home_est=read.csv("house_pricing_kaggle.csv", head = T, sep = ",")
#summary(home_est)
home_est$sp

###Handling the Unique value column
#Analysis of ID column: This column consists only Unique values and hence removing the columns
home_est$Id=NULL

### getting the missing value coloumns wise

#summary(home_est)

#a<- sapply(home_est, function(x) sum(is.na(x)))
#a=as.data.frame(a)
#typeof(a)
#a=a[a$a!=0,]
#a


### Handling the missing values part 

## Here are the fileds which have the missing values 

##   GarageQual - 81 / GarageType/ GarageYrBlt / GarageCond /
##  Fence - 1179
## MiscFeature - 1406
## BsmtFinType2 - 38 / BsmtFinType1 -37 / BsmtExposure - 38 / BsmtCond -37 / BsmtQual -37
## MasVnrArea -8
## LotFrontage- 259

### By looking at the above missing values info, lets work on least missing value coloumns 
## After looking at the data we can infer that the missing values means there is not wall to the house
## So we have to repalce null values with "NO Masonary"
## So again its corresponding column "MasVnrArea" null values we are replacing with "0"
home_est$MasVnrType=as.character(home_est$MasVnrType)
home_est[is.na(home_est$MasVnrType)==1,c('MasVnrType')]='No Massonary'
home_est$MasVnrType=as.factor(home_est$MasVnrType)

#home_est[is.na(home_est$MasVnrArea)==1,c('MasVnrArea')]='-1'

#nrow(home_est[home_est$MasVnrArea==-1,])

####################### Completed ##############################################

## BsmtFinType2 - 38 / BsmtFinType1 -37 / BsmtExposure - 38 / BsmtCond -37 / BsmtQual -37

summary(home_est$BsmtFinType2)
summary(home_est$BsmtFinType1)
summary(home_est$BsmtExposure)
summary(home_est$BsmtCond)
summary(home_est$BsmtQual)

# Analysis:
#When there is no basement (cellar), 
#the below feilds will be null
#BsmtQual, BsmtCond,BsmtExposure, BsmtFinType1, BsmtFinType2
#the below fields will be zero
#BsmtFinSF1,BsmtFinSF2,BsmtUnfSF,TotalBsmtSF
#Conclusion:
# Hence replacing the null values of BsmtQual, BsmtCond,BsmtExposure, BsmtFinType1, BsmtFinType2 with a values called "No Basement"
#nrow(home_est)
#Bsmt_val_Test  <- home_est[is.na(home_est$BsmtFinType2)==1,]
#nrow(Bsmt_val_Test)

# Converting factor to Character to update the null values
home_est$BsmtQual=as.character(home_est$BsmtQual)
home_est$BsmtCond=as.character(home_est$BsmtCond)
home_est$BsmtExposure=as.character(home_est$BsmtExposure)
home_est$BsmtFinType1=as.character(home_est$BsmtFinType1)
home_est$BsmtFinType2=as.character(home_est$BsmtFinType2)


home_est[is.na(home_est$BsmtQual)==1 & 
           is.na(home_est$BsmtCond)==1 &
           is.na(home_est$BsmtExposure)==1 &
           is.na(home_est$BsmtFinType1)==1 &
           is.na(home_est$BsmtFinType2)==1 &
           is.na(home_est$BsmtFinSF1)==0 &
           is.na(home_est$BsmtFinSF2)==0 &
           is.na(home_est$BsmtUnfSF)==0 &
           is.na(home_est$TotalBsmtSF)==0,
         c("BsmtQual","BsmtCond","BsmtExposure","BsmtFinType1","BsmtFinType2")]="No Basement"

#sum(is.na(home_est$BsmtCond))

# Converting back to the factor data
home_est$BsmtQual=as.factor(home_est$BsmtQual)
home_est$BsmtCond=as.factor(home_est$BsmtCond)
home_est$BsmtExposure=as.factor(home_est$BsmtExposure)
home_est$BsmtFinType1=as.factor(home_est$BsmtFinType1)
home_est$BsmtFinType2=as.factor(home_est$BsmtFinType2)

## BsmtFinType2 and BsmtExposure has 38 missing values and BsmtFinType1,BsmtQual and BsmtCond has 37 missing values
home_est$BsmtExposure=as.factor(home_est$BsmtExposure)
## Handling extra 1(38th) missing value of BsmtFinType2
#test=home_est[home_est$BsmtExposure=='No' & home_est$BsmtFinType1=='GLQ' & home_est$BsmtCond=='TA' & home_est$BsmtQual=='Gd',]
home_est[home_est$BsmtExposure=='No' 
         & home_est$BsmtFinType1=='GLQ' 
         & home_est$BsmtCond=='TA' 
         & home_est$BsmtQual=='Gd' 
         & is.na(home_est$BsmtExposure)==0,"BsmtFinType2"]="Unf"
home_est$BsmtExposure=as.character(home_est$BsmtExposure)
table(home_est$BsmtFinType2)
summary(home_est$BsmtFinType2)
#################################Completed############################################



##   GarageQual - 81 / GarageType -81/ GarageYrBlt-81 / GarageCond-81 /GarageFinish-81

summary(home_est$GarageType)
summary(home_est$GarageYrBlt)
summary(home_est$GarageFinish)
summary(home_est$GarageQual)
summary(home_est$GarageCond)
summary(home_est$GarageCars) ## No Nulls,,,, Filled with 0 (No Garage No cars)
summary(home_est$GarageArea)## No Nulls,,,, Filled with 0 (No Garage No Area)

home_est$GarageType=as.character(home_est$GarageType)
home_est$GarageYrBlt=as.character(home_est$GarageYrBlt)
home_est$GarageFinish=as.character(home_est$GarageFinish)
home_est$GarageQual=as.character(home_est$GarageQual)
home_est$GarageCond=as.character(home_est$GarageCond)

## Replacing null values with a values called "No Garage"
home_est[is.na(home_est$GarageType)==1 &
           is.na(home_est$GarageYrBlt)==1 &
           is.na(home_est$GarageFinish)==1 &
           is.na(home_est$GarageQual)==1 &
           is.na(home_est$GarageCond)==1&
           home_est$GarageCars==0 &
           home_est$GarageArea==0,c("GarageType","GarageFinish","GarageQual","GarageCond")]="No Garage"

## Replacing the Null value of GarageYrBlt field with 9999
home_est[is.na(home_est$GarageYrBlt)==1 &
           home_est$GarageCars==0 &
           home_est$GarageArea==0,"GarageYrBlt"]="9999"


sum(is.na(home_est$GarageYrBlt))

home_est$GarageType=as.factor(home_est$GarageType)
home_est$GarageYrBlt=as.factor(home_est$GarageYrBlt)
home_est$GarageFinish=as.factor(home_est$GarageFinish)
home_est$GarageQual=as.factor(home_est$GarageQual)
home_est$GarageCond=as.factor(home_est$GarageCond)

sum(is.na(home_est$GarageYrBlt))
####################### Completed ##############################################

################PoolQC and Pool Area#######################
#Analysis: PoolQC is missing means there is no pool for the most of the houses. We cannot remove these 
#missing values because houses with pool has more selling price than the houses with no swimming pools
summary(home_est$PoolArea)
summary(home_est$PoolQC)

home_est$PoolQC=as.character(home_est$PoolQC)
home_est[home_est$PoolArea==0 &
           is.na(home_est$PoolQC)==1,"PoolQC"]="No Pool"
home_est$PoolQC=as.factor(home_est$PoolQC)
#Conclusion: Missing values in PoolQC is replaced as "No Pool"

##############Completed####################################
################MiscFeature   1406#######################
#Analysis: These are the added features linke shuttle court, large shed etc.
# There wont much large variation and hence removing the columns
summary(home_est$MiscFeature)
#home_est$MiscFeature=NULL
##############Completed####################################
################Fence#######################
summary(home_est$Fence)
#Analysis: House with fence might cost more than the houses with no fence and low quality fence
# In this case null values represent that the house has no fence
home_est$Fence=as.character(home_est$Fence)
home_est[is.na(home_est$Fence)==1,"Fence"]="No Fence"
home_est$Fence=as.factor(home_est$Fence)
##############Completed####################################
################Alley#######################
home_est$Alley=as.character(home_est$Alley)
home_est[is.na(home_est$Alley)==1,"Alley"]="No Alley"
home_est$Alley=as.factor(home_est$Alley)
summary(home_est$Alley)
##############Completed####################################
##sapply(home_est, function(x) sum(is.na(x)))

### #####LotFrontage    259 --- Missing values 

### replacing missing values with mean for group mean of Zoning - Started    ###################
a=aggregate(home_est$LotFrontage, list(home_est$MSZoning),FUN=mean,na.rm=T)
#nrow(filter(home_est, home_est$MSZoning == 'FV'))
home_est$LotFrontage <- ifelse(home_est$MSZoning=='FV' & is.na(home_est$LotFrontage), a[a$Group.1=="FV","x"],home_est$LotFrontage)
home_est$LotFrontage <- ifelse(home_est$MSZoning=='RH' & is.na(home_est$LotFrontage), a[a$Group.1=="RH","x"],home_est$LotFrontage)
home_est$LotFrontage <- ifelse(home_est$MSZoning=='RL' & is.na(home_est$LotFrontage), a[a$Group.1=="RL","x"],home_est$LotFrontage)
home_est$LotFrontage <- ifelse(home_est$MSZoning=='RM' & is.na(home_est$LotFrontage), a[a$Group.1=="RM","x"],home_est$LotFrontage)
summary(home_est$LotFrontage)
##filter(home_est, home_est$MSZoning == 'RM')
##home_est$new = NULL

sum(is.na(home_est$LotFrontage))

##############Completed####################################

##### Wroking on ### replacing missing values for FireplaceQu 

table(home_est$FireplaceQu)
summary(home_est$FireplaceQu)
table(home_est$Fireplaces)
home_est$FireplaceQu=as.character(home_est$FireplaceQu)
home_est[home_est$Fireplaces==0 & is.na(home_est$FireplaceQu)==1,"FireplaceQu"]="No FirePlace"
home_est$FireplaceQu=as.factor(home_est$FireplaceQu)
sum(is.na(home_est$FireplaceQu))

table(home_est$FireplaceQu)
######Data Type Conversion#############################

##MSSubClass
#The null hypothesis for ANOVA is that the mean (average value of the dependent variable) 
#is the same for all groups. 
#The alternative or research hypothesis is that the average is not the same for all groups.
options(scipen = 999)
home_est$MSSubClass=as.factor(home_est$MSSubClass)
summary(home_est$MSSubClass)
ggplot(home_est,aes(MSSubClass,SalePrice))+geom_boxplot()
summary(aov(home_est$SalePrice~home_est$MSSubClass))
aggregate(home_est$SalePrice, list(home_est$MSSubClass),FUN=mean,na.rm=T)
prop.table(table(home_est$MSSubClass))
table(home_est$MSSubClass)

#Since Pvalue is less than 0.05 we should reject null hypothesis and accept alternate. Means are not equal
#Conclusion: MSSubClass has a significant effect on the SalesPrice
## MSZoning
summary(home_est$MSZoning)
ggplot(home_est,aes(MSZoning,SalePrice))+geom_boxplot()
summary(aov(home_est$SalePrice~home_est$MSZoning))
aggregate(home_est$SalePrice, list(home_est$MSZoning),FUN=mean,na.rm=T)
table(home_est$MSZoning)
#home_est$MSZoning=NULL
prop.table(table(home_est$MSZoning))
#Since Pvalue is less than 0.05 we should reject null hypothesis and accept alternate. Means are not equal
#Conclusion: Almost 80% of the data is representing RL and there is chance of getting biased

## Street
summary(home_est$Street)
ggplot(home_est,aes(Street,SalePrice))+geom_boxplot()
ggplot(home_est,aes(Street))+geom_bar()
summary(aov(home_est$SalePrice~home_est$Street))
aggregate(home_est$SalePrice, list(home_est$Street),FUN=mean,na.rm=T)
home_est$Street=NULL
## Conclusion: Grvl has only six records and it is not giving any great inference and hence removing this column

##Alley
summary(home_est$Alley)
ggplot(home_est,aes(Alley,SalePrice))+geom_boxplot()
ggplot(home_est,aes(Alley))+geom_bar()
summary(aov(home_est$SalePrice~home_est$Alley))
a=aggregate(home_est$SalePrice, list(home_est$Alley),FUN=mean,na.rm=T)
home_est$Alley=NULL
#Conclusion: Almost 93% of the data is representing "no alley" and there is chance of getting biased

## LotShape
summary(home_est$LotShape)
ggplot(home_est,aes(LotShape,SalePrice))+geom_boxplot()
ggplot(home_est,aes(LotShape))+geom_bar()
summary(aov(home_est$SalePrice~home_est$LotShape))
aggregate(home_est$SalePrice, list(home_est$LotShape),FUN=mean,na.rm=T)
home_est$LotShape=NULL
# Variation is not same accross all the levels and dropping the column
#Conclusion: LotShape has a significant effect on the SalesPrice 

## LandContour
summary(home_est$LandContour)
ggplot(home_est,aes(LandContour,SalePrice))+geom_boxplot()
ggplot(home_est,aes(LandContour))+geom_bar()
summary(aov(home_est$SalePrice~home_est$LandContour))
aggregate(home_est$SalePrice, list(home_est$LandContour),FUN=mean,na.rm=T)
home_est$LandContour=NULL
#Conclusion: Almost 90% of the data is representing LV1 and there is chance of getting biased

##Utilities
summary(home_est$Utilities)
ggplot(home_est,aes(Utilities,SalePrice))+geom_boxplot()
ggplot(home_est,aes(Utilities))+geom_bar()
summary(aov(home_est$SalePrice~home_est$Utilities))
aggregate(home_est$SalePrice, list(home_est$Utilities),FUN=mean,na.rm=T)
home_est$Utilities=NULL
## Conclusion: NoSeWa has only 1 records and it is not giving any great inference and hence removing this column

## Neighborhood
summary(home_est$Neighborhood)
ggplot(home_est,aes(Neighborhood,SalePrice))+geom_boxplot()
ggplot(home_est,aes(Neighborhood))+geom_bar()
summary(aov(home_est$SalePrice~home_est$Neighborhood))
aggregate(home_est$SalePrice, list(home_est$Neighborhood),FUN=mean,na.rm=T)
#Conclusion: Not sure how to handle this

## Condition2
summary(home_est$Condition2)
ggplot(home_est,aes(Condition2,SalePrice))+geom_boxplot()
ggplot(home_est,aes(Condition2))+geom_bar()
summary(aov(home_est$SalePrice~home_est$Condition2))
aggregate(home_est$SalePrice, list(home_est$Condition2),FUN=mean,na.rm=T)
A=chisq.test(home_est$Condition1,home_est$Condition2)
A$p.value
pchisq(504.83,56,lower.tail = F)
home_est$Condition2=NULL
#Conclusion: Almost 95% of the data representing NORM

## Condition1
summary(home_est$Condition1)
prop.table(table(home_est$Condition1))
ggplot(home_est,aes(Condition1,SalePrice))+geom_boxplot()
ggplot(home_est,aes(Condition1))+geom_bar()
summary(aov(home_est$SalePrice~home_est$Condition1))
aggregate(home_est$SalePrice, list(home_est$Condition1),FUN=mean,na.rm=T)
chisq.test(home_est$Condition1,home_est$Condition1)
home_est$Condition1=NULL
#Conclusion: Almost 95% of the data representing NORM 

##BldgType:
summary(home_est$BldgType)
ggplot(home_est,aes(BldgType,SalePrice))+geom_boxplot()
ggplot(home_est,aes(BldgType))+geom_bar()
summary(aov(home_est$SalePrice~home_est$BldgType))
aggregate(home_est$SalePrice, list(home_est$BldgType),FUN=mean,na.rm=T)
home_est$BldgType=NULL
#Conclusion: Almost 80% of the data representing 1Farm 

##HouseStyle
summary(home_est$HouseStyle)
ggplot(home_est,aes(HouseStyle,SalePrice))+geom_boxplot()
ggplot(home_est,aes(BldgType))+geom_bar()
summary(aov(home_est$SalePrice~home_est$HouseStyle))
aggregate(home_est$SalePrice, list(home_est$HouseStyle),FUN=mean,na.rm=T)

# Overallqual
#Converting overallQual to Factor variable
home_est$OverallQual=as.factor(home_est$OverallQual)
summary(home_est$OverallQual)
ggplot(home_est,aes(OverallQual,SalePrice))+geom_boxplot()
ggplot(home_est,aes(OverallQual))+geom_bar()
summary(aov(home_est$SalePrice~home_est$OverallQual))
aggregate(home_est$SalePrice, list(home_est$OverallQual),FUN=mean,na.rm=T)

# OverallCond
#Converting overallQual to Factor variable
home_est$OverallCond=as.factor(home_est$OverallCond)
summary(home_est$OverallCond)
ggplot(home_est,aes(OverallCond,SalePrice))+geom_boxplot()
ggplot(home_est,aes(home_est$OverallCond,home_est$SalePrice,fill=home_est$MSZoning))+geom_bar(position="dodge",stat='identity')
summary(aov(home_est$SalePrice~home_est$OverallCond))
aggregate(home_est$SalePrice, list(home_est$OverallCond),FUN=mean,na.rm=T)
home_est$OverallCond=NULL

##YearBuilt
home_est$YearBuilt=as.factor(home_est$YearBuilt)
summary(home_est$YearBuilt)
ggplot(home_est,aes(YearBuilt,SalePrice))+geom_boxplot()
ggplot(home_est,aes(home_est$YearBuilt,home_est$SalePrice,fill=home_est$MSZoning))+geom_bar(position="dodge",stat='identity')
summary(aov(home_est$SalePrice~home_est$YearBuilt))
aggregate(home_est$SalePrice, list(home_est$YearBuilt),FUN=mean,na.rm=T)

##YearRemodAdd  
unique(home_est$YearRemodAdd)
#Not clear How to handle

## RoofStyle
summary(home_est$RoofStyle)
ggplot(home_est,aes(RoofStyle,SalePrice))+geom_boxplot()
ggplot(home_est,aes(home_est$RoofStyle,home_est$SalePrice,fill=home_est$MSZoning))+geom_bar(position="dodge",stat='identity')
summary(aov(home_est$SalePrice~home_est$RoofStyle))
a=aggregate(home_est$SalePrice, list(home_est$RoofStyle),FUN=mean,na.rm=T)
home_est$RoofStyle=NULL
#Conclusion: 70% OF THE DATA IS REPRESENTING Gable
## RoofMatl
summary(home_est$RoofMatl)
ggplot(home_est,aes(RoofStyle,SalePrice))+geom_boxplot()
ggplot(home_est,aes(home_est$RoofStyle,home_est$SalePrice,fill=home_est$MSZoning))+geom_bar(position="dodge",stat='identity')
summary(aov(home_est$SalePrice~home_est$RoofStyle))
a=aggregate(home_est$SalePrice, list(home_est$RoofStyle),FUN=mean,na.rm=T)
home_est$RoofMatl=NULL
#Conclusion: 90% OF THE DATA IS REPRESENTING Compshg

##Exterior1st
summary(home_est$Exterior1st)
summary(aov(home_est$SalePrice~home_est$Exterior1st))
home_est$Exterior1st=NULL

##Exterior2nd
summary(home_est$Exterior2nd)
summary(aov(home_est$SalePrice~home_est$Exterior2nd))
home_est$Exterior2nd=NULL

##MasVnrType
summary(home_est$MasVnrType)
summary(aov(home_est$SalePrice~home_est$MasVnrType))
home_est$MasVnrType=NULL

##ExterQual
summary(home_est$ExterQual)
summary(aov(home_est$SalePrice~home_est$ExterQual))
home_est$ExterQual=NULL

##ExterCond
summary(home_est$ExterCond)
summary(aov(home_est$SalePrice~home_est$ExterCond))
home_est$ExterCond=NULL

#Foundation
summary(home_est$Foundation)
summary(aov(home_est$SalePrice~home_est$Foundation))
home_est$Foundation=NULL

#BsmtQual
summary(home_est$BsmtQual)
summary(aov(home_est$SalePrice~home_est$BsmtQual))
home_est$BsmtQual=NULL

#BsmtCond
summary(home_est$BsmtCond)
summary(aov(home_est$SalePrice~home_est$BsmtCond))
home_est$BsmtCond=NULL

#BsmtExposure
home_est$BsmtExposure=as.factor(home_est$BsmtExposure)
summary(home_est$BsmtExposure)
summary(aov(home_est$SalePrice~home_est$BsmtExposure))
home_est$BsmtExposure=NULL

#BsmtFinType1
summary(home_est$BsmtFinType1)
summary(aov(home_est$SalePrice~home_est$BsmtFinType1))

#BsmtFinType2
summary(home_est$BsmtFinType2)
summary(aov(home_est$SalePrice~home_est$BsmtFinType1))
home_est$BsmtFinType2=NULL

#Heating
summary(home_est$Heating)
summary(aov(home_est$SalePrice~home_est$BsmtFinType1))
home_est$Heating=NULL

#HeatingQC
summary(home_est$HeatingQC)
summary(aov(home_est$SalePrice~home_est$BsmtFinType1))
home_est$HeatingQC=NULL

#CentralAir
summary(home_est$CentralAir)
summary(aov(home_est$SalePrice~home_est$BsmtFinType1))
home_est$CentralAir=NULL

#Electrical
summary(home_est$Electrical)
summary(aov(home_est$SalePrice~home_est$BsmtFinType1))
home_est$Electrical=NULL

#BsmtFullBath
home_est$BsmtFullBath=as.factor(home_est$BsmtFullBath)
summary(home_est$BsmtFullBath)
home_est$BsmtFullBath=NULL

#BsmtHalfBath
home_est$BsmtHalfBath=as.factor(home_est$BsmtHalfBath)
summary(home_est$BsmtHalfBath)
home_est$BsmtHalfBath=NULL

#FullBath
home_est$FullBath=as.factor(home_est$FullBath)
summary(home_est$FullBath)
home_est$FullBath=NULL

#HalfBath
home_est$HalfBath=as.factor(home_est$HalfBath)
summary(home_est$HalfBath)
home_est$HalfBath=NULL

#BedroomAbvGr
home_est$BedroomAbvGr=as.factor(home_est$BedroomAbvGr)
summary(home_est$BedroomAbvGr)
home_est$BedroomAbvGr=NULL

#KitchenAbvGr
home_est$KitchenAbvGr=as.factor(home_est$KitchenAbvGr)
summary(home_est$KitchenAbvGr)
home_est$KitchenAbvGr=NULL

#KitchenQual
home_est$KitchenQual=as.factor(home_est$KitchenQual)
summary(home_est$KitchenQual)
home_est$KitchenQual=NULL

#BsmtFinType1
home_est$BsmtFinType1=as.factor(home_est$BsmtFinType1)
summary(home_est$BsmtFinType1)

#BsmtFinSF2
home_est$BsmtFinType1=as.factor(home_est$BsmtFinType1)
summary(home_est$BsmtFinType1)

#Functional
summary(home_est$Functional)
home_est$Functional=NULL

#FireplaceQu
summary(home_est$FireplaceQu)
home_est$FireplaceQu=NULL


#GarageType
summary(home_est$GarageType)
home_est$GarageType=NULL

#GarageFinish
summary(home_est$GarageFinish)
summary(aov(home_est$SalePrice~home_est$GarageFinish))

#GarageQual
summary(home_est$GarageQual)
home_est$GarageQual=NULL

#GarageCond
summary(home_est$GarageCond)
home_est$GarageCond=NULL

#PavedDrive
summary(home_est$PavedDrive)
home_est$PavedDrive=NULL

#PoolQC
summary(home_est$PoolQC)
home_est$PoolQC=NULL

#Fence
summary(home_est$Fence)
home_est$Fence=NULL

#SaleType
summary(home_est$SaleType)
home_est$SaleType=NULL

#SaleCondition
summary(home_est$SaleCondition)
home_est$SaleCondition=NULL

#MoSold
home_est$MoSold=as.factor(home_est$MoSold)
ggplot(home_est,aes(MoSold,SalePrice))+geom_boxplot()
summary(aov(home_est$SalePrice~home_est$MoSold))
home_est$MoSold=NULL

#YrSold
home_est$YrSold=as.factor(home_est$YrSold)
ggplot(home_est,aes(YrSold,SalePrice))+geom_boxplot()
summary(aov(home_est$SalePrice~home_est$YrSold))
home_est$YrSold=NULL

#MiscVal
summary(home_est$MiscVal)
home_est$MiscVal=NULL

#PoolArea
unique(home_est$PoolArea)
home_est$PoolArea=NULL

###### Handling Continuous data ##########
#ScreenPorch
unique(home_est$ScreenPorch)
hist(home_est$ScreenPorch)
home_est$PoolArea=NULL

cor(home_est[,c("ScreenPorch","X3SsnPorch","EnclosedPorch","OpenPorchSF","WoodDeckSF","GarageArea",
            "X1stFlrSF","X2ndFlrSF","BsmtUnfSF","BsmtFinSF2","BsmtFinSF1","MasVnrArea","LotArea")])

#TotRmsAbvGrd has high correlation with GrLivArea and hence dropping one column
home_est$GrLivArea=NULL
#X1stFlrSF has high correlation with TotalBsmtSF and hence dropping one column
home_est$TotalBsmtSF=NULL
#X2ndFlrSF has correlation with TotRmsAbvGrd and hence dropping one column
home_est$TotRmsAbvGrd=NULL

hist(log(home_est$BsmtUnfSF))
hist(home_est$BsmtUnfSF)
#ggplot(home_est, aes(home_est$MSZoning, home_est$SalePrice, fill=home_est$MSZoning)) + 
  #geom_bar(position="dodge",stat='identity') 

