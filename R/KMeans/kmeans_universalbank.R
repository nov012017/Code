bank<-read.csv(file = "UniversalBank.csv", sep = ",", header=T)
bank$Experience=NULL
str(bank)

clust <- kmeans(x=data,centers=4)