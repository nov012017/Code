##k-means clustering
setwd("D:\\Data science  notes")
getwd()
data1=read.csv("UniversalBank.csv")
View(data1)
names(data1)

#data1$churn=NULL
data1$ID=NULL
data1$ZIP.Code=NULL

data1$Family=as.factor(data1$Family)
data1$Education=as.factor(data1$Education)

summary(data1)
View(cor(data1[,-c(4,6)]))
data1$Experience=NULL

library(dummies)
data1_dummies=dummy.data.frame(data1)
names(data1_dummies)
data1_dummies=data1_dummies[,-C(6,10)]
#View(data1_dummies)
View(cor(data1_dummies))

#dropping columns with high corr
#data1_dummies=data1_dummies[,-c(2,8)]

#min max scaling
fnscaling=function(x){
  return((x-min(x))/(max(x)-min(x)))
}

for(i in 1:ncol(data1_dummies)){
  data1_dummies[,i]=fnscaling(data1_dummies[,i])
}

##k means clustering
betweenByTotal=c()
for(i in 2:15)