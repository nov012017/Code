##############################################################################
# R Session						                                                       #
# Date:  24/07/2017									                                         #
# Author: Manish                              							                 #	
##############################################################################

##############################################################################
# This Session will cover:
#        Operations 
#        Basic Building Functions. 
#        Conditional Statements
#        Loops 
##############################################################################


##Basic Operations
# Assignment:
# This is denoted by "<-" or "="
x <- 6
x = 6

#2. Arithmetic
#+, - , *, /, %%,  

#Addition
3+3

#Subtraction
5-2

#Multiplication
3*2

#Division
6/2
200/11

##Modulo
200 %/% 11 #quotient
200 %% 11  #remainder

3%/%3
3%%3

500%/%5
500%%5

#3. Relational
# >=, <=, ==, !=
5 >= 3
5 <= 3
5 == 3
5!= 3

#4. Logical
# |, &

a  <- 5
b <- 7
if ((a >3 )&(b>3))
  print("True")


if ((a >3 )|(b>3))
  print("Hi")


if ((a >10 )|(b>3))
  print("True")

if ((a >10 )&(b>10))
  print("True")


#5. Model Formula (~)

#6. List Indexing ($)

name = c("Anne", 
         "Pete", 
         "Cath", 
         "Cath", 
         "Cath")
age = c(28,30,25,29,35)
child <- c(FALSE,TRUE,FALSE,TRUE,TRUE)
df <- data.frame(name,age,child)
names(df) <- c("Name","Age","Child")

df$Name


#7. Create a sequence (:)
1:5


##Two or more expression on the same line separated by ';' 
1+1 ; 2*3





######################################################################################################
#                                  Build in Function
######################################################################################################
#formatC(x, format="f", digits=10)


x <- 4.6123888888888888
y <- 104.12343543
n <- 2
log(x) #log to base e of x
exp(x)
log(x,n) #log to base n of x
log10(x) #log to base 10 of x
sqrt(x)
factorial(4)

##Rounding Functions
#Although R can calculate accurately upto 16 digits, you dont always want to use that many 
#digits. In that case you can use couple of functions in R to round numbers
print(round(x,digit=3))

format(round(x,10),nsmall = 10)

#a <- round(x,digit=10)
#paste(as.numeric(a))
#print(a)

options(digits = 15)
round(x,digit=12)

# you can also use the round() to round numbers to multiple of 0,10,100...
#For that you just need to add a negative number as a digit argument
round(y,digit=-1)
round(y,digit=-2)

round(1234,digit = -1)
round(1234,digit = -2)
round(1234,digit = -3)
round(1234,digit = -4)


round(12,digit = -1)
round(15,digit = -1)


#If you want to specify the number of significant digits to be retained, regardless of the 
#size of the number, you use the signif()
signif(x,digit = 6)
signif(y,digit = 9)
signif(y,digit = 3)
signif(y,digit = 2)
signif(y,digit = 1)
signif(y,digit = -1)
signif(y,digit = -6)



#Contrary to round(), three other functions always round in the same direction:

floor(x)  #generate Greatest integer < x
ceiling(x) #generate smallest integer > x
trunc(x) #Closest integer between x and 0
trunc(-123.99)
trunc(123.99)
trunc(123.01)

runif(10)##Generate random numbers between 
#0 and 1 from a uniform distribution (constant prob)

cos(x);sin(x);tan(x)


abs(-2)

##Generating Regular Sequence of Numbers

1:10
seq(1:10)

##use the seq function to go from 0 upto 5 in step of 0.5
seq(5,0,-.5)

##Repeat or Replication
x <- rep(6,4)
x

x <- rep('a',4)
x

rep(c(11,12,13),3)

rep(1:2,3)

rep(c(11,12,13),each=2)
rep(c(11,12,13),each=2,3)

##Sorting, Ranking and Ordering
sales <- c(100,50,75,150,200,25,30)
sales
rank <- rank(sales)#rank tells you what order the numbers are in.
rank
sorted <- sort(sales)
sorted
ordered1 <- order(sales)
ordered1
view <- data.frame(sales,rank,sorted,ordered1)
view


##use %in% and which()
##To match between one character vector and another
sports <- c("cricket","football","basketball","baseball","XYZ")
popularsports <- c("rugby","cricket","badminton","football",
                   "baseball","Tennis","basketball")
