setwd("D:\\Data science  notes\\ml-100k")
getwd()
users=read.csv("u.user",sep = "|",header = F,encoding = "latin-1")
str(users)
head(users)

names(users)=c('user_id','age','sex','occupation','zip_code')

ratings = read.csv("user.txt", sep = "\t", header=F, encoding = "latin-1")

names(ratings) = c('user_id', 'movie_id', 'rating', 'unix_timestamp')

## movies information 

movies = read.csv("u.item", sep="|", header=F, encoding = "latin-1" )

movie_file_names = c('movie_id', 'title', 'release_date', 'video_release_date', 'imdb_url')

names(movies) = movie_file_names 

movies = movies[ , 1:5]

movie_file_names = c('movie_id', 'title', 'release_date', 'video_release_date', 'imdb_url')
### need only first 
names(movies) = movie_file_names

MV_RATINGS = merge( ratings, movies , by = "movie_id")
MV_RATINGS
head(MV_RATINGS)

MV_RATINGS_USR = merge( MV_RATINGS,  users , by = "user_id")
head(MV_RATINGS_USR)

MV_RATINGS_USR$dummy = 1
tab = aggregate( MV_RATINGS_USR$dummy , by=list(unique.values = MV_RATINGS_USR$title) , FUN = sum )


head(tab)

names(tab)

tab =  tab[order(tab$x, decreasing =TRUE), ]

tab2 = aggregate(MV_RATINGS_USR$rating, by=list(MV_RATINGS_USR$title), FUN=mean )

names(tab2)
tab2 = tab2

names(tab)
library(ggplot2)

movies_num_avg_rtng = merge(tab, tab2, by.x = "unique.values", by.y = "Group.1")

names(movies_num_avg_rtng) = c("movie_name", "total_rating", "avg_rating")

##install.packages("lubridate")
library(lubridate)


MV_RATINGS_USR$release_date
MV_RATINGS_USR$year = as.numeric(substr(MV_RATINGS_USR$release_date, 8, 11))
head(MV_RATINGS_USR$year)

ggplot(movies_num_avg_rtng, aes(total_rating, avg_rating)) + geom_point()

names(MV_RATINGS_USR)
############################################################
##multiple linear regression
 
library(MASS)
data("Boston")
Boston
View(Boston)
str(Boston)
summary(Boston)

hist(log(Boston$medv))
summary(sqrt(Boston$medv))



Boston$med_sqrt=sqrt(Boston$medv)

##plots
plot(Boston$lstat,Boston$medv)
cor(Boston$lstat,Boston$medv)

fit1=lm(med_sqrt~lstat,data = Boston)
fit1
summary(fit1)
abline(fit1)
plot(fit1)
names(fit1)
hist(fit1$residuals)
summary(fit1$residuals)
plot(fit1)
lm()
fit0=lm(medv~lstat,data = Boston)
summary(fit0)
abline(fit0)
plot(fit0)
names(fit0)
hist(fit0$residuals)
summary(fit0$residuals)

##outliers-----# 
mean(Boston$med_sqrt)+3*sd(Boston$med_sqrt)
mean(Boston$med_sqrt)-3*sd(Boston$med_sqrt)

Boston$med_sqrt=sqrt(Boston$medv)

##plots
plot(Boston$lstat,Boston$medv)
cor(Boston$lstat,Boston$medv)

lm=lm()