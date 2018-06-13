library(MASS)
data("Boston")
View(Boston)

#for data description
?Boston
names(Boston)
set.seed(2)
library(caTools)

split<-sample.split(Boston$medv,SplitRatio = 0.7)
split

train_data<-subset(Boston,split==TRUE)
test_data<-subset(Boston,split==FALSE)

##To see correlation of variables
plot(Boston$crim,Boston$medv,cex=0.5,xlab = "crime rate",ylab = "price")
cr<-cor(Boston)

#creating scatterplot matrix
attach(Boston)
library(lattice)
splom(~Boston[c(1:6,14)], groups=NULL,data = Boston,axis.line.tck=0,axis.text.alpha=0)
splom(~Boston[c(7,14)], groups=NULL,data = Boston,axis.line.tck=0,axis.text.alpha=0)

#studying rm and medv
plot(rm,medv)
abline(lm(medv~rm),col("red")) #regression fit line

#we can use correplot to visualize
#install.packages("corrplot")
library(corrplot)

corrplot(cr,type = "lower")
corrplot(cr,method = "number")

#finding multicollinearity
library(caret)

#to exclude medv(output)
Boston_a<-subset(Boston,select = -c(medv))
numericData<-Boston_a[sapply(Boston_a,is.numeric)]
descCor<-cor(numericData)
#View(descCor)


library(car)
model<-lm(medv~.,data = train_data)
vif(model)

#now we create model using all columns
model<-lm(medv~.,data = train_data)

summary(model)

#model creation after removal of tax
model<-lm(medv~.-tax,data = train_data)
summary(model)


#model creation after removal of age and indus
model<-lm(medv~.-age -indus,data = train_data)
summary(model)

#now we can use this model for predict test data
predic<-predict(model,test_data)
predic

#To compare pred data and test data, we use plots
plot(test_data$medv,type = "l",col="green")
lines(predic,type = "l",col="blue")

#now we can predict with the sample data
predic<-predict(model,sample_data)
predic

