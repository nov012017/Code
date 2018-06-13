dim(iris)
s<-sample(150,100)
#split
iris_train<-iris[s,]
iris_test<-iris[-s,]

dim(iris_train)
dim(iris_test)
library(rpart)
#
dtree<-rpart(Species~.,iris_train,method = "class")
dtree
plot(dtree)
text(dtree)
library(rpart.plot)
rpart.plot(dtree)

y_pred<-predict(dtree,iris_test,type = "class")

table(iris_test[,5],y_pred)
#===========================================================
data()
