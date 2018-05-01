getwd()
library("MASS")
data("Boston")
View(Boston)

#Output variable
hist(Boston$medv)
boxplot(Boston$medv)

summary(Boston$medv)
Boston$medv_log=log(Boston$medv)
summary(Boston$medv_log)
Boston$lstat_sqrt=sqrt(Boston$lstat)
View(Boston)
write.csv(Boston,"Boston.csv")
rows=1:nrow(Boston)
trainRows=sample(rows,round(0.7*nrow(Boston)))
testRows=rows[-trainRows]

cor(Boston[,c("medv","lstat")])

mod1=lm(medv_log ~ Boston$lstat_log, data=Boston$lstat_sqrt)
summary(mod1)

mod1=lm(medv ~ lstat,data=Boston)
summary(mod1)
