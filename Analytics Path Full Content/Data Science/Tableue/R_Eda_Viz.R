setwd("C:/Users/mps/Desktop/Myworkingdirectory")
write.csv(mpg,"mpg.csv")
head(mpg)
write.csv(mpg,"mpg.csv")

install.packages("ggplot2")
library(ggplot2)
data(mpg)
head(mpg)
colnames(mpg)
hist(mpg$cty,breaks = 10)

boxplot((mpg$cty))
pie(table(mpg$manufacturer))
table(mpg$manufacturer)


# GGPLOT
install.packages("ggplot2")
library(ggplot2)
help(mpg)
colnames(mpg)
head(mpg)
mean(mpg$hwy)
median(mpg$hwy)
max(mpg$hwy)
str(mpg)
class(mpg$hwy)
# Create a BOXPLOT using geom_boxplot()
ggplot(mpg, aes(1,hwy)) + geom_boxplot()

ggplot(mpg,aes(hwy)) + geom_histogram(binwidth = 5 )

# Create Bar Chart and fill with color aesthetics

ggplot(mpg,aes(manufacturer, fill=manufacturer))+geom_bar()
ggplot(mpg,aes(manufacturer, fill=model))+geom_bar()
ggplot(mpg,aes(trans,fill=trans))+geom_bar()

# Calculate freqcount of how many cars with same highway miles per gallon (hwy) and
# generate descriptive statistic sum for each hwy and also histogram
class(mpg$hwy)
ggplot(mpg,aes(hwy,fill=hwy))+geom_bar()
ggplot(mpg,aes(as.character(mpg$hwy),fill=hwy))+geom_bar()

# Generating descriptive stats of sum/freqcnt for hwy
mpg$cnt = 1
aggregate(mpg$cnt,by= list(mpg$hwy),sum)


# Alternate way by assigning the syntax to a variable and later adding the desired chart to the variable
a = ggplot(mpg,aes(manufacturer, fill= manufacturer))
a + geom_bar()

# Two Continuous Variables
ggplot(mpg,aes(hwy,cty)) + geom_point()

# One Continuous and One Factor Variable
class(mpg$manufacturer)
class(mpg$hwy)
b=aggregate(mpg$hwy,by= list(mpg$manufacturer),mean)
mean(mpg$hwy)
min(mpg$hwy)
ggplot(mpg,aes(manufacturer,hwy)) + geom_boxplot()

names(mpg)
head(mpg)

# Two Factor Variables
ggplot(mpg, aes(class,fill=drv)) + geom_bar()
ggplot(mpg, aes(manufacturer,fill=class)) + geom_bar()

# Multimple Dimensions
# Create a Scatter Plot
ggplot(mpg,aes(hwy,cty)) + geom_point()

# Create a scatter plot with aesthetics
ggplot(mpg,aes(hwy,cty,shape=class)) + geom_point()
ggplot(mpg,aes(hwy,cty,shape=class,size=displ)) + geom_point()
ggplot(mpg,aes(hwy,cty,shape=class,size=displ,color=class)) + geom_point()
# cause and effect relationship of highway miles per gallon and city miles per gallon,
# by shape=class and size = engine displacement in liters and color = class
ggplot(mpg,aes(hwy,cty,shape=class,size=displ,color=class)) + geom_point()

View(mpg)
ggplot(mpg, aes( hwy, cty, size = cyl)) + geom_point()
ggplot(mpg, aes( hwy, cty, size = cyl,  color = class)) + geom_point()
# cause and effect relationship of highway miles per gallon and city miles per gallon,
# by SIZE of number of cyliners, by color = CLASS and 
# shape = drv(front-wheel drive,rear-wheel drive and 4 wheel-drive)

ggplot(mpg, aes( hwy, cty, size = cyl,  color = class, shape = drv)) + geom_point()

# Storing expression to a variable b
b = ggplot(mpg, aes( hwy, cty, size = cyl,  color = class, shape = drv)) + geom_point()

# Change size to cyl and analyze the results
ggplot(mpg, aes(hwy,cty,shape=class,size= cyl, color=drv)) + geom_point()

# Facets divide a plot into subplots based on the values of one or more discrete variables
# FACET variables accepts only FACTOR variables (cross check online)
print(mpg$y)
mpg$year = as.factor(mpg$year)

b + facet_grid(. ~ fl)    # facet into columns based on fl
b + facet_grid(fl ~ .)    # facet into rows based on fl
b + facet_grid(year ~ .)  # facet into rows based on year
b + facet_grid(fl ~ year) # facet into both rows and columns
b + facet_grid(year ~ fl) # facet into both rows and columns

b + facet_wrap(fl ~ year) # wraps facets into rectangular layout

c = b + geom_point()

# ggtitle - add a main title above the plot
d = c + ggtitle("Hwy Vs Cty Mileage by Class and Drive type") 
d
# add x-axis lable and y-axis label
d = c + xlab("Highway Miles Per Gallon") + ylab("City Miles Per Gallon") 
d
# Alternate way to add titles and labels
d = c + labs(title = "Hwy Vs Cty Mileage by Class and Drive type",
             x = "Highway Miles Per Gallon",
             y = "City Miles Per Gallon")
d

# Themes - analyze background theme of the graph
e = d +xlab("Highway Mileage") + ylab("City Mileage") + theme_bw()
e
e = d +xlab("Highway Mileage") + ylab("City Mileage") + theme_classic()
e
e = d +xlab("Highway Mileage") + ylab("City Mileage") + theme_grey()
e
e = d +xlab("Highway Mileage") + ylab("City Mileage") + theme_minimal()
e

# COORD_CARTESIAN defined x and y limits on axis
# LEGENDS - Theme with placing a legend on "bottom", "top", "lef", or "right"  of the chart
e + coord_cartesian(xlim=c(10,50),ylim=c(10,40))  + theme(legend.position ="bottom" )

getwd()
ggsave("ctyp_hmy.png")

# qplot(quick and easy plotting)
head(mpg)
qplot(x = hwy, y = cty, data = mpg)
qplot(x=hwy, y = cty, data = mpg, geom = "point", xlim = c(10,40), ylim=c(10,40))
qplot(cty,hwy,data=mpg,size=cyl,color=class,geom="point")


###########################################################################################
# CREDIT DATA - DATA EXPLORATORY AND VISUALZIATION - CLASS PRACTICE SESSION               #
###########################################################################################
setwd("D:/in-class/")

credit = read.csv("credit.csv")
names(credit)

# Analyze Total Number of Defaulters - YES 300 / NO 700 out of 1000 obs
class(credit$default)
str(credit$default)
table(credit$default)
summary(credit$default)
View(credit)
## Relationship b/w all variables 
ggplot(credit,aes(checking_balance, fill = default)) + geom_bar()

# Sorting by Checking_balance and default
credit = credit[order(credit$checking_balance,credit$default),]
# Create a count by grouping on 
credit$cnt=1
aggregate(t$Survived,by= list(t$Sex,t$Embarked),mean)
aggregate(credit$cnt,by=list(credit$checking_balance, credit$default),sum)

# Analyze the descriptive stats by generating a bar chart
ggplot(credit, aes(checking_balance, fill=default)) + geom_bar()

ggplot(credit, aes(default, age)) + geom_boxplot()

table(credit$credit_history)

ggplot( credit, aes(credit_history, fill = default)) + geom_bar()

ggplot( credit, aes( default, amount)) + geom_boxplot()

f = ggplot( credit, aes( amount, months_loan_duration, color=default, shape = credit_history)) + geom_point()
f
f + facet_grid( . ~ savings_balance)

