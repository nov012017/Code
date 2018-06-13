##exercise

#dataframe
# Create the data frame.
emp.data <- data.frame(
  emp_id = c (1:5), 
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25), 
  
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
                         "2015-03-27")),
  stringsAsFactors = FALSE
)

print(emp.data)


#install.packages("titanic")
library(titanic)
data("titanic_train")

summary(titanic_train$Age)
summary(titanic_train$Fare)
var(titanic_train$Age,na.rm = T)
sd(titanic_train$Age,na.rm = T)
var(titanic_train$Fare)

mean(titanic_train$Age,na.rm = TRUE)
mean(titanic_train$Fare)
sd(titanic_train$Fare)

IQR(titanic_train$Age,na.rm = T)
IQR(titanic_train$Fare,na.rm = T)
str(titanic_train)
View(titanic_train)

#7
sample(titanic_train,500,replace = T)
sample(1:nrow(titanic_train),500)
titanic_train[sample(1:nrow(titanic_train),500),]
#8
aggregate(titanic_train$Fare,by=list(titanic_train$Pclass),FUN=mean,na.rm=T)
#9
mean(titanic_train$Fare,by=list(titanic_train$Pclass),na.rm=T)
mean(titanic_train[titanic_train$Pclass==1,"Fare"])
mean(titanic_train[titanic_train$Pclass==2,"Fare"])
mean(titanic_train[titanic_train$Pclass==3,"Fare"])
#11
mean(titanic_train$Age,na.rm = T)
sd(titanic_train$Age,na.rm = T)
pnorm(50,mean = 29.69,sd=14.5,lower.tail = F,log.p = FALSE)
pnorm(50,
      mean(titanic_train$Age,na.rm = T),
      sd(titanic_train$Age,na.rm = T),
      lower.tail = F)
#12
pnorm(50,
      mean(titanic_train$Age,na.rm = T),
      sd(titanic_train$Age,na.rm = T),
      lower.tail = T)-
  pnorm(40,
        mean(titanic_train$Age,na.rm = T),
        sd(titanic_train$Age,na.rm = T),
        lower.tail = T)

#13
quantile(titanic_train$Age,0.75,na.rm = T)
#14:age of the 95% of the people(lower(2.5%)and upper(97.5%))
mm<-titanic_train$Age
quantile(titanic_train$Age,c(0.025,0.975),na.rm = T)

#15:Plot the probability density of age variable.
plot(density(titanic_train$Age,na.rm = T))

#16:Compute Z values for Fare variable.
?z
##
mode(titanic_train$Age)
actual_mode<-table(titanic_train$Age)
length(actual_mode)
names(actual_mode)[actual_mode==max(actual_mode)]

new_data<-subset(titanic_train,titanic_train$Pclass==1)
new_data

mu<-mean(titanic_train$Fare)
mu
sd1<-sd(titanic_train$Fare)
sd1
##function
z.test2=function(a,b,n){
  
}
##16
x<-titanic_train$Fare
mean(titanic_train$Fare)
sd(titanic_train$Fare)
z<-(titanic_train$Fare-mean(titanic_train$Fare))/sd(titanic_train$Fare)
z
mean(z)
range(z)
range(titanic_train$Fare)
options(scipen = 999)
##17
min(x)
##mm=minmax
mm<-(x-min(x))/(max(x)-min(x))
mm
range(mm)
#18
t.test(titanic_train$Age,titanic_train$Sex, alternative ="less",getOption("na.action"))
?t.test

##18,19,20
t.test(titanic_train$Age~titanic_train$Sex,alternative="less")
t.test(titanic_train$Age~titanic_train$Sex,alternative="greater")
##21
length(titanic_train$Survived)
table(titanic_train$Survived)/length(titanic_train$Survived)
##other way of getting probability directly
prop.table(table(titanic_train$Survived))
prop.table(table(titanic_train$Survived))[2]

#22
##t<-titanic_train[titanic_train$Sex=="male",titanic_train$Survived]
##table(t)
prop.table(table(titanic_train[titanic_train$Sex=="male","Survived"]))[2]

##23
prop.table(table(titanic_train[titanic_train$Sex=="female","Survived"]))[2]
##24
prop.table(table(titanic_train[titanic_train$Sex=="female"&titanic_train$Pclass=="2","Survived"]))[2]
##25
prop.table(table(titanic_train[titanic_train$Sex=="male"&titanic_train$Pclass=="2","Survived"]))[2]
##26
##same as 22
##27 same as 23
##28
##odds ratio que: 22/23
prop.table(table(titanic_train[titanic_train$Sex=="male","Survived"]))[2]/
  prop.table(table(titanic_train[titanic_train$Sex=="female","Survived"]))[2]
##29
table(titanic_train$Sex,titanic_train$Survived)
chisq.test(table(titanic_train$Sex,titanic_train$Survived))
##h0:gender is independent of survival
##ha:gender is dependent on survival
##p-value is less than 0.05(5%)
##go with alternative hypo.
hist(titanic_train$Age)
