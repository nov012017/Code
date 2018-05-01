data1 = read.csv("UniversalBank.csv")
str(data1)
#data1 = data1[data1$Personal.Loan == 1,]
#data1$Personal.Loan = NULL
data1$ZIP.Code  = NULL
data1$ID = NULL

data1$Family = as.factor(data1$Family)
data1$Education = as.factor(data1$Education)
data1$Personal.Loan=as.factor(data1$Personal.Loan)

summary(data1)
# data1$Experience[data1$Experience <0] = 0

View(cor(data1[,-c(3,5)]))

data1$Experience = NULL # High cor with Age
# data1$CCAvg = NULL # High cor with Income Will drop this later

### Convert Cat to numeric
library(dummies)
data1_dummies = dummy.data.frame(data1)
names(data1_dummies)
data1_dummies = data1_dummies[,-c(6,10,13)]


### Scaling
###Min max scaling
fnScaling = function(x){
  return((x-min(x))/(max(x)-min(x)))
}

data1_dummies$AgeZscore=fnScaling(data1$Age)
data1_dummies$IncomeZscore=fnScaling(data1$Income)
str(data1_dummies)
names(data1_dummies)
summary(data1_dummies)

### Kmeans clusteringdata1_dummies[c(data1_dummies$Age,data1_dummies$Income)]
clust =  kmeans(x=data1_dummies[,c(3:16)],centers = 7)

data1_dummies$clust = clust$cluster
data1_dummies$clust=NULL

clust$cluster ## CLUSTER ID
clust$centers ## Centroids
clust$betweenss ## 
mean(clust$withinss)/clust$betweenss ## IntraCluster/interCluster
## Continuously decreasing

quantile(data1_dummies$Age,probs = seq(0,1,0.01))
quantile(data1_dummies$Income,probs = seq(0,1,0.01))

cluster1=data1_dummies[data1_dummies$clust==1,]
cluster2=data1_dummies[data1_dummies$clust==2,]
cluster3=data1_dummies[data1_dummies$clust==3,]
cluster4=data1_dummies[data1_dummies$clust==4,]
cluster5=data1_dummies[data1_dummies$clust==5,]
cluster6=data1_dummies[data1_dummies$clust==6,]
cluster7=data1_dummies[data1_dummies$clust==7,]

data1_dummies$clust = NULL
##
withinByBetween = c()
for(i in 2:15){
  clust = kmeans(x=data1_dummies,centers = i)
  ##betweenByTotal = c(betweenByTotal,clust$betweenss/clust$totss)
  withinByBetween = c(withinByBetween, mean(clust$withinss)/clust$betweenss)
}
# kmeans(x=data1_dummies,centers = 5)

plot(2:15,withinByBetween,type = 'l')



clust =  kmeans(x=data1_dummies,centers = 7)
clust$centers
data1_dummies$cluster = clust$cluster
View(data1_dummies[data1_dummies$cluster < 3,])
table(clust$cluster)