which(sports%in%popularsports)
which(popularsports%in%sports)
sports[which(sports%in%popularsports)]


##Use paste function
##The R function to concatenate several strings into one string
a <- c("server","client")
b <- c("1","2","3","4","5")
paste(a,b,sep = "")
paste(a,b)




#Use grep function for pattern matching
##THis function searches for matches to pattern within each element of a character
##vector and return as integer vector of elements of the vector that contain a match

X <- c("apple","potato","grape",10)
grep("a",X)
grep("a",X,value = T)
grep("[[:digit:]]",X,value= T)
grep("[[:digit:]]",X)

##Search a special characters
s <- c("A","B","C*","D","E*")
grep('\\*', s)
grep('\\*', s,value = T)



##Using substr - to portion an index of a string
word <- "apple"
substr(word,start=2,stop=4)



##Using the chartr to translate the list of characters to the corresponding characters

word <- "AppleA"
chartr(old = "A",new="a",word)
chartr(old = "A",new="a","Apple")


chartr(old = "Ap",new="am","AppleAp")

##############################################################################
#
#                  if ; is-else ; switch operators 
#
##############################################################################
#Control commands are the commands that enable the program to take decisions
#YOu can also see these control flow by invoking ?Control

?Control

#if example
x <- 30L
if(is.integer(x)){
  print("X is an integer")
}




#if-else
x <- c("what","is","truth")

if("Truth" %in% x){
  print("Truth is found in first time")
} else if ("truth" %in% x) {
  print("truth is found in second time")
} else {
  print("No truth found")
}


#Switch: A switch statement allows a varaible to be 
#tested for equality against a list of value
#Each value is called a case and the varaible 
#being switched on is checekd for each case.

#switch(statement,list)


switch("color", "color" = "red", "shape" = "square", "length" = 5)
switch("shape", "color" = "red", "shape" = "square", "length" = 5)
switch("length", "color" = "red", "shape" = "square", "length" = 5)

###################################################################################################

##Loop in R
#Repeat Loop
#while Loop
#For loop
###################################################################################################
#Syntax:
   #repeat{
   #Statement
  #}
#Tip: In the Statement block, you must use the break statement to exit the loop

#Example
v <- c("Hello","Loop")
cnt <- 2
repeat{
  print(v)
  cnt = cnt+1
  if (cnt >5){
    break
  }
}



#While Loop
#While loop evaluate the test and then enter in the body of the loop.

   #Syntax:
   # while (test expression)
   #{
   # statement
   #}

#Example   
v <- c("Hello","while loop")
cnt <- 2
while (cnt < 7){
  print(v)
  cnt = cnt + 1
}


#For Loop
#A for loop is used to iterate over a vector

#for (val in Vector)
#{
#  statement
#}

#Examples

v <- LETTERS[1:4]
for ( i in v) {
  print(i)
}

for ( i in 1:10) {
  print(i)
}

##Nested FOR loop
Nested_for <- matrix(nrow = 10,ncol = 5)
for(i in 1:dim(Nested_for)[1]) {
  for(j in 1:dim(Nested_for)[2]) {
    Nested_for[i,j] = i*j
  }
}

Nested_for


##############################Difference Between For Loop and While Loop######################
#
#           While loop is used in situation where we do not know how many times
#           loop needs to be executed beforehand
#
#           For loop is used where we already know about the number of times loop
#           need to be executed. TYpically index is used in iteration
#
# Example While Loop:
#      Suppose you are making a game, in which you ask the player to input a number, if 
#      that number is positive number, then the game continues, and you perform some action
#      inside the body of the loop, but if user enters a zero then it means that user wants
#      to quit the game, so you want to stop the loop. In this scenario while loop will be a good
#     choice since you do not know how many times user wants to execute the loop
#


#Example of For loop:
#     Suppose you want to write a program, that takes a digit and gives it's table upto 10
#     times. Then using the For loop will be the good choice, since you already know
#     that loop needs to be executed 10 times.


##############################Difference Between Repeat and While Loop######################
#Repeat loop is similar to while loop, but body in the repeat loop
#executes atleast once, no matter what the result of the condition.

v <- c("Hello","Loop")
cnt <- 10
repeat{
  print(v)
  cnt = cnt+1
  if (cnt >5){
    break
  }
}


##Break v/s Next:

x <- 1:5

for (val in x) {
  if (val == 3){
    next
  }
  print(val)
}