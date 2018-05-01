
setwd("D:\\R")

#1   Use titanic data for 
install.packages("titanic")
library(titanic)
titanic=titanic_train

#2 Compute the descriptive statistics on age 
summary(titanic$Age)

#3 Compute descriptive statistice on Fare variable 
summary(titanic$Fare)

#4 Compute the measures of spread for age and Fare variable 
var(titanic$Age, na.rm=TRUE)
var(titanic$Fare,na.rm=TRUE)
sd(titanic$Age,na.rm=TRUE)
sd(titanic$Fare, na.rm=TRUE)
IQR(titanic$Age,na.rm=TRUE)
IQR(titanic$Fare, na.rm=TRUE)

#5 Select a random sample of 500 records from titanic_train
mysample = titanic[sample(1:nrow(titanic),500,replace = FALSE),]
nrow(mysample)

#6 Compute the mean fare by PClass
aggregate(titanic$Fare,list(titanic$Pclass),mean)
      #other approach 
library(sqldf)
sqldf("select Avg(Fare),Pclass from titanic 
      group by Pclass ")


#seperatete records of classes and compute the mean fare
t1=mean(titanic[titanic$Pclass==1,"Fare"])
t2=mean(titanic[titanic$Pclass==2,"Fare"])
t3=mean(titanic[titanic$Pclass==3,"Fare"])
1-pnorm(50,mean(titanic$Age,na.rm=T),
      sd(titanic$Age,na.rm=T))

# other approach
mean(titanic[titanic$Pclass==3,]$Fare)

## Assuming the age is following normal distribution
## What is the propability of a person with age greater than 50

pnorm(50 , mean = mean(titanic$Age,na.rm = TRUE), 
      sd=sd(titanic$Age,na.rm=TRUE), lower.tail = FALSE)






## what is the propability of fiding a person between the age of 40 and 50?
pnorm(50 , mean = mean(titanic$Age,na.rm = TRUE), sd=sd(titanic$Age,na.rm=TRUE))-
pnorm(40 , mean = mean(titanic$Age,na.rm = TRUE), sd=sd(titanic$Age,na.rm=TRUE), lower.tail = T)

### what is 75th percentile age?
quantile(titanic$Age,probs = .75,na.rm = T)

## other approach 
qnorm(.75,mean= mean(titanic$Age,na.rm=T),
      sd=sd(titanic$Age,na.rm = T),lower.tail = T)

## age of the 95% of the people ( lower(2.5%) and upper(97.5%))?
quantile(titanic$Age,probs = c(0.025,0.975),na.rm = T)

## other approach 
qnorm(c(0.025,0.975),
      mean= mean(titanic$Age,na.rm=T), 
      sd=sd(titanic$Age,na.rm = T),lower.tail = T)

## Plot the probability density of age variable 
plot(density(titanic$Age,na.rm = T),
     main = "Age Plot",xlab = "Age",
     ylab = "DEnsity")


###### Compute Z values for Fare variable 
#Z value of Fare =x-mu/ sd
z= (titanic$Fare - mean(titanic$Fare))
/ sd(titanic$Fare)
range(z)
range(titanic$Fare)

#convert fare into std normal value- x-min/ max-min
sdn= (titanic$Fare-min(titanic$Fare))/
  (max(titanic$Fare)- min(titanic$Fare))
range(sdn)

#### Is there a difference in mean age of Males anf Females on Titanic?
## Set a Alternate hypothesis and Null hypothesis 

## Alternate hypothesis is Mean age of Men is greater than mean age of females 

t.test(titanic$Age ~ titanic$Sex, 
       alternative="less")

## What is the propability of survival? 0.38

prop.table(table(titanic$Survived))[2]


## what is the propability of survial for Males?

prop.table(table(titanic[titanic$Sex=="male",
                         "Survived"]))[2]


## what is the propability of survival of females?

prop.table(table(titanic[titanic$Sex=="female",
                         "Survived"]))[2]

## what is the propability of survival for males
##in second class?
prop.table(table(titanic[titanic$Sex=="male" & titanic$Pclass==2,
                         "Survived"]))[2]

## what is the propability of survival for
##females in second class?
prop.table(table(titanic[titanic$Sex=="female" & titanic$Pclass==2,
                         "Survived"]))[2]

## compute the odss of survival of Males  0.1889
prop.table(table(titanic[titanic$Sex=="male","Survived"]))[2]

## compute the odds of survival for females 0.7420382
prop.table(table(titanic[titanic$Sex=="female","Survived"]))[2]

## Odds ratio of survival of males vs females ?
prop.table(table(titanic[titanic$Sex=="male","Survived"]))[2]/
  prop.table(table(titanic[titanic$Sex=="female","Survived"]))[2]


## Perfrom hypothesis testing on survival of Males vs Survival of females 
options(scipen = 999) ## to convert scientific notation to normal decimal 
chisq.test(table(titanic$Sex,titanic$Survived))
