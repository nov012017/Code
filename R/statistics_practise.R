library(titanic)
data("titanic_train")
head(titanic_train)
View(titanic_train)
table(titanic_train$Sex)

titanic_train$Sex=as.factor(titanic_train$Fare)

summary(titanic_train$Age)
plot(titanic_train$Age)
hist(titanic_train$Age, breaks = 5)
hist(titanic_train$Age)
## 3 Compute the descriptive statistics on age variable -> summary(titanic_train$Age)
summary(titanic_train$Age)
boxplot(titanic_train$Age)
fivenum(titanic_train$Age)
## 4 Compute the descriptive statistics on age variable 
summary(titanic_train$Fare)
hist(titanic_train$Fare)
boxplot(titanic_train$Fare)
## 5 Compute the measures of spread for age and fare vairable
sd(titanic_train$Age,na.rm=T)


IQR(titanic_train$Age, na.rm=T)

## 7 Select a random sample of 500 records from titanic_train
class(titanic_train)
titanic_rmna=titanic_train[!is.na(titanic_train$Age),c("Age","Fare")]
titanic_train_sample=sample(titanic_train,500, replace=F)
titanic_train_sample=titanic_train[sample(1:nrow(titanic_train),500, replace=F), ]
View(titanic_train_sample)
View(titanic_train)
?sample

## 8cOMPURE THE MEAN FARE BY PCLASS
 mean(titanic_train$Pclass)
nlevels(titanic_train$Pclass)
unique(titanic_train$Pclass)
aggregate(titanic_train$Fare,list(titanic_train$Pclass),mean)
sum(is.na(titanic_train$Fare))
## Separate the records of all the classes and compute the mean
class1=titanic_train[(titanic_train$Pclass==3),]
mean(class1$Fare)
library(sqldf)
sqldf("select Avg(Fare),Pclass from titanic_train group by Pclass")
titanic_train[titanic_train$Pclass==3,]$Age

## Assume the age is following normal distribution
hist(titanic_train$Age)
## 11 What is the propability of a person with age greater than 50
Problem11=1-pnorm(50,mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T))
Problem11
a=titanic_train[,c("Pclass","Fare")]

## 12 What is the probability of finding a person between the age of 40 and 50?
Problem11=pnorm(50,mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T))-pnorm(40,mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T))
Problem11

## 13 What is the 75th percentile age?
summary(titanic_train$Age)
quantile(titanic_train$Age,probls=.75,na.rm=T)
qnorm(0.75,mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T))

##14 Age of the 95% of the ppl (lower(2.5%) and upper(97.5%))
qnorm(c(0.025),mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T))
qnorm(0.975,mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T))

qnorm(c(0.025),mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T),lower.tail = T)
qnorm(0.975,mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T),lower.tail = T)

quantile(titanic_train$Age, probs = c(0.025,0.975), na.rm=T)


##15 Plot the probability density of age variable
hist(titanic_train$Age)
plot(titanic_train$Age,type = "l")

k=dnorm(titanic_train$Age,mean(titanic_train$Age,na.rm=T),sd(titanic_train$Age,na.rm=T))
plot(titanic_train$Age,k)

plot(density(titanic_train$Age, na.rm=T),main = "Age Plot", xlab = "Age", ylab = "Density")

##16 Compute z values for fare variable

zscore <- function(x){
  return((x-mean(x,na.rm = T))/sd(x,na.rm=T))
}

titanic_train$Zscore=zscore(titanic_train$Fare)
View(titanic_train$Zscore)
hist(titanic_train$Zscore)
hist(titanic_train$Fare)
max(titanic_train$Zscore)

##17 Convert the fare into Standard Normal Values
range(titanic_train$Zscore)
hist(titanic_train$Zscore)
hist(titanic_train$Fare)

titanic_train[is.na(titanic_train$Age),"Age"] = mean(titanic_train$Age,na.rm=T)
View(titanic_train$Age)
minmax<- function(x){
  return((x-min(x))/max(x)-min(x))
}
titanic_train$minmax=minmax(titanic_train$Age)

##18 Is there a difference in mean of age of males na dfemales on titanic?
t.test(titanic_train$Age ~ titanic_train$Sex,alternative="greater")

titanic_train$sex=as.factor(titanic_train$Sex)

##19 Set a Alternate hypothesis 
#H0= MEAN OF MALE AND FEMALE ARE EQUAL
#HA= MEAN OF MALE AND FEMALE ARE NOT EQUAL


##20 Alternate hypothesis is Mean age of Men is greater than mean age of females
t.test(titanic_train$Age ~ titanic_train$Sex,alternative="greater")

##21 What is the propability of survival
table(titanic_train$Survived)
prop.table(table(titanic_train$Survived))

##22 What is the propability of survival of males
prop.table(table(titanic_train[titanic_train$Sex=="male","Survived"]))[2]

table(titanic_train[titanic_train$Sex=="male","Survived"])


##23 What is the propability of survival of females
prop.table(table(titanic_train[titanic_train$Sex=="female","Survived"]))[2]

table(titanic_train[titanic_train$Sex=="male","Survived"])

#24 What is the probability of Survival of females in second class
prop.table(table(titanic_train[c(titanic_train$Sex=="female" & ti) ,"Survived"]))[2]