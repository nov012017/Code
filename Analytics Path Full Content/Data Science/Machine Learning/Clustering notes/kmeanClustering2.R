data1 = read.csv("D:\\Data Science\\Machine Learning\\Churn Data.csv")
str(data1)
data1$churn = NULL
data1$phone.number = NULL
data1$area.code = as.factor(data1$area.code)
data1$state = NULL
### summary
summary(data1)
#View(data1)
#View(data.frame(table(data1$state)))
names(data1)

###
library(dummies)
data1_dummies = dummy.data.frame(data1)
data1_dummies = data1_dummies[,-c(2,5,7)]
View(cor(data1_dummies[,c(7:18)]))


### dropping columsn with high cor -- Minutes columns
data1_dummies = data1_dummies[,-c(7,10,13,16)]


###Min max scaling
fnScaling = function(x){
  return((x-min(x))/(max(x)-min(x)))
}


for(i in 1:ncol(data1_dummies)){
  data1_dummies[,i] = fnScaling(data1_dummies[,i])
}

## Kmean Clusterinh
clust = kmeans(x=data1_dummies,centers = 6)

##
betweenByTotal = c()
for(i in 2:10){
  clust = kmeans(x=data1_dummies,centers = i)
  betweenByTotal = c(betweenByTotal,clust$betweenss/clust$totss)
}
kmeans(x=data1_dummies,centers = 5)
plot(2:10,betweenByTotal,type = 'l')
 