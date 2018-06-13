matrix(1:6,nrow = 2)
matrix(1:6,ncol = 3)

cbind(1:3,1:3)
rbind(1:5,1:5)

matrix(1:3,nrow = 3,ncol=2)

m<-matrix(1:6,byrow = TRUE,nrow = 2) 
rbind(m,7:9)
cbind(m,c(10,11))
m

rownames(m)<- c("row1","row2")
colnames(m)<- c("col1","col2","col3")

##or use dimnames

char<-matrix(LETTERS[1:6],nrow = 4,ncol = 3)
char

m<-matrix(sample(1:15,12),nrow = 3)
m

m[,1]
m[1,]

m[4]

m[1,1]
m[3,4]

n<-matrix(m[1],m[10],m[3],m[12])
n

list1<-list(c(2,5,3),5.5,sin)
list1

n<-c(2,3)
s<-c("ll","jj")
x<-list(n,s,88)
x
class(x)

x[1]

x[[2]] 

v<-list(sam=c(2,3,4),mike=c("aa","bb"))
v
v$sam
v["sam"]
v["sam","mike"]


list1<-list(1,2,3)
list2<-list("sun","mon","tue","wed")
merge.list<-c(list1,list2)
merge.list
length(merge.list)

list1<-list(1:5)


##dataframes
  
name<-c("Anne","pete","cath","cath","cath")    
age<-c(28,30,25,29,35)
child<-c(FALSE,TRUE,FALSE,TRUE,TRUE)
df<-data.frame(name,age,child)
df

 200%/%11

5==6
5!=9
5!=5
5<=9

a<-5
b<-7
if((a>3)&(b>3))
print("True")


factorial(5)
 
round(1234,-1)
round(12345,-3)
round(15,-1)

x=5.565545445466
signif(x,digits = 3)
floor(x)
ceiling(x)
trunc(x)

runif(10)  ##between 0 and 1
sin(0)

seq(1:10)
seq(10:1)

seq(10,0,-2)
rep(6,4)
rep(c(11,12,13),3)

rep(c(11,12,13),each=2,3)

##sorting,ranking and ordering

sales<-c(100,50,75,150,200,25,30)
sales
rank<-rank(sales)
rank
sorted<-sort(sales)
sorted
ordered1<-order(sales)
ordered1
view<-data.frame(sales,rank,sorted,ordered1)
view


sports<-c("cri","footb","baseb")
psports<-c("rugby","cric",)


a<-c("aa","bb")
b<-
  
  
X<-c("apple","potato","grape")  
grep(a,X)

substr()
chartr()

ifelse
if(){
  
}else if(){
  
}else()

loops............
_________________________
repeat loop..

v<-c("hello","loop")
cnt<-2
repeat{
  print(v)
  cnt=cnt+1
  if(cnt>5){
    break
  }
}

#while loop

v<-c("hello","loop")
cnt<-2
while(cnt>7){
  print(v)
  cnt=cnt+1
}

for loop...
----------
  
v<-LETTERS[1:4]
for(i in v){
  print(i)
}

#nested for loop
  
nested_for<- matrix(nrow = 10,ncol = 5)  
for(i in 1:dim(nested_for)[1]){
for(j in 1:dim(nested_for)[2]){
nested_for[i,j]=i*j
  }
}


library()
search()

##packages
-----------
#1.ggplot
#2.plyr/dplyr
#3.sqldf
#4.reshape/reshape2
  


install.packages("dplyr")
library(dplyr)
data(mtcars)
head(mtcars)
str(mtcars)
view(mtcars)

  