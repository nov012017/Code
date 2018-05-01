library(ggplot2)
library(DMwR)
library(caret)
library(reshape2)
install.packages("caret")
hp=read.csv("house_pricing_kaggle.csv")
str(hp)
## Data set analysis
nrow(hp) ## Total Number of Row ## 1460
ncol(hp) ## Total number of Col ## 81
## Univariate analysis 
  ## ID Column
  length(unique(hp$Id))
  ## Conclusion deleting the column "ID" as it has only unique values
  hp$Id<-NULL
  
  ##MSSubClass
  unique(hp$MSSubClass)
  table(hp$MSSubClass)
  #* Converting to FACTOR
  ggplot(hp,aes(MSSubClass))+geom_bar()
  hp$MSSubClass=as.factor(hp$MSSubClass)
  sum(is.na(hp$MSSubClass))
  options(scipen = 999)
  ggplot(hp,aes(MSSubClass,SalePrice))+geom_boxplot()
  
  ##MSZoning
  unique(hp$MSZoning)
  length(unique(hp$MSZoning))
  table(hp$MSZoning)
  sum(is.na(hp$MSZoning))
  ggplot(hp,aes(MSZoning,SalePrice,col=MSSubClass))+geom_boxplot()
  
  chisq.test(table(hp$MSSubClass,hp$MSZoning))
  table(hp$MSZoning)
  
  ## Conclusion: MSZoning and MSSubclass are dependent on each other and hence removing MSSubclass
  hp$MSSubClass<-NULL
  
  ##LotFrontage
    unique(hp$LotFrontage)
    length(unique(hp$LotFrontage))
    table(hp$LotFrontage)  
    hist(hp$LotFrontage)
    hist(log(hp$LotFrontage))
    quantile(hp$LotFrontage,seq(0,1,0.01),na.rm = T)
    summary(hp$LotFrontage)
    sum(is.na(hp$LotFrontage))
    # Replace with Central Tendancy Imputation which is not acceptable
    hp[is.na(hp$LotFrontage)==1,c("LotFrontage")]= round(mean(hp$LotFrontage,na.rm=T))
    ggplot(hp,aes(MSSubClass,LotFrontage))+geom_boxplot()
    
    
  ##LotArea
    length(unique(hp$LotArea))
    summary(hp$LotArea)
    #cor_vars<-hp[,c("LotArea","LotFrontage")]
    #trans<-cor(cor_vars)
    melted_cormat <- melt(trans)
   ## Conclusion: Lot Area and LotFrontage is not linear and hence we should consider these two vairables
    hist(hp$LotArea)
    quantile(hp$LotArea,seq(0,1,0.01))
    summary(hp$LotArea)
    #hp$LotArea_Bin=cut(hp$LotArea,breaks = c(0,1,5,100),labels = c("low","medium","high"))
    hp$LotArea_Bin = ifelse(hp$LotArea <=5000.00,'Low',
                            ifelse(hp$LotArea>5000.00 & hp$LotArea<=10000.00,'Medium',
                                   'High'))
    ggplot(hp,aes(LotArea_Bin))+geom_bar()
    
  ##Street
    ggplot(hp,aes(Street))+geom_bar()
    ggplot(hp,aes(Street, SalePrice))+geom_boxplot()
    
#***********************************#