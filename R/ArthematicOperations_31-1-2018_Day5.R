#Operations
  #Arthematic (addition, subtraction, multiplication, divison and power)
  #Comparision (Greater than, less than, greater than or equal, less than or equal , not equal)
  #Logical (and, or, not)

# Comparision operator will always result is a boolean

#Arthematic Operations
a=20
c=30
a+b 
a-b
a*b
a/b
a**2
a^2

#Vectors with equal length
a=c(10,20,30,40)
b=c(1,2,3,4)
a+b
 
#Vector with un equal length
a=c(10,20,30,40)
b=c(1,2)
a-b

#Vector with un equal length
a=c(10,20,30,40,50)
b=c(1,2)
a/b

#Comparision Operators
a=20
b=30
 a>b
 a<b
 a<=b
 a>=b
 a!=b
 a==b
 
 setwd("C:/Users/Admin/Desktop/Analytics Path/R/Data")
 df1=read.csv(file="train_loan.csv",header=T, sep=",", stringsAsFactors = F)
 View(df1)
 df1_male_equal=df1[ df1$Gender == "Male",]
 df1_male_InOperator=df1[ df1$Gender == "Male" & df1$Property_Area %in% c("Rural","Semiurban"),]
 View(df1_male)
               