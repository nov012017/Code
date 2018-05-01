## Removing the outliers
Boston_medv_filtered<-Boston[Boston$medv_log>(mean(Boston$medv_log)-3*sd(Boston$medv_log)) & 
                               Boston$medv_log<(mean(Boston$medv_log)+3*sd(Boston$medv_log)),]

##Sampling
rows= 1:nrow(Boston_medv_filtered)
trainRows = sample(rows,round(0.7*nrow(Boston_medv_filtered)))
testrows<-rows[-trainRows]
traindata<-Boston_medv_filtered[trainRows,]
testdata<-Boston_medv_filtered[testrows,]

install.packages("caTools")
library(caTools)
split<-sample.split(iris,SplitRatio = 0.8)
#ggplot(iris,aes(split))+geom_bar()
iris_training<-subset(iris,split=="TRUE")
iris_test<-subset(iris,split=="FALSE")

#Correlation of multiple variables
cor(Boston[,c("crim","zn","lstat","medv_log")])
pairs.panels(insurance[,c("age","bmi","children")])

#Binning
Boston_medv_filtered$crim_status=cut(Boston_medv_filtered$crim,breaks = c(0,1,5,100),labels = c("low","medium","high"))

##convert to dummies (dummy feature)
str(insurance)
install.packages("dummies")
library(dummies)
insurance_dummy=dummy.data.frame(insurance)
View(insurance_dummy)
insurance_dummy=insurance_dummy[-c(3,6,8)]

iris <- cbind(iris, dummy(iris$class, sep = ""))

## Removing outliers
data1=data1[data1$Fare>(mean(data1$Fare)-3*sd(data1$Fare)),]
data1=data1[data1$Fare<(mean(data1$Fare)+3*sd(data1$Fare)),]

## Handling outliers
data1[data1$Fare>quantile(data1$Fare,probs = seq(0,1,0.99)),"Fare"]=quantile(data1$Fare,probs = seq(0,1,0.99))

## If else funciton
data1$Parch = ifelse(data1$Parch > 1,'>1',data1$SibSp)

## Quantile Function
quantile(data1$Age, probs = seq(0,1,0.01))

## Replacing missing value
# Central Imputation
data1[is.na(data1$Age)==1,"Age"]=mean(data1$Age, na.rm=T)

# Missing value
a<- sapply(home_est, function(x) sum(is.na(x)))

#Filter
home_est <- filter(home_est, MasVnrArea != 'NA')

#KNN Imputation
library(DMwR)
knnImputation(data=data,k=5)


## Convert exponential to decimal
options(scipen = 999)

## Props.table command to get the proportions

