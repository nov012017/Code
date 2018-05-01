#### IRIS LOGISTIC REGRESSION##########
######### Working with Libraries ###############
library(dummies)
library(ggplot2)
library(ROCR)
###############################################
######### Setting up the working directory #####
getwd()
iris<-read.csv(file = "iris.csv",sep = ",",header = T)
str(iris)
###############################################

######### Validating the output variable ######### 
levels(iris$class)
# Converting the class variable into dummies
iris <- cbind(iris, dummy(iris$class, sep = ""))
###################################################

####### Verifying the correlation of all the variables ######
cor(iris[,c("sepal_length","sepal_width","petal_length","petal_width")])
###################################################

########### Updating the column names of dummies #############
colnames(iris)[6]<-c("classIrisSetosa")
colnames(iris)[7]<-c("classVersicolor")
colnames(iris)[8]<-c("classVerginoa")

iris$classIrisSetosa=as.factor(iris$classIrisSetosa)
iris$classVerginoa=as.factor(iris$classVerginoa)
iris$classVersicolor=as.factor(iris$classVersicolor)
###################################################

######### Validating the Sepal Length column#######
class(iris$sepal_length)
hist(iris$sepal_length)
ggplot(iris,aes(1,sepal_length))+geom_boxplot()
###################################################

######### Validating the Sepal Width column #######
class(iris$sepal_width)
hist(iris$sepal_width)
ggplot(iris,aes(1,sepal_width))+geom_boxplot()
###################################################

######### Validating the petal_length column#######
class(iris$petal_length)
hist(iris$petal_length)
ggplot(iris,aes(1,petal_length))+geom_boxplot()
###################################################

######### Validating the petal_width column#######
class(iris$petal_width)
hist(iris$petal_width)
ggplot(iris,aes(1,petal_width))+geom_boxplot()
###################################################



#######  Sampling #########
rows= 1:nrow(iris)
trainRows = sample(rows,round(0.7*nrow(iris)))
testrows<-rows[-trainRows]
iris_training<-iris[trainRows,]
iris_test<-iris[testrows,]
###################################################

################ Building a model for setosa##################
options(scipen = 999)
model_setosa=glm(classIrisSetosa~.-class-classVersicolor-classVerginoa-petal_length-petal_width,data=iris_training,family = binomial(link = "logit"))
summary(model_setosa)
model_Versicolor=glm(classVersicolor~.-class-classIrisSetosa-classVerginoa-petal_length-petal_width,data=iris_training,family = binomial(link = "logit"))
summary(model_Versicolor)
model_Verginoa=glm(classVerginoa~.-class-classIrisSetosa-classVersicolor-petal_length-petal_width,data=iris_training,family = binomial(link = "logit"))
summary(model_Verginoa)

Predicted_Setosa <- predict(model_setosa,iris_training,type="response")
Predicted_Versicolor <- predict(model_Versicolor,iris_training,type="response")
Predicted_Vergiona <- predict(model_Verginoa,iris_training,type="response")

iris_training$Predicted_Setosa=Predicted_Setosa
iris_training$Predicted_Versicolor=Predicted_Versicolor
iris_training$Predicted_Vergiona=Predicted_Vergiona
#######################################################################

### Converting the factor to numeric to apply if else condition#####
iris_training$classIrisSetosa=as.numeric(iris_training$classIrisSetosa)
iris_training$classVerginoa=as.numeric(iris_training$classVerginoa)
iris_training$classVersicolor=as.numeric(iris_training$classVersicolor)
########################################################################

for (i in 1:nrow(iris_training)){
  if(iris_training$Predicted_Setosa[i]>iris_training$Predicted_Versicolor[i] & iris_training$Predicted_Setosa[i]>iris_training$Predicted_Vergiona[i]){
    iris_training$Predicted[i]="Iris-setosa"
    iris_training$Predicted_value[i]="1"
  }else if (iris_training$Predicted_Versicolor[i]>iris_training$Predicted_Setosa[i] & iris_training$Predicted_Versicolor[i]>iris_training$Predicted_Vergiona[i]){
    iris_training$Predicted[i]="Iris-versicolor"
    iris_training$Predicted_value[i]="2"
  }else {
    iris_training$Predicted[i]="Iris-virginica" 
    iris_training$Predicted_value[i]="3"
  } 
}

iris_training$classIrisSetosa=as.factor(iris_training$classIrisSetosa)
iris_training$classVerginoa=as.factor(iris_training$classVerginoa)
iris_training$classVersicolor=as.factor(iris_training$classVersicolor)

table(actualvalue=iris_training$class,predictedvalue=iris_training$Predicted,dnn=c('actuals','preds'))

TN=table(actualvalue=iris_training$class,predictedvalue=iris_training$Predicted,dnn=c('actuals','preds'))[1]
FN=table(actualvalue=iris_training$class,predictedvalue=iris_training$Predicted,dnn=c('actuals','preds'))[2]
FP=table(actualvalue=iris_training$class,predictedvalue=iris_training$Predicted,dnn=c('actuals','preds'))[1,2]
TP=table(actualvalue=iris_training$class,predictedvalue=iris_training$Predicted,dnn=c('actuals','preds'))[2,2]

Recall=TP/(TP+FN)
Precision=TP/(FP+TP)

Recall
Precision
###################################################


######################### Below code is for  Testing Data #######################
Predicted_Setosa_Train <- predict(model_setosa,iris_test,type="response")
Predicted_Versicolor_Train <- predict(model_Versicolor,iris_test,type="response")
Predicted_Vergiona_Train <- predict(model_Verginoa,iris_test,type="response")

iris_test$Predicted_Setosa_Train=Predicted_Setosa_Train
iris_test$Predicted_Versicolor_Train=Predicted_Versicolor_Train
iris_test$Predicted_Vergiona_Train=Predicted_Vergiona_Train

for (i in 1:nrow(iris_test)){
  if(iris_test$Predicted_Setosa_Train[i]>iris_test$Predicted_Versicolor_Train[i] & iris_test$Predicted_Setosa_Train[i]>iris_test$Predicted_Vergiona_Train[i]){
    iris_test$Predicted_train[i]="Iris-setosa"
    iris_test$Predicted_value_train[i]="1"
  }else if (iris_test$Predicted_Versicolor_Train[i]>iris_test$Predicted_Setosa_Train[i] & iris_test$Predicted_Versicolor_Train[i]>iris_test$Predicted_Vergiona_Train[i]){
    iris_test$Predicted_train[i]="Iris-versicolor"
    iris_test$Predicted_value_train[i]="2"
  }else {
    iris_test$Predicted_train[i]="Iris-virginica" 
    iris_test$Predicted_value_train[i]="3"
  } 
}

table(actualvalue=iris_test$class,predictedvalue=iris_test$Predicted_train,dnn=c('actuals','preds'))

TN=table(actualvalue=iris_test$class,predictedvalue=iris_test$Predicted_train,dnn=c('actuals','preds'))[1]
FN=table(actualvalue=iris_test$class,predictedvalue=iris_test$Predicted_train,dnn=c('actuals','preds'))[2]
FP=table(actualvalue=iris_test$class,predictedvalue=iris_test$Predicted_train,dnn=c('actuals','preds'))[1,2]
TP=table(actualvalue=iris_test$class,predictedvalue=iris_test$Predicted_train,dnn=c('actuals','preds'))[2,2]

Recall=TP/(TP+FN)
Precision=TP/(FP+TP)

Recall
Precision
#################################################################################

################ ROC GRAPH #########################
####This will only work  for binormial data --- hence no need to consider this
plot(ROCPrefSetosa,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))
###################################################

