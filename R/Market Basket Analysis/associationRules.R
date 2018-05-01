df = read.csv('Groceries_wide.csv')
library(arules)
df$id = as.factor(df$id)

library(reshape2)

df_new = dcast(df,id~product,length)
write.csv(df_new, 'C:/Users/phsivale/Documents/Trainings/Groceries_wide.csv')
rm(df)
### data
str(df_new)
df_new = read.csv('C:/Users/phsivale/Documents/Trainings/Groceries_wide.csv')

for(i in 1:ncol(df)){
  df[,i] = as.factor(df[,i])
}

str(df)

df$id = NULL
df$whole.milk=NULL
df$other.vegetables=NULL
library(arules)

##Converting to Transactions Object
df_trans = as(df,'transactions')
inspect(head(df_trans,6))


##creating rules
rules = apriori(df_trans,
                parameter = list(supp = 0.005,
                                 confidence=0.7,
                                 target ='rules'))#"frequent itemsets"

inspect(head(rules,20))

rulesdf = as(rules,'data.frame')

## Subsetting Rules
rules_beer = subset(rules,subset = rhs %pin% "beer")
inspect(rules_beer)
