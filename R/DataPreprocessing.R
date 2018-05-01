v=c(10,20,30,40,50,NA)
is.na(v)
mean(v,na.rm=T)
v[is.na(v)]=mean(v,na.rm = T)
v

## Data frame
library(titanic)
data("titanic_train")
head(titanic_train)

##Identify variables on missing value
sum(is.na(titanic_train$Age))
table(is.na(titanic_train$Age))

sum(is.na(titanic_train$Fare))

mean_age=mean(titanic_train$Age,na.rm=T)

titanic_train$Age[is.na(titanic_train$Age)]=mean_age


##Grouping or binning variables
 #"0-20","20-25","25-30"


hist(titanic_train$Age)

titanic_train$Age=cut(titanic_train$Age,breaks = c(0,10,20,25,30,40,50,60))
View(titanic_train$Age)

for(i in 1:length(titanic_train$Age)){
  if(titanic_train$Age[i]<=20){
    titanic_train$AgeGroup[i]="0-20"
  }else if (titanic_train$Age[i]>20 & titanic_train$Age[i]<=25){
    titanic_train$AgeGroup[i]="21-25"
  }else if (titanic_train$Age[i]>25 & titanic_train$Age[i]<=30){
    titanic_train$AgeGroup[i]="25-30"
  }else if (titanic_train$Age[i]>30 & titanic_train$Age[i]<=40){
    titanic_train$AgeGroup[i]="30-40"
  }else if (titanic_train$Age[i]>40 & titanic_train$Age[i]<=50){
    titanic_train$AgeGroup[i]="40-50"
  }else  titanic_train$AgeGroup[i]="30-40"
}
warnings()
titanic_train[,c("Age","AgeGroup")]
View(titanic_train)
View(titanic_train)
hist(titanic_train$AgeGroup)
barplot(titanic_train$AgeGroup)
#Zscore

#Scaling age variable as ZScore scaling

titanic_train$Age_ZScaled=scale(titanic_train$Age)
hist(titanic_train$Age_ZScaled)
#Min Max scaling
View(titanic_train$Age_ZScaled)

minmax=function(x){
  return ((x-min(x)/max(x)-min(x)))
}

##min max scaling of age and fare variables

titanic_train$age_minmax=minmax(titanic_train$Age)
