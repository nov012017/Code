## Analysis on movielens datasets 

setwd("D:/AP/Visualization/ml-100k")
users = read.csv("u.user", sep="|", header = F, encoding = "latin-1" ) #

## Set columnames to the file 
names(users) = c('user_id', 'age', 'sex', 'occupation', 'zip_code')

## ratings data file 

ratings = read.csv("user.txt", sep = "\t", header=F, encoding = "latin-1")

## set desired names for ratings file 
names(ratings) = c('user_id', 'movie_id', 'rating', 'unix_timestamp')

## movies information 
movie_file_names = c('movie_id', 'title', 'release_date', 'video_release_date', 'imdb_url')

movies = read.csv("u.item", sep="|", header=F, encoding = "latin-1" ) #
## REMOVE THE EXTRA VARIABLES

movies = movies[ , 1:5]

movie_file_names = c('movie_id', 'title', 'release_date', 'video_release_date', 'imdb_url')

### need only first 
names(movies) = movie_file_names

## merge all three files 
## MOVIES AND RATINGS FILE USING MOVIE ID 
MV_RATINGS = merge( ratings, movies , by = "movie_id")
### movies with rating and users by user id 
MV_RATINGS_USR = merge( MV_RATINGS,  users , by = "user_id")

## IF required delet the other files after merging all the files )
ls() ## lists all the current objects in the session 
rm( "movies", "ratings", "users") ## removes all the objects in the session 

MV_RATINGS_USR$dummy = 1
### exploration 


 tab = aggregate( MV_RATINGS_USR$dummy , by=list(unique.values = MV_RATINGS_USR$title) , FUN = sum )
 
 head(tab)
 
 names(tab)
 
tab =  tab[order(tab$x, decreasing =TRUE), ]

tab2 = aggregate(MV_RATINGS_USR$rating, by=list(MV_RATINGS_USR$title), FUN=mean )

names(tab2)
tab2 = tab2

names(tab)


###merge number of ratings with avg rating 

movies_num_avg_rtng = merge(tab, tab2, by.x = "unique.values", by.y = "Group.1")
movies_num_avg_rtng
names(movies_num_avg_rtng) = c("movie_name", "total_rating", "avg_rating")


ggplot(movies_num_avg_rtng, aes(total_rating, avg_rating)) + geom_point()

names(MV_RATINGS_USR)


library(lubridate)

MV_RATINGS_USR$year = as.numeric(substr(MV_RATINGS_USR$release_date, 8, 11))
head(MV_RATINGS_USR$year)



MV_RATINGS_USR$year_of_release = year(MV_RATINGS_USR$release_date)


year_avg = aggregate(MV_RATINGS_USR$rating, by=list(MV_RATINGS_USR$year), FUN=mean)
 
head(year_avg)

## deleting the first record to avoid 971(which is a typo)

year_avg = year_avg[-1,]

names(year_avg ) = c("Year", "avg_rating")

ggplot( year_avg, aes(Year, avg_rating)) + geom_point()


