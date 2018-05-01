#Condition Statements
#Loops

age=25
if (age<=25) {
  age_group='0-25'
} else if (age >25 & age <=35) {
  age_group='26-35'
} else if (age >35 & age <=45) {
  age_group='35-45'
} else age_group='45+'

age_group



age=c(10,20,30,40,50)
age_group=''
for(i in 1:length(age)){
  if (age[i]<=25) {
    age_group[i]='0-25'
  } else if (age[i] >25 & age[i] <=35) {
    age_group[i]='26-35'
  } else if (age[i] >35 & age[i] <=45) {
    age_group[i]='35-45'
  } else age_group[i]='45+'
}
age_group
setwd("C:/Users/Admin/Desktop/Analytics Path/R/Data")
df1=read.csv(file="train_loan.csv",header=T, sep=",", stringsAsFactors = F)
View(df1)
length(df1$ApplicantIncome)
ApplicantIncomeRange=''
for(i in 1:length(df1$ApplicantIncome)){
if(df1$ApplicantIncome[i]<=150){
  df1$ApplicantIncome[i]=0
}
#df1$ApplicantIncome[i]=ifelse(df1$ApplicantIncome[i]=0,150,df1$ApplicantIncome[i])
if(df1$ApplicantIncome[i]<=5000){
  df1$ApplicantIncomeRange[i]='Less than or equal to 5000'
}else if (df1$ApplicantIncome[i] >5000 & df1$ApplicantIncome[i] <=10000){
  df1$ApplicantIncomeRange[i]='Greater than 5000 and less than 10000'
}else df1$ApplicantIncomeRange[i]='Greater than 10000'
}

?quantile
# To replace a particular value with a specific value
df$age=ifelse(df$age<0,0,df$age)

for (i in 1:nrow(df1$ApplicantIncome)) {
  df1$ApplicantIncome[i]=ifelse(df1$ApplicantIncome[i]=0,"150",df1$ApplicantIncome[i])
}

nrow(df1)
