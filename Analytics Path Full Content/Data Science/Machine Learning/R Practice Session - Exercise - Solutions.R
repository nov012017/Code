##################### R-Programming Exercises for Classroom Practice ###########################
##################################### ANALYTICS PATH  ##########################################

# Dataset being used is "train.csv" unless explicitly specified
#Generate example dataframe with character column
##train=read.csv("D:\\train_ap.csv")
##setting path for train.csv
setwd("D:\\Data science  notes\\R exercise data")
getwd()
train<-read.csv("train.csv",stringsAsFactors = F)
str(train)


# 1.	How do we convert "4+" in "Stay_in_current_city_years" variable  to a value of 4?
train$Stay_In_Current_City_Years=as.character(train$Stay_In_Current_City_Years)
train$Stay_In_Current_City_Years=ifelse(train$Stay_In_Current_City_Years=="4+",4,train$Stay_In_Current_City_Years)

# 2.	How many rows exist with a marital_status = 0?
nrow(train[train$Marital_Status==0,])

# 3.	How many rows exist within the age_group of "26-35" with a marital status =0?
nrow(train[(train$Age=="26-35"& train$Marital_Status==0),])

# 4.	How many distinct users exist within the age_group of "26-35" with a marital status =0?
a=train[(train$Age=="26-35"& train$Marital_Status==0),]
length(unique(a$User_ID)) 

# 5.	How many distinct age groups exist?
length(unique(train$Age))

# 6.	How many distinct User_IDs exist?
length(unique(train$User_ID))

# 7.	Which product_ID occurs the most frequently?
a=data.frame(table(train$Product_ID))
names(a)=c("prod_id","freq")
b=a[order(a$freq,decreasing = T),]
b[1,1]

# 8.	What is the average purchase rate of gender = f & gender = m?
aggregate(train$Purchase,list(train$Gender),mean)

# 9.	What is the average value of purchase when gender = f or age_group = "0-17"
mean(train[(train$Gender=="F"|train$Age=="0-17"),"Purchase"])

# 10.	What is the average value of purchase within the odd rows of train.csv?
mean(train[seq(1,nrow(train),2),"Purchase"])

# 11.	create a new dataset (train2) that does not have any row in train.csv that has  missing value
train2= na.omit(train)


# 12.	In which city_category do most of the users within age group "0-17" live?
c=data.frame(table(train[train$Age=="0-17","City_Category"]))
d=c[order(c$Freq,decreasing = T),]
d[1,1]

# 13.	For how many rows is "Product_category_2" missing a value?
sum(is.na(train$Product_Category_2))

# 14.	Which value of "Product_category_1" occurs the most whenever product_category_2 value is missing?
m=data.frame(table(train[is.na(train$Product_Category_2),"Product_Category_1"]))
m=m[order(m$Freq,decreasing = T),]
m[1,1]

# 15.	Of all the users that exist in "test.csv", how many of them, also exist in "train.csv"
# 16.	Of all the users in "train.csv" how many of them also exist in "test.csv"
# 17.	What is the average purchase of customers who exist in "train.csv" but not in "test.csv"

# 18.	How many distinct combinations of "user_id" & "Product_id" are available in train.csv?
length(unique(paste(train$User_ID,train$Product_ID,sep="_")))

# 19.	Among all the variables from "Gender" to "Product_Category_3":
# A)	Calculate the average purchase rate for all the distinct values of each variable
for(i in 1:11)
{
  print(colnames(train[i]))
  a=aggregate(train$Purchase,list(train[,i]),mean)
  print(a)
}

# B)	identify the variable that has the highest lift in purchase rate
# (For example, if city has 3 distinct values (A,B,C) with average purchase rate of 	100,200,300 & overall average of 200 - lift is (300/200 - 100/200) 
# i.e., (highest average value/ overall average purchase - lowest average value/ 	overall average purchase)

#  20.	Write a function that takes variable name as input & gives out the frequency of occurrence table of the distinct values of the variable


#  21.	Write a function that takes variable name & creates dummy variables:
#  For example, if we give age as input to the function, then the function creates 7 	distinct 	columns named Age_0-17, Age_55+ so on.,
#  For each of the 7 columns, it gives a value of 1 to the row if the value belongs to the 	column - i.e., Age_0-17 will be 1 only if Age = "0-17" else it is a 0.
  
### create a placeholder a for dummy variable for  variable b 
a=data.frame(id=rep("",len=length(b)))
  
### dummy function 
  dummy = function(y){for(level in unique(y)){
    a[paste("dummy", level, sep = "_")] <- ifelse(y == level, 1, 0)
  }
    return(a)
  }
  
#  example : 
   b=c("m","f","m","f","m")
  dummy(b)
  
  
  
  