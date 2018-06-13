data("mtcars")
mtcars


distmat = dist(as.matrix(mtcars))

hierclust = hclust(distmat)
plot(hierclust)


clusterCut <- cutree(hierclust, 5)
plot(clusterCut)

mtcars$cluster = clusterCut

aggregate(mtcars,list(mtcars$cluster),mean)





####
data("USArrests")
USArrests
hc <- hclust(dist(USArrests))
plot(hc)

clusterCut = cutree(hc,k=3)
plot(hc)
