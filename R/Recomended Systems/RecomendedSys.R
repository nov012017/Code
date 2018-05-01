users=read.csv("u.user",sep="|",header = F)

colnames(users)=c("Userid","Age","Gender","Occupation","Zipcode")

ratings=read.csv("u.data",sep="\t",header = F)

names(ratings)=c("User_id","Movie_id","Rating","Unix_TimeStamp")

movies=read.csv("u.item",sep = "|" ,header = F)

movie_file_names=c("movie_id","title","release_date","video_relase_date",
                   "imdb_url","unknown","action","adventure","animation",
                   "Children","Comedy","Crime","Documentary","Drama",
                   "Fantasy","Film-Noir","Horror","Musical","Mystery",
                   "Romance","Sci-fi","Thriller","war","western")

names(movies)=movie_file_names

genre_matrix <- movies[,6:24]


binaryrating <- ratings
for(i in 1:nrow(binaryrating)){
  if(binaryrating[i,3]>3){
    binaryrating[i,3]<-1
  }
  else{
    binaryrating[i,3]<- -1
  }
}
#install.packages("reshape2")
library(reshape2)
binaryrating <- dcast(binaryrating,Movie_id~User_id,value.var="Rating",na.rm=F)

binaryrating2=binaryrating[,-1]

result=matrix(0,9,934)
for (c in 1:ncol(binaryrating2)){
  for (i in 1:ncol(genre_matrix)){
    result[i,c]<-sum((genre_matrix[,i])*(binaryrating2[,c]))
  }
}

