##############################################################################
# R Session						                                                       #
# Date:  20/08/2017									                                         #
# Author: Manish                              							                 #	
##############################################################################



################################################################################################

#Matrix

##Create a Name Matrices
##Matrix is a big brother of vector
##Vector: 1D array of data element
##Matrix: 2D array of data element - One atomic vector type
##matrix is a natuaral extension of Vector going from 1D to 2D

## TO build a matrix, we use matrix() function
matrix(1:6,nrow=2)
matrix(1:6,ncol=3)

matrix(1:3,nrow=3,ncol=3)
matrix(1:3,ncol=3,nrow=2)

matrix(1:4,nrow=2,ncol=4)

matrix(1:3,nrow=2,ncol=4)


##There is another easy method to create matrix by binding vectors
##cbind() and rbind() functions can be used.

cbind(1:3,1:3)
rbind(1:3,1:3)

cbind(c(1,2,3,4,5),c(11,12,13,14,15))
rbind(c(1,2,3,4,5),c(11,12,13,14,15))

#by row
matrix(1:6, nrow=2)
matrix(1:6,byrow = TRUE, nrow=2)

m <- matrix(1:6,byrow = TRUE, nrow=2)
rbind(m,7:9)
cbind(m,c(10,11))
m

##Naming a Matrix using rownames() and colnames()
rownames(m) <- c("row1","row2")
colnames(m) <- c("col1","col2","col3")
m

##or use dimnames attribute

m <- matrix(1:6,byrow = TRUE,nrow =2, dimnames = 
              list(c("row1","row2"),c("col1","col2","col3")))
m

#Check if data structure is a matrix
is.matrix(m)


char <- matrix(LETTERS[1:6],nrow = 4,ncol = 3)
char




##Subset element
m <- matrix(sample(1:15, 12), nrow =3)
m[1,3]

##Select entire row or entire column
m[,1]
m[1,]
m[4]
m[9]

##Subsetting multiple elements
m[1,1]
m[2,1]
m[1,c(2,3)]
m[c(1,2),c(2,3)]


##Subset by name
m <- matrix(1:12,nrow = 3)
rownames(m) <- c("row1","row2","row3")
colnames(m) <- c("col1","col2","col3","col4")

m["row1","col2"]

#############################################################################################

##List
##List is a generic vector containing other objects
##A list is an R-object which can contain many different types of elements inside it 
#like number,string, vector and even anohter list inside it. 
#A list can also contain a matrix or a function as it's element
##The list is created using list().

list1 <- list(c(2,5,3),21.3,sin)
list1

n <- c(2,3,4)
s <- c("aa","bb","cc","dd")
b <- c(T,T,T,F)
x <- list(n,s,b,3)
x
class(x)

##List Slicing
#We retrieve a list slice with a single square bracket "[]" operator.
#Thefollowing is hte slice containing hte second member of x, which is a copy of s

x[2]
x[1]
x[3]

#With the index vector, we can retrieve a slice with multiple members. 
#Here a slice containing the second and fourth member
x[c(2,4)]

##Member Reference
#In order to reference a list member directly, we have to use the double square bracket "[[]]" operator
#The following object x[[2]] is a second member of x. x[[2]] is a a copy of s, but is not a slice 
#containing s

x[[2]]
x[2]


#We can modify it's content directly
x[[2]][1] <- "ta"
x
x[[4]] <- 4
x
x[[4]][1] <- 3
x
x[[4]][2] <- 4
x

s##s is uneffected

#Naming the list elements, is List is already created 
fil <- c("First","Second","Third","Forth")
names(x) <- fil

##We can assign name to list member and reference them by names instead of numeric indexes
v <- list(Sam=c(2,3,4),Mike = c("aa","bb"))
v

##We can retrieve a list slice with the single square bracket "[]" operator. 
##Here is the list of slice containing a member of v named "bob"

v["Sam"]

##With the index vector, we can retrieve a slice with multiple members. 
##Here is the list slice with both members of v. 
##Notice how they are reversed from their original position in v

v[c("Sam","Mike")]


##Member Reference
#In order to reference a list member directly, we have to use a double square bracket "[[]]" operator
v[["Sam"]]


#The named list member can also be referenced directly with the "$" operator
v$Sam

