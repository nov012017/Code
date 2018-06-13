##############################################################################
# R Session						                                                       #
# Date:  19/08/2017									                                         #
# Author: Manish                              							                 #	
##############################################################################

##############################################################################
# This Session will cover:
#        Different Datatypes in R and basic functions
#        Different Data Structure in R and basic functions
##############################################################################

##R is an interpreted language, not a compiled one, meaning that all commands 
##typed on the keyboard are directly executed without requiring to build a 
##compiled program like in most computer languages

##All the actions of R are done on objects stored in the active memory of
##the computer: no temporary files are used

################################################################################
#          Data Types in R  (Atomic Data type:) Starts
#               Logical, Numeric,Integer, Character, Complex
################################################################################

##R has following datatypes:
#1. Logical
#2. Numeric
#3. Integer
#4. Character
#5. Complex
#6. raw


##Logical Datatype
x <- TRUE
class(x)
TRUE
class(TRUE)
FALSE
#R is case sensitive
false = 3
false
class(false)

class(FALSE)
class(NA)
y<-T
class(y)
class(T)
class(F)
T
F

##Numeric
2
2.5
class(2)
class(2.5)

2L##integer
class(2L)

is.numeric(2)
is.numeric(2L)

is.integer(2)
is.integer(2L)






##integers are numeric but not all numeric are integers

##Character
"I love data science"
class("I love data science")
class("2")
class(2)


##coercion Function to convert one type to another
as.numeric(FALSE)


as.character(4)
as.numeric("4.5")
as.integer("4.5")
as.numeric("hi")


#Complex Values (complex numbers with real and imaginary part)
z = 1 + 2i     # create a complex number 
z              # print the value of z 
class(z)       # print the class name of z 
sqrt(-1)       # square root of -1 
sqrt(-1+0i)    # square root of -1+0i 
sqrt(as.complex(-1)) 

##Extract Real Component of a Complex Number
Re(z)

##Extract Imaginary Component of a Complex Number
Im(z)


#The modulus and argument are also called the polar coordinates.
#If z = x + i y with real x and y, for r = Mod(z) = √(x^2 + y^2), 
#and φ = Arg(z), x = r*cos(φ) and y = r*sin(φ).

#Modulus of a Complex Number
Mod(z)

#Argument of a complex  Number - φ
Arg(z)

##
v <- charToRaw("Hello")
class(v)
v
#######################################################################################
#          Data Types in R  (Atomic Data type:) Ends
#               By end to this exercise you will be able to understand:
#                  What are Boolean Data type
#                  What are Numeric Data type
#                  What are Integer Data type  
#                  Difference between Numeric and Integer Data type
#                  How to check what is the data type of a varaiable
#                  Convert one data type into another data type (coercion Function)
#                  What are Complex Data type 
######################################################################################

################################################################################
#          Data Structure in R  - Starts
#               Vector
#                 What are Vectors?
#                 How to create a Vector?
#                 How to check if datastructure is vector?
#                 How to give name to a vector?
#                 Vectors manipulation?
################################################################################

## Vector: Sequence of data element of same basic datatype
##Create a vector --> we need c() which allows combine values to a vector

c("heart", "diamond", "spades", "diamonds", "spades")
##We can assign this to some varaible
draw_suite <- c("heart","diamonds","spades","diamonds","spades")
draw_suite
class(draw_suite)
is.vector(draw_suite)

## you can also create a vector of Numeric
remain <- c(11,12,11,13)
remain
class(remain)

## you can also create a vector of Integer
remain_another <- c(11L,12L,11L,13L)
remain_another
class(remain_another)

remain
##This is not very informative, we need to give names to each card type.
##names() can help us to do that




suite <- c("heart","diamonds","spades","clubs")
names(remain) <- suite
remain

##Another way to create Name Vector
remain1 <- c(heart = 11, diamonds = 12, spades = 11, clubs = 13)
remain1

remain2 <- c("heart" = 11, "diamonds" = 12, "spades" = 11, "clubs" = 13)
remain2

is.vector(remain)

##Single Value = Vector
my_apple <- 5
my_oranges <- "six"

is.vector(my_apple)
is.vector(my_oranges)

length(my_apple)
length(my_oranges)

length(draw_suite)

basket1 <- c(12,4,4,6,9,3)
basket2 <- c(5,3,2,2,12,9)

more<-basket1>=basket2 #logical vector- vectorized operations
more

#comparison operator
c(1,2,3,4,5,6)<=3
temp <- c(1,2,3,4,5)
temp1 <- c(2,3,0,0,0)
temp <= temp1

##vector are homogenous
#Only one element of same type
##Coercion for vectors

draw_ranks <- c(2,3,5,6,"k")
draw_ranks
class(draw_ranks)

x <- 0:5
x

sum(x)

#Total Number of records that satisfies the condition
sum(x>1)

sum(x[x>3])
sum(x[x<3])

c(1,2,3,4,5,6)<=3

x[x>3]
x<3

sort(x,decreasing = FALSE)
sort(x,decreasing = T)
sort(x)

sort(x)[2:3]
sum(sort(x)[2:3])

##Trimming the Vector

x <- c(1,2,3,4)
x[1]
x[4]
x[-1]
x[-1:-2]
x[c(-2,-4)]

#Dynamically creating a vector instead of using c()
##scan(file,what)
colors_new = scan('',what='')
colors_new = scan('',what=integer())
colors_new = scan('')
