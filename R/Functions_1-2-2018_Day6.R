##Data Preparation
View(summary(df1))
str(df1)
df1$Loan_Status=as.factor(df1$Loan_Status)

#Functions
summary(df1)
##Table function is used to know the stats of a factor column
table(df1$Loan_Status)
##table function can be two dimensional, the out of the below function table is called contigency table
table(df1$Loan_Status,df1$Property_Area)
table(df1$Loan_Status)[1] # It will give the first column in the above output
##Prop.table will convert in to proportions
prop.table(table(df1$Loan_Status))
prop.table(table(df1$Loan_Status,df1$Property_Area)) # Proportions
b=prop.table(table(df1$Loan_Status,df1$Property_Area))# Multiplying with 100 will give percentage
class(b)
c=as.data.frame(b)
c
###############Missing Value ############################
d=c(1,2,3,4,5,NA)
e=c(1,2,3,4,5,NA)
class(e)
is.na(e) ##False,False, False, False,False,True
sum(is.na(d)) # 1
sum(is.na(df1))
df1[is.na(df1)]=0 # Replace all the missing values in a data frame with 0 at a single step
################ Replacing the NA values ##########################
d[is.na(d)]=0
d


##Additional Packages
  #sqldf
  #RODBC
  
install.packages("RJDBC", dependencies = T)
library(sqldf)

myconn = odbcConnect()
df_sql=sqlQuery(channel, query="")

library("RJDBC")
jdbcDriver =JDBC("oracle.jdbc.OracleDriver",classPath="C:/Users/Admin/Desktop/Analytics Path/R/Softwares/ojdbc6.jar")
jdbcConnection =dbConnect(jdbcDriver, "jdbc:oracle:thin:@//database.hostname.com:port/service_name_or_sid", "username", "password")
con <- dbConnect(jdbcDriver, " jdbc:oracle:thin:@localhost:1521:orcl", "SYSTEM","SYSTEM")
