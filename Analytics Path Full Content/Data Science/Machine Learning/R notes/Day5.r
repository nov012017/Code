##############################################################################
# R Session						                                                       #
# Date:  26/07/2017									                                         #
# Author: Manish                              							                 #	
##############################################################################

##############################################################################
# This Session will cover:
#        R Packages 
#        Functions 
#        User Defined Functions
#       
##############################################################################


##Packages are the collection of functions
##They are stored in the "library" in the R env.

## Check available path
.libPaths()

##Get the list of all packages installed
library()

##Get the packages currently loaded in te R environment
search()

##Install a package

##Load Package to Library
##Before the package can be used in the code, it must be loaded in the
##current R environment.

## Important Packages to be considered.
#1. ggplot
#2. plyr/dplyr
#3. sqldf
#4. reshape/reshape2

##########################################dplyr Starts##################################################

#dplyr is a new package which provides a set of tools for efficiently 
#manipulating datasets in R. dplyr is the next iteration of plyr, 
#focussing on only data frames. 
#dplyr is faster, has a more consistent API and should be easier to use.

##Handy dplyr Verb:
#Filter --> filter()
#Select --> select()
#Arrange --> arrange()
#Mutate --> mutate
#Summarise --> summarise()
#Group By --> group_by()

#Structure:
# First Argument is a DataFrame
# Subsequent Argument say what to do with Data Frame
# Always return a Data Frame

########################################################################################################

#install.packages("dplyr")
library(dplyr)
data()
data(mtcars)
head(mtcars)
str(mtcars)
View(mtcars)

#local_df <- tbl_df(mtcars)
#View(local_df)

#1. Filter or subset
#Base R approach to filter dataset
mtcars[mtcars$cyl==8 & mtcars$gear==5,]
#Use subset function
subset(mtcars,mtcars$cyl==8 & mtcars$gear==5)

#dplyr approach
#You can use "," or "&" to use and condition
filter(mtcars,cyl==8,gear==5)
filter(mtcars,cyl==8&gear==5)

filter(mtcars,cyl==8|cyl==6)

##You can use the %in% operator
filter(mtcars,cyl %in% c(6,8))


##Converting row names into column
temp <- mtcars
temp$myNames <- rownames(temp)
filter(temp,cyl==8,gear==5)

#2. Select: Pick columns by name
#Base R approach
mtcars[,c("mpg","cyl","gear")]

#dplyr Approach
select(mtcars,mpg,cyl,gear)

# Use ":" to select multiple contiguous columns, 
#and use "contains" to match columns by name
select(mtcars,mpg:disp,contains("gear"),contains("carb"))
select(mtcars,mpg:disp,"gear","carb")

#Exclude a particular column 
select(mtcars,-contains("gear"))


filter(select(mtcars,gear,carb,cyl),cyl==8|cyl==6)


#To select all columns that start with the character string "c", 
#use the function starts_with()
head(select(mtcars, starts_with("c")))

##Some additional options to select columns based on specific criteria:
#ends_with() : Select columns that end with a character string
#contains() : Select columns that contain a character string
#matches() : Select columns that match a regular expression
#one_of() : Select columns names that are from a group of names


#3. Arrange : Reorder rows
#base Approach
mtcars[order(mtcars$cyl),c("cyl","gear")]
mtcars[order(mtcars$cyl,decreasing = T),c("cyl","gear")]
#mtcars[order(mtcars$cyl,mtcars$gear),c("cyl","gear")]


#dplyr Approach
#Syntax:
#arrange(dataframe,orderby)
arrange(select(mtcars,"cyl","gear"),cyl)
arrange(select(mtcars,"cyl","gear"),cyl,gear)
arrange(select(mtcars,"cyl","gear"),desc(cyl))
arrange(select(mtcars,"cyl","gear"),desc(cyl),gear)


#mutate: Add new variable
#Base R Approach
temp <- mtcars
temp$new_variable <- temp$hp + temp$wt
str(temp)

##dplyr Approach
temp <- mutate(temp,mutate_new = temp$hp + temp$wt)
str(temp)

# Fetch the unique values in dataframe

#Base Package approach - unique function
#unique()

unique(mtcars$cyl)
unique(mtcars["cyl"])
unique(mtcars[c("cyl","gear")])

#dplyr approach

#distinct() 
distinct(mtcars["cyl"])
distinct(mtcars[c("cyl","gear")])


#aggregate()
##base R approach (package:stats)
aggregate(mtcars, by=list(mtcars$cyl), 
          FUN=mean, na.rm=TRUE)

sum(10,20)
sum(10,20,NA)
sum(10,20,NA,na.rm = T)

aggregate(mtcars[,c("mpg","disp","hp")], 
          by=list(mtcars$cyl,mtcars$gear), 
          FUN=mean, na.rm=TRUE)



#dplyr approach
#Summarise : Reduce variable to values
summarise(mtcars,avg_mpg = mean(mpg))
summarise(mtcars,avg_mpg = mean(mpg),avg_disp = mean(disp))

summarise(group_by(mtcars,cyl),avg_mpg = mean(mpg))
summarise(group_by(mtcars,cyl,gear),avg_mpg = mean(mpg))

#Table is very handy to find the frequencies (mode)
#Base Package Approach 
table(mtcars$cyl)

a <- factor(rep(c("A","B","C"), 10))
a
table(a)
table(a, exclude = "B")

#dplyr approach
#Helper Function n() count the number of rows in a group 
#Helper Function n_distinct(vector) counts the number of
#unique item in that vector
summarise(group_by(mtcars,cyl),freq=n())
summarise(group_by(mtcars,cyl),freq=n(),n_distinct(gear))



##Merge two data frames

#Create first data frame:
name = c("Anne", "Pete", "Cath", "Cath1", "Cath2")
age = c(28,30,25,29,35)
child <- c(FALSE,TRUE,FALSE,TRUE,TRUE)
df <- data.frame(name,age,child)

#Create Second Dataframe:
name = c("Anne1", "Pete", "Cath", "Cath1", "Cath2")
occupation = c("Engg","Doc","CA","Forces","Engg")
df1 = data.frame(name,age,occupation)

#Base Package Approach
merge(df,df1)

#Creating anohter dataframe with different column name
name1 = c("Anne1", "Pete", "Cath", "Cath1", "Cath2")
age1 = c(28,30,25,29,35)
df2 = data.frame(name1,age1,occupation)
merge(df,df2,by.x = "name",by.y = "name1")
merge(df,df2,by.x = "name",by.y = "name1",all.x = T)
merge(df,df2,by.x = "name",by.y = "name1",all.y = T)
merge(df,df2,by.x = "name",by.y = "name1",all = T)
merge(df,df2,by.x = c("name","age"),by.y = c("name1","age"),all = T)


##dplyr approach
inner_join(df,df1)
inner_join(df,df1,by = "name")
left_join(df,df2,by = c("name" = "name1"))
left_join(df,df2,by = c("age" = "age" , "name" = "name1"))


#Try
#left_join()
#full_join()
