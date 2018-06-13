

##Clustering Assignment

#.	Use the Iris dataset
#.	Remove the categorical columns and retain only numerical columns.
#.	Find the outliers and remove them
#.	Standardize the dataset
#.	Find the optimal value of K
#.	Run the K mean algorithm for (optimal K -1), (Optimal K) and (Optimal K + 1)
#.	Perform the cluster Analysis




##Solution

head(iris)

temp <- iris[-5]
head(temp)
df <- data.frame(temp)
str(df)

df_scale <- data.frame(scale(df))

sapply(df, mean)
sapply(df_scale, mean)
sapply(df_scale, sd)

r_sq<- rnorm(20)


for (number in 1:20){clus <- kmeans(df_scale, centers = number, nstart = 50)
r_sq[number]<- clus$betweenss/clus$totss
}

plot(r_sq)

Km <- kmeans(df_scale, centers = 4, nstart = 50)

RFM_km <-cbind(df,Km$cluster)

colnames(RFM_km)[5]<- "ClusterID"

library(dplyr)
library(ggplot2)

km_clusters<- group_by(RFM_km, ClusterID)

tab1<- summarise(km_clusters, Mean_S_Len=mean(Sepal.Length), Mean_S_Width=mean(Sepal.Width), Mean_P_Length=mean(Petal.Length), Mean_P_Width=mean(Petal.Width))

ggplot(tab1, aes(x= factor(ClusterID), y=Mean_S_Len,fill = factor(ClusterID))) + geom_bar(stat = "identity")
ggplot(tab1, aes(x= factor(ClusterID), y=Mean_S_Width,fill = factor(ClusterID))) + geom_bar(stat = "identity")
ggplot(tab1, aes(x= factor(ClusterID), y=Mean_P_Length,fill = factor(ClusterID))) + geom_bar(stat = "identity")
ggplot(tab1, aes(x= factor(ClusterID), y=Mean_P_Width,fill = factor(ClusterID))) + geom_bar(stat = "identity")

