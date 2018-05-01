library(MASS)
b=Boston

str(b)

## Missing Value
sum(is.na(b))

## Validating the continuous data #####
hist(b$crim)
quantile(b$crim,seq(0,1,0.01))
library(ggplot2)
ggplot(b,aes(1,crim))+geom_boxplot()

summary(b$crim)

View(b)
boxplot.stats(b$crim)
stats