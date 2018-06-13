##Conditional statements
##if else
age=10

if(age>18){
  age_group='18+'
}else{
  age_group='0-18'
}
  
age_group

##multiple if else conditions
age=32

if(age<=25){
  age_grp='0-25'
}else if(age>25&age<=35){
  age_grp='26-35'
}else if(age>35 & age<=45){
  age_grp='35-45'
}else age_grp='45+'

age_grp
########################
##loops
age=c(26,39,48,57)

for(i in 1:length(age)){
  
  if(age[i]<=25){
    age_grp[i]='0-25'
  }else if(age[i]>25&age[i]<=35){
    age_grp[i]='26-35'
  }else if(age[i]>35 & age[i]<=45){
    age_grp[i]='35-45'
  }else age_grp[i]='45+'
}
age_grp
#===================================================
df<-data.frame(
id=c(1,2,3,4,5),
age=c(29,34,36,45,56),
gender=c('M','F','M','F','M')
)

df

df$id
#age_group=?

for(i in 1:nrow(df)){
  if(df$age[i]<=25){
    df$age_grp[i]='0-25'
  }else if(df$age[i]>25 & df$age[i]<=35{
    df$age_grp='26-35'
  }else if(df$age[i]>35 & df$age[i]<=45){
    df$age_grp[i]='36-45'
    }else if(df$age[i]>45 & df$age[i]<=55){
      df$age_grp[i]='46-55'  
    }else df$age_grp[i]='55+'
}
  
df
###functions

#table
#prop.table
prop.table()

##sum function
#data = read.csv("D:\\Data science  notes/Churn Data.csv")
data = read.csv("D:\\Data science  notes/Churn Data.csv")
#View(data)
sum()
sd()
mean()

####sorting or ordering
df=data[ order()]
head(churn)
##subsetting using a condition

df_ny=data[data$state=="NY",]

df_ny_nj=data[data$state %in% c("NY","NJ"),]

##is.na function
#is.na(data)
sum(is.na(data))
class(data)
#sort(data$age,decreasing = TRUE)
#str(data)
names(data)

a=aggregate(churn$total.intl.calls,list(churn$churn),mean)
names(a)=c("churn_gr","avg")
a
aggregate(churn$churn,list(churn$state),mean)
##alternate to the for loop
##apply function
apply(churn[,9:18],2,mean)##2 columns and 1 for row wise
apply(churn[,9:12],1,sum)
?lapply
lapply(churn[,9:11],mean)## function over a list or vector
sapply(churn[,9:12],mean)

##packages
#install.packages("RODBC")
library(RODBC)
#detach("RODBC",unload = TRUE)
mydbcon=odbcConnect(dsn= ,uid = ,pwd = )
mydf=sqlQuery(channel =mydbcon,query = )

library(sqldf)
df_sq=sqldf("select * from churn where State='NY'")
df_sq

library(dplyr)
colnames(churn)
##select 
churn2=select(churn, "account.length","area.code")
#churn3=churn$state

##filter
filter(churn,area.code>10)

####The function distinct() in dplyr package can be used to keep only unique/distinct rows 
##from a data frame. If there are duplicate rows, only the first row is preserved.
##It's an efficient version of the R base function unique().
ff<-distinct(churn,account.length)
head(ff)
unique(churn)
duplicated(area.code)
