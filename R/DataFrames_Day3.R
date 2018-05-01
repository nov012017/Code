# Create a dataframe with name as emp

id=c(1,2,3,4,1)
name=c("Pru","Div","Prudiv","Honey","Pru")
salary=c(10,20,30,40,50)


employee=list(id,name,salary)

emp=data.frame(id, name,salary)
emp
#to list the column names
colnames(emp)
#To change the column name
names(emp)[1]="emp id"
names(dfa)[1]="Gender"
#To list the column names
names(emp)
#To change the column names in a bluck using vector
names(emp)=c("ID","NAME","SALARY")
names(emp)
#To view the result set in a different tab in a tabular format
View(emp)
# To retrive the specific consecutive rows
emp[1:2,]
# To retrive the specific random rows
emp[c(1,3),]
# To retrive the consecutive columns
emp[,1:2]
#To retrive the specific columns
emp[,c(1,3)]
emp[c(1,4),2]
#To change the data type of a column in the data frame
dfa$Education=as.factor("Education")
str(dfa)
class(emp)
emp[,1]
class(emp[1])
emp$id
class(emp$id)
class(emp$name)
#To convert factor variable into a character variable, because it character will be by default treated as a factor
emp$name=as.character(emp$name)
emp[c(1,4),c("id","name")]
View(emp[c(1,4),c("id","name")])

#Attach the dataframe to our environment
attach(emp)
id
name
detach(emp)
ID
#to get the present working directory
getwd
#Importing the files from the working directory
setwd("C:/Users/Admin/Desktop/Analytics Path/R/Data")
df1=read.csv(file="train_loan.csv",header=T, sep=",", stringsAsFactors = F)
str(df1)
df1=read.csv()
df1=read.csv(file="loan.csv",header=T, sep=",")
names(df1)
df1$Gender
df1[c(1,4),c(1,2)]
#To find the total number of rows in the excel file
nrow(df1)
#To find the total number of columns in the excel file
ncol(df1)
#To find the dimensions of a file rows*columns
dim(df1)
#To find the structure of the file
str(df1)
#To find the first 6 lines of a file
head(df1)
#To find the last lines of a file
tail(df1)
#Deleting a column from the data frame
df1$Column3=NULL
colnames(df1)
class(df1)
df1$Column2
##To find the total number of levels present in the column
nlevels(df1$Column2)

df1[1,2]
##---------------------------------------------------------------##
a<-array(c('green','yellow','red','white','Blue','orange','Purple','marron','grey','pink','black'),dim=c(3,3,3))
print(a);
class(a)

################################################################################################################
#Data subsetting

head(train_loan)
View(head(train_loan,10))

df1[c(1:2),c(1:2)]
df1[,(1:2)]

dfa=df1[,c(2,3,5)]
