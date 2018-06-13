 ##
library(ggplot2)
setwd("D:\\Data science  notes")
getwd()
credit<-read.csv("credit.csv",stringsAsFactors = F)
str(credit)
head(credit)
View(credit)
class()
summary(credit)

sum(is.na(credit$amount))
summary(credit$default)



##explain and draw some insights

ggplot(credit,aes(age,amount))+geom_point()

ggplot(credit,aes(age,amount,color=default))+geom_point()

ggplot(credit,aes(age,amount,color=default,shape=job))+geom_point()

##base with age and loan amount

##add color for credt history,shape for dfault,size for existing loan count

a<-ggplot(credit,aes(age,amount,color=credit_history,shape=default,size=existing_loans_count))+geom_point()
a

###adding facets to break the graph into smaller 

a+ facet_grid(job~.)  ##facetting on one variable

a+facet_grid(job~housing)

##adding titles and lables

b=a+ggtitle("Defaulter comparisions")+xlab("age of customers")+ylab("loan amount in $")
b

##add more to b

b+ coord_cartesian(xlim = c(20,40),ylim=(100,5000))

##



##best one to use classic theme


##
ggplot(credit,aes(credit_history,fill=default))+geom_bar()

##data pre processing

library(titanic)
data("Titanic")
head(titanic_train)
View(titanic_train)

dim(titanic_train)

##to find na values

sum(is.na(titanic_train$Age))

mean(titanic_train$Age,na.rm = T)

titanic_train$Age[is.na(titanic_train$Age)]=mean(titanic_train$Age,na.rm = T)
length(titanic_train$Age[is.na(titanic_train$Age)])

View(titanic_train)

##Grouping variables
age=19
if(age<=25){
  age_grp='0-25'
}else if(age>25 & age<=35){
    age_grp='26-35'
}else if(age>35 & age<=45){
  age_grp='36-45'
  }else age_grp='45+'

age_grp

##for(i in 1:nrow(titanic_train)){
age_grp<-function(titanic_train$Age){
for(i in 1:nrow(titanic_train)){
if(titanic_train[i]$Age<=25){
  age_grp='0-25'
}else if(titanic_train$Age[i]>25 & titanic_train$Age[i]<=35){
  age_grp='26-35'
}else if(titanic_train$Age[i]>35 & titanic_train$Age[i]<=45){
  age_grp='36-45'
}else age_grp='45+'
}
  }
age_grp(26)
##g score

(titanic_train$Age- mean(titanic_train$Age))/ sd(titanic_train$Age)

zs<-function(titanic_train$Age){
  zscore<-(titanic_train$Age- mean(titanic_train$Age))/sd(titanic_train$Age)
}
  return()
