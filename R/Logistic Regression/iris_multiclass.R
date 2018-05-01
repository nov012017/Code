iris<-read.csv(file = "iris.csv",sep = ",",header = T)
test <-multinom(class~.,data=iris)

install.packages("nnet")
library(nnet)
summary(test)

iris$predict=predict(test,iris,type="probs")
cm<-table(predict(test),iris$class)
cm
1-sum(diag(cm))/sum(cm)
z=summary(test)$coefficients/summary(test)$standard.errors
z
p<-(1-pnorm(abs(z),0,1))*2
p

install.packages("mlogit")
library(mlogit)
iris1<-mlogit.data(iris,choice="class", shape="wide",drop.index = T)
iris2<-mlogit.data(iris,choice="class", shape="wide")
summary(iris1)

result<-mlogit(class~0|sepal_length+sepal_width+petal_length+petal_width,data=iris1)
summary(result)

result1<-mlogit(class~0|sepal_length+sepal_width+petal_length+petal_width,data=iris1,reflevel = 'virginica')
summary(result)
