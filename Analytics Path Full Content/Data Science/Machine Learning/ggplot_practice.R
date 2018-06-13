##grammer of graphics##
#=====================================
#ggplot2 has 2 types  1)mandatory  2)optional
#######a) In mandatory 3 parameters   1)data    2)geom()   3)aesthetics
#######b)in optional    1)statitics   2)facets

#statistics
pnorm(85,mean = 72, sd=15.2)

##install.packages(ggplot2)
library(ggplot2)
data(mpg)
head(mpg)

##one continuous
##histogram using base plot
hist(mpg$cty)
?hist


##box plot
boxplot(mpg$cty)

##one factor variable
barplot(table(mpg$manufacturer))
pie()

##two variables
##two continuous variable
plot(mpg$cty,mpg$hwy,pch=1,xlim=c(10,30),ylim = (15,40)) ##pch=plotting character ..1,2,3..
plot(mpg$cty,mpg$hwy,pch=1)
?plot
###one cont and one factor variable
##boxplot
boxplot(mpg$hwy~mpg$class)
boxplot(mpg$hwy~mpg$drv)
boxplot(mpg$cty~mpg$fl)

##two factor varibles
?barplot
barplot(table(mpg$class,mpg$manufacturer),col = col1)
legend
col1=c("lightblue","mistyrose","lightcyan")
table()

##using ggplot2
ggplot(mpg,aes(mpg$manufacturer,fill=mpg$class))+geom_bar()
ggplot(mpg,aes(mpg$class,mpg$cty,fill=mpg$class))+boxplot()
##14/12/17--ggplot
##one continuous variable
ggplot(mpg,aes(hwy))+geom_histogram(bins = 10)
ggplot(mpg,aes(hwy))+geom_histogram(binwidth=4)  
##boxplot
ggplot(mpg,aes(1,cty))+geom_boxplot()

##one factor variable
ggplot(mpg,aes(class,fill=class))+geom_bar()

##two variables

##two cont variables
ggplot(mpg,aes(cty,hwy,color=cty))+geom_point()

ggplot(mpg,aes(x= ,y= ,))

##one cont,one factor variable

ggplot(mpg,aes(class,hwy,color=class))+geom_boxplot()

ggplot(mpg,aes(drv,hwy,color=drv))+geom_boxplot()

##two factor variable

ggplot(mpg,aes(class,fill=drv))+geom_bar()

##multi dimensional plots

ggplot(mpg,aes(cty,hwy,color=class,shape=drv,size=cyl))+geom_point()


