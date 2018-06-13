##k mean clustering on iris data(inbuilt data set)
#===============================================================
#use iris dataset
#remove categorical columns
     #retain only numerical columns
#find the outliers and remove them
#standardize the dataset
#find the optimal value of k
#run the k mean alg for (optimal k -1),
      #optimal k and optimal k+1
#perform cluster analysis
#===============================================================
myiris<-iris
View(myiris)
names(myiris)
str(myiris)

#plot(myiris,)
sum(is.na(myiris))
#remove categorical column
myiris$Species=NULL
#View(myiris)

#outlier removal
box<-boxplot(iris)
#scaling
myiris_scale<-scale(myiris,)
View(myiris_scale)

#finding optimal value
r_sq<-rnorm(50) 
for(number in 1:50){clus<-kmeans(myiris_scale,
                                 centers = number,
                                 nstart = 50)
r_sq[number]<-clus$betweenss/clus$totss
}

plot(r_sq)
#k means
km<-kmeans(myiris_scale,centers = 2)
str(km)

km<-kmeans(myiris_scale,centers = 3)
str(km)

km<-kmeans(myiris_scale,centers = 4)
str(km)
 