##############################################################################
# R Session						                                                       #
# Date:  28/07/2017									                                         #
# Author: Manish                              							                 #	
##############################################################################

##############################################################################
# This Session will cover:
#        Read data from different Sources 
#        Write Data to different targets
#        Apply Family
#       
##############################################################################


##Setting the Working Directory 
setwd("C:\\Analytics\\Personal\\Machine Learning\\Training\\R\\Dataset")

##Getting the working directory
getwd()

##Read Input file - .csv

#Format: read.csv(file, header = TRUE, sep = ",",stringsAsFactors = F)

#Example
advertising <- read.csv("csv_connection.csv", stringsAsFactors = F)
str(advertising)
advertising <- read.csv("csv_connection.csv", stringsAsFactors = T)
str(advertising)

##Write into CSV file
write.csv(mtcars,"write_csv_demo.csv")
write.csv(mtcars,"write_csv_demo1.csv",row.names = F)

##Read Input file - .xls
#install.packages("xlsx")
library(xlsx)
input_excel <- read.xlsx("Mushroom Subset.xlsx",sheetIndex = 1)

##Read Table: .txt
input_txt <- read.table("house-votes-84.txt",sep=',', 
                        stringsAsFactors = F) #scan
write.table(mtcars,"write_csv_demo1.txt")


##Connect with Database - SQL SERVER
#RSQLSERVER
#RODBC
library(RSQLServer)

####################################################################################
#                              Apply Family
#
####################################################################################
#######################################################################################################
#R Apply Family
######################################################################################################

##The apply() family pertains to the R base package and is populate with functions to manipulate slices
##of data from matrices, list or dataframe in a repetitive way.

##Format of apply is: apply(X,margin,FUN)
##X: is an array or a matrix if 2D
##margin: is a varaiable how the function is applied; 
#margin= 1, it applies over rows
##margin =2 applies over columns. 
#Note when you use margin=(1,2), 
#it applies to both rows and columns.
##FUN : is the function you want to apply to the data. 
#It can be a R function of user defined function.

##Construct a 5*6 matrix
X <- matrix(rnorm(30),nrow = 5,ncol = 6)

##Sum the values of each column with apply()
apply(X,1,sum)
apply(X,2,sum)
apply(X,c(1,2),sum)


X1 = data.frame(X)
Y1 <-apply(X1,1,sum)
Y1


##lapply() can be used to other objects like dataframe, list or vector and the output returned is a list
##Create a list of matrices
Mylist <- list(1:5,20:25)
lapply(Mylist,median)





##The sapply function
#The sapply function work like lapply() but it tries to simplify the output of the most elementry data
#structure that is possible. And indeed sapply() is a wrapper function for lapply()

sapply(Mylist,median)
sapply(Mylist,median,simplify = F)

##The tapply function - work well with factors --like group by in SQL
ages <- c(25,26,31,35,42,46)
location <- c("Urban","Rural","Rural","Urban","Urban","Urban")

tapply(ages,location,mean)
tapply(ages,location)



##################################################################################

#1. How many rows are present in mtcars dataset







nrow(mtcars)
length(mtcars)
length(mtcars$mpg)

#2. How many rows are present 
#in mtcars dataset with cyl = 4



nrow(mtcars[mtcars$cyl==4,])


#3. How many columns are present in mtcars dataset
ncol(mtcars)

##############################################################################################

##Create a dataframe

name = c("Anne", "Pete", "Cath", "Cath", "Cath")
age = c(28,30,25,29,35)
child <- c(FALSE,TRUE,FALSE,TRUE,TRUE)
df <- data.frame(name,age,child)
df
class(df)
typeof(df)

##NAme DataFrame
names(df) <- c("Name","Age","Child")

##Dataframe Structure
str(df)

df$Name



##############################################################################################

##Catagorical Varaible
##Limited number of different values
##Belong to Category
#In R : factor

blood <- c("A","B+","O","AB","O")
blood
class(blood)
blood_factor <- factor(blood)
blood_factor
class(blood_factor)
str(blood_factor)


############################################################################################
#          Data Structures in R Ends
#               By end to this exercise you will be able to understand:
#                  What are different types of Data Structures in R
#                  What are Vectors,Matrix,List Dataframe
#                    How to create them, How to access data structure
#                    How to manipulate
#                  What are factors and when and how to use it.  
############################################################################################


############################################################################################
#                                     
#                 ***********INTERVIEW QUESTION****************
#
#   Difference between mode, class and typeof
#       Mode represents how an object is stored in memory (numeric,character, list etc)
#       class represents its abstract type
#   Why dataframe consider categorical datatype as factors?
#   Difference between Vector, Matrix,List
#   Difference between Matrix and Array
#   How can I craete vectors dynamically instead of using c()
#   Difference between LIst and Paired List?
############################################################################################

##Difference between mode and class
a <- data.frame(Test= c(10,11))
class(a) 
mode(a)
typeof(a)

#As dataframe stored in memory as list but they are wrapped into dataframe object

#Usually typeof() and mode() usually give the same information BUT not always

typeof(c(1,2))
mode(c(1,2))

#The R specific function typeof returns the type of an R object
#Function mode gives information about the mode of an object in the sense of 
#Backer, Chambers and Wilks (1988), and is more compatible with ohter implementation of the
#S language. http://stat.ethz.ch/R-manual/R-devel/doc/manual/R-lang.html#Objects

#Infinite Values
inf<- 2/0
is.infinite(inf)
