matrix(1:4,nrow=2,ncol=4)
m<-matrix(1:4,byrow=T,nrow=2,ncol=4,dimnames = list(c("row1","row2"),c("col1","col2","col3","col4")))


cbind(1:3,1:3)
rbind(1:3,1:3)

a=c(1,2,3)
b=c("a","b","c")
names(a)

rownames(m) <- c("row1","row2")
colnames(m) <- c("col1","col2","col3","col4")
m

cbind(a,b)

#SAMPLE
#LETTERS

###############################List###############################

a=c(1,2,3)
b=c("a","b","c")
c=c(T,T,T,F)
X<- list(NAME=a,NAMEB=b,c,3,sin(a))
X

class(X)
typeof(X)


X[1]
X[2]
X[3]
X[4]
X[[3]]
X[[2]][1] <- "PR"
X$NAME
