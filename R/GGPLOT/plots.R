a=c(10,20,30,40,50)
b=c(101,208,300,405,506)

plot(a,b, type="l")

View(mpg)


View(mpg)

library(mpg)

install.packages("ggplot2")
library(ggplot2)
View(mpg$manufacturer)

ggplot(mpg,aes(cty))+geom_histogram(binwidth = 3) #discrete continuous

ggplot(mpg,aes(1,cty))+geom_boxplot() #discrete continuous

ggplot(mpg,aes(class))+geom_bar() #discrete continuous

#Two continuous variables

ggplot(mpg,aes(cty,hwy))+geom_point()


#One continuos and factor
ggplot(mpg,aes(class,cty))+geom_boxplot()

ggplot(mpg,aes(drv,cty))+geom_boxplot()
class(mpg$drv)

ggplot(mpg,aes(cty,drv))+geom_boxplot()

#two factor variables
ggplot(mpg,aes(manufacturer,fill=class))+geom_bar()
ggplot(mpg,aes(class,fill=drv))+geom_bar()


#multi dimensional plots
a=ggplot(mpg, aes(cty,hwy,shape=drv,color=class,size=cyl))+geom_point()

##Facets to add more variable to the plot
a+facet_grid(fl ~.) ##Horizontal facets
a+facet_grid(. ~ fl) # Vertical Facets
a+facet_grid(year ~ f1)


#Enhancements
c=ggplot(mpg,aes(cty,hwy))+geom_point()+geom_smooth(method="lm")+ggtitle("City vs Highway")+xlab("City Mileage")+ylab("Highway Mileage")
c + coord_cartesian(xlim=c(10,30), ylim=c(10,35))
c +coord_cartesian(xlim=c(10,20),ylim=c(20,30))

#Themes
c+theme_classic()
c+theme_bw()

#adjusting positions
ggplot(mpg,aes(class,fill=drv))+geom_bar(position = "dodge")
ggplot(mpg,aes(class,fill=drv))+geom_bar(position = "fill")


ggsave("plot.pdf")
ggsave("plot.jpeg")
ggsave("plot.bmp")
ggsave("plot.png")

getwd()

setwd("C:\\Users\\Admin\\Desktop\\Analytics Path\\R\\Data")
churn=read.csv(file = "churn.csv", header = T, sep = ",")

View(churn)
# Churn is an integer now convert into factor
churn$Churn=as.factor(churn$Churn)

ggplot(churn,aes(Churn,Account.Length))+geom_boxplot()
ggplot(churn,aes(Churn,Account.Length,color=Churn))+geom_boxplot()
ggplot(churn,aes(Churn,Account.Length,fill=Churn))+geom_boxplot()

## Compare churn with days.mins variable
ggplot(churn,aes(Churn,Day.Mins))+geom_boxplot()


## compare churn with internationl minitues
ggplot(churn,aes(Churn,churn$Intl.Mins))+geom_boxplot()


## compare churn with factor variable
ggplot(churn,aes(fill=Churn,churn$Intl.Plan))+geom_bar()
table(churn$Churn,churn$Intl.Plan)

##Customer service call
table(churn$CustServ.Calls)
ggplot(churn,aes(Churn,churn$CustServ.Calls))+geom_boxplot()

# Treat this customer service calls as factor vairable
churn$CustServ.Calls=as.factor(churn$CustServ.Calls)
ggplot(churn,aes(CustServ.Calls,fill=Churn))+geom_bar()

# Two continuous variables
ggplot(churn,aes(churn$Day.Mins,churn$Eve.Mins))+geom_
plot(churn$Day.Mins,churn$Day.Charge) # Correlation is 1

## Matrix plots
plot(churn[,1:5])

ra_sample$Churn = as.factor(ra_sample$Churn)

#Multi dimensional plots
a=ggplot(ra_sample,aes(ra_sample$Day.Mins,ra_sample$Eve.Mins,shape=ra_sample$Intl.Plan,color=ra_sample$Churn))+geom_point()
a+facet_grid(VMail.Plan ~ .)
class(churn$Intl.Plan)
churn$Intl.Plan=as.factor(churn$Intl.Plan)

## Select a random sample to plot multidimensinal
ids=sample(nrow(churn),nrow(churn)*.25)
ids[1:10]
set.seed(1234)
ra_sample=churn[ids,]
om_sample=churn[-ids,]
View(ra_sample)
