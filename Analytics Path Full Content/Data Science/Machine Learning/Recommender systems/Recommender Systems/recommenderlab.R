#Load the package and prepare a dataset
install.packages("recommenderlab")
library("recommenderlab")

# https://www.rdocumentation.org/packages/recommenderlab/versions/0.2-1

data("MovieLense")
#The format of MovieLense is an object of class "realRatingMatrix"
# https://www.rdocumentation.org/packages/recommenderlab/versions/0.2-1/topics/realRatingMatrix

## look at the first few ratings of the first user
head(as(MovieLense[1,], "list")[[1]])

### use only users with more than 100 ratings
MovieLense100 <- MovieLense[rowCounts(MovieLense) >100,]
MovieLense100

#Train a UBCF recommender using a small training set
train <- MovieLense100[1:50]
rec <- Recommender(train, method = "UBCF")
rec

#Create top-N recommendations for new users (users 101 and 102)
pre <- predict(rec, MovieLense100[101:102], n = 10)
pre

as(pre, "list")
