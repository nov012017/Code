data("mtcars")
data=mtcars

summary(mtcars)

str(mtcars)

distmat=dist(as.matrix(mtcars))

as.matrix(distmat)

hierclust=hclust(distmat)

library(titanic)
View(titanic_train)
