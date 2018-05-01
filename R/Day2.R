## Data Types
  a=10
## To change the datatype
  class(a)
## Type Casting
  a=as.integer(a)
    class(a)
    typeof(a)
    ?typeof
    
##Explicity stating the R to assing the data type as an integer
a=10L
  typeof(a)
###Numeric Datatype
a=10.5
class(a)

a=as.integer(a)
class(a)

#Create a character object

a="Prudhviraju, Divya"
class(a)

# Logical Data types
a=T
class(a)
##Verifying a data type using the prebuild functions

is.character(a)


#################### Data Structures ############################
#One Dimensional
#Vector
a=c(1,2,3,4,5)
class(a)
a=as.integer(a)
class(a)
##Subsetting vetors
a[1]
## ":" is a operator in R
a[1:3]

##Adding elements to a vector
a[6]=60

##Replace a particular element
a[5]=50
##Eliminnating the first elements
a=a[-(1:3)]

