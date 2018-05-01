setwd("C:/Users/Admin/Desktop/Analytics Path/R/Data/R exercise data")
getwd()
train=read.csv(file="train.csv",header = T,sep = ",")
test=read.csv(file="test.csv",header = T,sep = ",")
str(train)
View(train)

##Problem 1 - How do we convert 4+ in "Stay_in_current_city_years" variable to a value of 4?
View(train)
train[is.na(train)]=0
table(train$Stay_In_Current_City_Years_Converted)
train$Stay_In_Current_City_Years_Converted=as.character(train$Stay_In_Current_City_Years)

for(i in 1:length(train$Stay_In_Current_City_Years_Converted)){
  if(train$Stay_In_Current_City_Years_Converted[i]=="4+"){
    train$Stay_In_Current_City_Years_Converted[i]=4
  }else train$Stay_In_Current_City_Years_Converted[i]=train$Stay_In_Current_City_Years_Converted[i]
}

sum(is.na(train$Stay_In_Current_City_Years_Converted))


  train$Stay_In_Current_City_Years_Converted=ifelse(train$Stay_In_Current_City_Years_Converted,"4+",4,train$Stay_In_Current_City_Years_Converted)
  
  #Problem 2: How many rows exists with a marital status=0
  
  nrow(train[train$Marital_Status==0,])
  
  table(train$Marital_Status)[1]

  # Problem 3: How many rows exist within the age_group of "26-35", with marital status as 0?
  nrow(train[(train$Age=="26-35" & train$Marital_Status==0),])

  # Problem 4: How many distinct users exist within the age_group of "26-35" with a marital status as 0
  a=train[train$Age=="26-35" & train$Marital_Status==0,]
  length(unique(a$User_ID))
  
  a=train[Age=="26-35" & Marital_Status==0,]
  length(unique(a$User_ID))

#  Problem 5: How many distinct age groups exists
  train_age_group=train[,c("Age")]
  age_group_disinct=unique(train_age_group)
  age_group_length=length(unique(train_age_group))
  View(age_group_length)

  # Problem 6: How many distinct user_id's exist?
 train_userid=train[,"User_ID"]
 count_userid=length(unique(train_userid))
 print(count_userid)
 
 # Problem 7
 
 a=data.frame(table(train$Product_ID))
names(a)=c("Prodid","Freq")
b=a[order(a$Freq,decreasing = T),]
b
b[1,c(1,2)]

# Problem 8: What is the average purchase rate of gender=f & gender=m
Problem8=train[,c("Gender","Purchase")]
View(Problem8)
library(dplyr)

train %>%
  group_by(Gender) %>%
  summarise(purchaserate=mean(Purchase))

#summarise(group_by(train$Gender),purchaserate=mean(train$Purchase))

aggregate(train$Purchase,by=list(train$Gender),FUN=mean,na.rm=T)

#Problem 9: What is the average value of purchase when gender=f or age group = "0-17"

problem9=train[(train$Gender=="F" | train$Age=="0-17"),"Purchase"]
mean(problem9)
View(problem9)
Problem9_2=train[(train$Gender=="F" | train$Age=="0-17"),]
mean(Problem9_2$Purchase)

problem9_dplyr=filter(train,Gender=="F" | Age=="0-17")
problem9_dplyr %>%
  summarise(purchasevalue=mean(Purchase))

#Problem 10 What is the average value of purchase within the odd rows of train.csv
Problem10=train[seq(1,nrow(train),2),]
mean(Problem10$Purchase)
# Prolem 11: Create a new dataset(train2), that does not have any row in the train.csv that has missing value
Train_without_missingvalue=na.omit(train)
sum(is.na(Train_without_missingvalue))

#Problem 12 In which city_category do most of the users within age group "0-17" live?
View(train)
Problem12=train[(train$Age=="0-17"),c("City_Category")]
View(Problem12)
Problem12_table=data.frame(table(train[(train$Age=="0-17"),c("City_Category")]))
names(Problem12_table)<-c("AgeGroup","Feq")
Problem12_sol=Problem12_table[order(Problem12_table$Feq,decreasing = T),]

Problem12=train[(train$Age=="0-17"),c("City_Category","Age")]
as.character(Problem12$City_Category)
Problem12$City_Category=class(Problem12$City_Category)
Problem12$Age=as.character(Problem12$Age)
class(Problem12$Age)
Problem12_Solu=aggregate(Problem12$City_Category,by=list(Problem12$Age),FUN=max,na.rm=T)

#Problem13: For how many rows is "Product_Category_2" missing a value
Problem13=train[is.na(train$Product_Category_2),"Product_Category_2"]
Problem13=data.frame(Problem13)
length(Problem13)
sum(is.na(Problem13))
class(Problem13)
View(Problem13)

#Problem14:
#Which value of "Preoduct_Category_1" occurs the most when product_category_2 value is missing?
  
 problem14<- train[(is.na(train$Product_Category_2)),"Product_Category_1"]
 problem14<-data.frame(table(problem14))
 View(problem14_sol)
 problem14_sol= problem14[order(problem14$Freq,decreasing = T),]
 problem14_sol[1,2]

 library(dplyr)
 #dolyr
  df1= train %>%
  filter(is.na(Product_Category_2)) %>%
  select(Product_Category_1) %>%
  table()%>%
  data.frame()%>%
  arrange(desc(Freq)) %>%
  filter(row_number()==1)
  View(df1)
  
#Problem14:
inner_join(train,test,by="User_ID")
length(intersect(unique(train$User_ID),unique(train$User_ID)))
View(train)
Problem19:
  for(i in 3:11){
    print(colnames(train[i]))
    a=aggregate(train$Purchase,by=list(train[,i]),mean)
    print(a)
  }

for(i in 3:11){
  print(colnames(train[i]))
  train %>%
    select(Purchase,i) %>%
    a=summarise(group_by(i),mean(Purchase))
    print(a)
}


lift=(max(a$x)-min(a$x))/mean(train$Purchase)