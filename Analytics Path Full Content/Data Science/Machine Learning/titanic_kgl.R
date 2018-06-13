
library('dplyr') # data manipulation
library('ggplot2') # Data Visualization
library('ggthemes') # Data Visualization

options(warn = -1)
# load train.csv
setwd("D:\\Data science  notes\\Titanic")
getwd()
train <- read.csv('train.csv', stringsAsFactors = F)
# load test.csv
test  <- read.csv('test.csv', stringsAsFactors = F)
# combine them as a whole
test$Survived <- NA
full <- rbind(train,test)
full
head(full)
str(full)


##3:data cleaning

# Process Age Column

# create a new data set age
age <- full$Age
#age
n = length(age)
#n
##age[2]##age of second passenger
#full$Age
#na.omit(full$Age)
# replace missing value with a random sample from raw data
set.seed(123)
for(i in 1:n){
  if(is.na(age[i])){
    age[i] = sample(na.omit(full$Age),1)
  }
}

# check effect
par(mfrow=c(1,2))
hist(full$Age, freq=F, main='Before Replacement', 
     col='lightblue', ylim=c(0,0.04),xlab = "age")
       
hist(age, freq=F, main='After Replacement', 
     col='darkblue', ylim=c(0,0.04))

##cabin
# Process Cabin Column to show number of cabins passenger has
cabin <- full$Cabin
n = length(cabin)
for(i in 1:n){
  if(nchar(cabin[i]) == 0){
    cabin[i] = 0
  } else{
    s = strsplit(cabin[i]," ")
    cabin[i] = length(s[[1]])
  }
} 
table(cabin)

# process fare column

# check missing
full$PassengerId[is.na(full$Fare)]
##ggplot
library(ggplot2)

ggplot(full[full$Pclass == '3' & full$Embarked == 'S', ], 
       aes(x = Fare)) +
  geom_density(fill = '#99d6ff', alpha=0.4) + 
  geom_vline(aes(xintercept=median(Fare, na.rm=T)),
             colour='red', linetype='dashed', lwd=1)