##Search Path Attachement
#We can attach a list to the R search path and access its members without explicitly mentioning
#the list
attach(v)
Sam
detach(v)



##Accessing List element
# Create a list containing a vector, a matrix and a list.
list_data <- list(c("Jan","Feb","Mar"), 
                  matrix(c(3,9,5,1,-2,8), nrow=2),
                  list("green",12.3))

# Give names to the elements in the list.
names(list_data) <- c("1st Quarter", "A_Matrix", 
                      "A Inner list")

# Access the first element of the list.
print(list_data[1])


# Access the thrid element. As it is also a list, all its elements will be printed.
print(list_data[3])
print(list_data[3][[1]])
print(list_data[3][[1]][[1]])
print(list_data[3][[1]][[2]])

print(list_data[[c(3,1)]])
print(list_data[[c(3,2)]])

# Access the list element using the name of the element.
print(list_data$A_Matrix)
print(list_data$A_Matrix[2,3])


##Manipulating List elements
##We can add, delete and update list elements. we can add elements only at the 
##end of the list. But we can update any element

# Create a list containing a vector, a matrix and a list.
list_data <- list(c("Jan","Feb","Mar"), 
                  matrix(c(3,9,5,1,-2,8), nrow=2),
                  list("green",12.3))

# Give names to the elements in the list.
names(list_data) <- c("1st Quarter", "A_Matrix", 
                      "A Inner list")

# Add element at the end of the list.
list_data[4] <- "New element"
print(list_data[4])

# Remove the last element.
list_data[4] <- NULL


# Print the 4th Element.
print(list_data[4])

# Update the 3rd Element.
list_data[3] <- "updated element"
print(list_data[3])

list_data[2] <- NULL
print(list_data)


##Merging List
#Create two list
list1 <- list(1,2,3)
list2 <- list("Sun","Mon","Tue","Wed")

#Merge the two list
merge.list <- c(list1,list2)
merge.list
length(merge.list)

##Converting a list to vector
list1 <- list(1:5)
print(list1)



##COnvert the list into vector
v1 <- unlist(list1)

v1
class(v1)
class (list2)

v3 <- list(1:5,"mon")
v3

v4 <- unlist(v3)

v4

##############################################################################################

##Create a dataframe

name = c("Anne", "Pete", "Cath", "Cath", "Cath")
age = c(28,30,25,29,35)
child <- c(FALSE,TRUE,FALSE,TRUE,TRUE)
df <- data.frame(name,age,child)
df
class(df)
typeof(df)

##NAme DataFrame
names(df) <- c("Name","Age","Child")

##Dataframe Structure
str(df)

df$Name



##############################################################################################

##Catagorical Varaible
##Limited number of different values
##Belong to Category
#In R : factor

blood <- c("A","B+","O","AB","O")
blood
class(blood)
blood_factor <- factor(blood)
blood_factor
class(blood_factor)
str(blood_factor)


############################################################################################
#          Data Structures in R Ends
#               By end to this exercise you will be able to understand:
#                  What are different types of Data Structures in R
#                  What are Vectors,Matrix,List Dataframe
#                    How to create them, How to access data structure
#                    How to manipulate
#                  What are factors and when and how to use it.  
############################################################################################


############################################################################################
#                                     
#                 ***********INTERVIEW QUESTION****************
#
#   Difference between mode, class and typeof
#       Mode represents how an object is stored in memory (numeric,character, list etc)
#       class represents its abstract type
#   Why dataframe consider categorical datatype as factors?
#   Difference between Vector, Matrix,List
#   Difference between Matrix and Array
#   How can I craete vectors dynamically instead of using c()
#   Difference between LIst and Paired List?
############################################################################################

##Difference between mode and class
a <- data.frame(Test= c(10,11))
class(a) 
mode(a)
typeof(a)

#As dataframe stored in memory as list but they are wrapped into dataframe object

#Usually typeof() and mode() usually give the same information BUT not always

typeof(c(1,2))
mode(c(1,2))

#The R specific function typeof returns the type of an R object
#Function mode gives information about the mode of an object in the sense of 
#Backer, Chambers and Wilks (1988), and is more compatible with ohter implementation of the
#S language. http://stat.ethz.ch/R-manual/R-devel/doc/manual/R-lang.html#Objects

#Infinite Values
inf<- 2/0
is.infinite(inf)
