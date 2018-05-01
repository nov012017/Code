library(titanic)
library(dummies)
library(ggplot2)
library(VIM) ## This is not knn imputation
library(DMwR)
install.packages("VIM")
install.packages("DMwR")
data=titanic_train
length(data)
dim(data)
str(data)

###### Deleting the unwanted columns
data$PassengerId=NULL
data$Name=NULL
data$Ticket=NULL
data$Cabin=NULL
data$Embarked=NULL
####################################
###### Converting to factor variables
data$Survived=as.factor(data$Survived)
data$Pclass=as.factor(data$Pclass)
data$Sex=as.factor(data$Sex)
data$SibSp=as.factor(data$SibSp)
data$Parch=as.factor(data$Parch)
data$Embarked=as.factor(data$Embarked)
####################################

###### Handling missing values
sum(is.na(data))
sum(is.na(data$Age))
data[is.na(data$Age)==1,"Age"]=median(data$Age,na.rm=T)
test=knnImputation(data = data, k = 5)
sum(is.na(test))
summary(test)
####################################
str(test)
##### Pre Processing the Age Column
hist(test$Age)
quantile(test$Age,probs = seq(0,1,0.01))
data=data[test$Age<=quantile(test$Age,0.99),]
data=data[test$Age>=quantile(test$Age,0.01),]
ggplot(test,aes(1,Age))+geom_boxplot()
  mean(test$Age)
  median(test$Age)
#data=data[data$Age<3*sd(data$Age) & data$Age> (-3 * sd(data$Age)),]
####################################

### Dummies
test <- cbind(test, dummy(test$Survived, sep = ""))
View(test[,c("Survived","test0","test1")])
data1_dummies = dummy.data.frame(test)
names(data1_dummies)

#data2=data1_dummies[,-c("Survived1","Pclass3","Sexmale","SibSp8","Parch6","Embarked6")]
data2=data1_dummies[,-c(2,5,7,15,22,30)]
str(data2)
####################################

##### Scaling
fnScaling = function(x){
  return((x-min(x))/(max(x)-min(x)))
}

for(i in 1:ncol(data2)){
  data2[,i] = fnScaling(data2[,i])
}

####################################
clust =  kmeans(x=data2,centers = 2)
data2$clust = clust$cluster

cluster1=data2[data2$clust==1,]
cluster2=data2[data2$clust==2,]

prop.table(table(cluster1$Survived0))
prop.table(table(cluster1$Sexfemale,cluster1$Survived0))

prop.table(table(cluster2$Survived0))
prop.table(table(cluster2$Sexfemale))


clust$cluster ## CLUSTER ID
clust$centers ## Centroids
clust$betweenss ## 

mean(clust$withinss)/clust$betweenss ## IntraCluster/interCluster
## Continuously decreasing
withinByBetween = c()
for(i in 2:15){
  clust = kmeans(x=data2,centers = i)
  ##betweenByTotal = c(betweenByTotal,clust$betweenss/clust$totss)
  withinByBetween = c(withinByBetween, mean(clust$withinss)/clust$betweenss)
}
# kmeans(x=data1_dummies,centers = 5)
plot(2:15,withinByBetween,type = 'l')


########################################
cluster1=data2[data2$clust==1,]
length(cluster1)

fnScaling = function(x){
  return((x-min(x))/(max(x)-min(x)))
}

#################################################
cluster1_male=