df = read.csv('D:/Data Science/Machine Learning/UniversalBank.csv')
library(arules)
library(arulesViz)
library(rattle)

head(df)
View(df)
str(df)
ncol(df)
df$ID=NULL
names(df)
df_new<-df[9:13]
View(df_new)
df_new
df_new[df_new == 0] <- NA



for(i in 1:ncol(df_new)){
  df_new[,i] = as.factor(df_new[,i])
}

##Converting to Transactions Object
df_trans = as(df_new,'transactions')
inspect(head(df_trans,6))

##Distribution of data
itemFrequencyPlot(df_trans,topN=20,type="absolute")


##creating rules
rules = apriori(df_trans,parameter = list(supp = 0.001,confidence=0.6,
                                          target = "rules"))#"frequent items"
rules <- sort(rules, by='confidence', decreasing = TRUE)

summary(rules)
#inspect(head(rules,20))
inspect(rules[1:20])

#itemFrequencyPlot(df_trans,topN=20,type="absolute")

#Ploting top rules
topRules <- rules[1:10]
plot(topRules)

#graph
plot(topRules, method="graph")

plot(topRules, method = "grouped")
 