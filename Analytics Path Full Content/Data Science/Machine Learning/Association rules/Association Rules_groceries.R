df = read.csv('D:/Data Science/Machine Learning/Association rules/Groceries.csv')
library(arules)
head(df)
df$id = as.factor(df$id)

library(reshape2)
df_new = dcast(df,id~product,length)
write.csv(df_new, 'D:/Data Science/Machine Learning/Association rules/Groceries_wide.csv')
rm(df)
### data
str(df_new)
df_new = read.csv('D:/Data Science/Machine Learning/Association rules/Groceries_wide.csv')


for(i in 1:ncol(df_new)){
  df_new[,i] = as.factor(df_new[,i])
}

df_new$id = NULL

library(arules)

##Converting to Transactions Object
df_trans = as(df_new,'transactions')
inspect(head(df_trans,6))


##creating rules
rules = apriori(df_trans,parameter = list(supp = 0.0001,confidence=0.5,
                                          target = "rules"))#"frequent items"
inspect(head(rules,20))

## Subsetting Rules
rules_beer = subset(rules,subset = rhs %pin% "beer")
inspect(rules_beer)
