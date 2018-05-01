getwd()
insurance=read.csv(file="insurance.csv", sep=",", header=T)
library(psych)
## Function
zscore<-function(x){
  zscore1=x-mean(x)/sd(x)
  return(zscore1)
}
#Working with target variable
summary(insurance$charges)
hist(log(insurance$charges)) ## some what normaly distributed
insurance$charges=log(insurance$charges)

#INPUT VARIABLE Age
summary(insurance$age)
hist(insurance$age)
class(insurance$children)
cor(insurance[,c("age","children")])
pairs.panels(insurance[,c("age","bmi","children")])
ggplot(insurance,aes(charges,age))+geom_point()
insurance$age_zscore=zscore(insurance$age)

# Input variable BMI
summary(insurance$bmi)
hist(insurance$bmi)
ggplot(insurance,aes(1,bmi))+geom_boxplot()
insurance<-insurance[insurance$bmi>(mean(insurance$bmi)-3*sd(insurance$bmi)) & insurance$bmi <(mean(insurance$bmi)+3*sd(insurance$bmi)),]
insurance$bmi_zscore=zscore(insurance$bmi)

## Input variable children
#convert to categorical
str(insurance)
install.packages("dummies")
library(dummies)
insurance_dummy=dummy.data.frame(insurance)
View(insurance_dummy)
insurance_dummy=insurance_dummy[-c(3,6,8)]
par(mfrow=c(2,2))
## Input variable Sexfemale
class(insurance_dummy$sexfemale)
insurance_dummy$sexfemale1=as.factor(insurance_dummy$sexfemale)

## Input variable smokeryes
class(insurance_dummy$smokeryes)
insurance_dummy$smokeryes=as.factor(insurance_dummy$smokeryes)

## Input variable regionnorthwest
insurance_dummy$regionnorthwest=as.factor(insurance_dummy$regionnorthwest)

## Input variable regionsoutheast
insurance_dummy$regionsoutheast=as.factor(insurance_dummy$regionsoutheast)

## Input variable regionsouthwest
insurance_dummy$regionsouthwest=as.factor(insurance_dummy$regionsouthwest)

## Transformation
insurance_dummy$age.bmi<-insurance_dummy$bmi/insurance_dummy$age

##Sampling
rows= 1:nrow(insurance_dummy)
trainRows = sample(rows,round(0.7*nrow(insurance_dummy)))
testrows<-rows[-trainRows]
traindata<-insurance_dummy[trainRows,]
testdata<-insurance_dummy[testrows,]



mod2=lm(charges~.-age-bmi-charges,data=traindata)
summary(mod2)
plot(mod2)

mean(insurance$bmi)

chisq.test(table(insurance$sex,insurance$smoker))
options(scipen = 999)
t.test(insurance$charges,insurance$bmi, alternative = "two.sided")
t.test(insurance$charges,m=13816,alternative = "less")
mean(insurance$charges)
sd(insurance$charges)
str(insurance$charges)

a<-c(1,2,3,4,5)

t.test(a,m=1,alternative = "greater")
