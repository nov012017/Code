UB=read.csv(file="UniversalBank.csv")
str(UB)
UB$ID=NULL
UB$ZIP.Code=NULL
UB$CCAvg=NULL
UB$Mortgage=NULL

UB$Age_Dis=ifelse(UB$Age<=10,"0-10",
                  ifelse(UB$Age>10 &UB$Age<=20,"10-20",
                         ifelse(UB$Age>20&UB$Age<=30,"20-30",
                                ifelse(UB$Age>30&UB$Age<=40,"30-40",
                                       ifelse(UB$Age>40&UB$Age<=50,"40-50",
                                              ifelse(UB$Age>50&UB$Age<=60,"50-60",
                                                    ">60"))))))

UB$Exp_Dis=ifelse(UB$Experience<=10,"Junior",
                  ifelse(UB$Experience>10 & UB$Experience<=30,"Mid Level",
                         "Higher Level"))

UB$Income=ifelse(UB$Income<=50,"Small Income Group",
                 ifelse(UB$Income>50 & UB$Income<=150,"Medium Income Group",
                        "Large Income Group"))


### The below are converted to Categorical
UB$Age=NULL
UB$Experience=NULL
UB$Income=NULL

UB$Personal.Loan=as.factor(UB$Personal.Loan)
str(UB)
UB$Securities.Account=as.factor(UB$Securities.Account)
UB$CD.Account=as.factor(UB$CD.Account)
UB$Online=as.factor(UB$Online)
UB$CreditCard=as.factor(UB$CreditCard)
UB$Family=as.factor(UB$Family)
UB$Age_Dis=as.factor(UB$Age_Dis)
UB$Exp_Dis=as.factor(UB$Exp_Dis)
UB$Education=as.factor(UB$Education)
UB[UB$Personal.Loan==0,"Personal.Loan"]<-NA
UB[UB$Securities.Account==0,"Securities.Account"]<-NA
UB[UB$CD.Account==0,"CD.Account"]<-NA
UB[UB$Online==0,"Online"]<-NA
UB[UB$CreditCard==0,"CreditCard"]<-NA
## 
#install.packages("arules")
library(arules)
df_trans = as(UB,'transactions')
inspect(head(df_trans,10))
View(df_trans)


rules = apriori(df_trans,
                parameter = list(supp = 0.1,
                                 confidence=0.7,
                                 target ='rules'))

rulesdf = as(rules,'data.frame')
rulesdf

str(UB)
