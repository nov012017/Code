setwd("D:\\Data Science\\Machine Learning\\R exercise data")
getwd()
train<-read.csv("train.csv",stringsAsFactors = F)
str(train)


#ifelse(test,yes,no)
train$Stay_In_Current_City_Years<-ifelse(train$Stay_In_Current_City_Years=="4+",4,train$Stay_In_Current_City_Years)
train$Stay_In_Current_City_Years
#2
df<-train[train$Marital_Status==0,]
nrow(df)
nrow(train[train$Marital_Status==0,])
length(df)
str(df)
#3
nrow(train[train$Age=="26-35"&train$Marital_Status==0,])
#dplyr approach
filter(train,Age==26-35& Marital_Status==0)

df1<-filter(train,train$Marital_Status==0,train$Age=="26-35")
length(df1)
#4
df2<-train[train$Age=="26-35"& train$Marital_Status==0,]
df2
unique(df2$User_ID)
length(unique(df2$User_ID))
#5
a<-unique(train$Age)
length(a)
distinct(train["Age"])
length(df3)
#6
length(unique(train$User_ID))

distinct(train["User_ID"])
#7
View(train)

df1<-data.frame(table(train$Product_ID))
df1
order(df1,decreasing = TRUE)
df1[1,1]

sort(table(train$Product_ID),decreasing = T)[1]

View(train)
##27/11
nrow(train)

filter(train,train$Gender)
filter(train,train$Gender==M,train$Gender==F,)

df7<-train[train$Gender=="M",]
df7
mean(df7$Purchase)

mean(train[seq(1,nrow(train),2),"Purchase"])

train2=na.omit(train)
##Q:14
c=data.frame(table(train[train$Age=="0-17","City_Category"]))
d=c[order(freq.decresing=T,)]
d[1,1]

aaa <-function(a){
  #b=list()
  b<-data.frame(table(a))
  #names(a)=c("pro_id","freq")
 # b=a[order(a$freq,decreasing = T),]
  return(b)
}

aaa(train$Product_ID)
aaa()

test[paste()]

##30/11
getwd()

