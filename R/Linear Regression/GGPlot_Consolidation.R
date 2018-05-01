#Plotting --- difference is color with gradient2
ggplot(d,aes(x=hp, y=mpg))+
  geom_point()+
  geom_point(aes(y = predicted), shape = 1)+
  geom_segment(aes(xend = hp, yend = predicted),alpha=.2)+
  geom_smooth(method = "lm", se = F, color = "lightgrey")+
  geom_point(aes(color = abs(residuals),size=abs(residuals)),show.legend = T,shape=3) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red") +
  theme_bw()

#Plotting --- difference is color with continuous
ggplot(d,aes(x=hp, y=mpg))+
  geom_point()+
  geom_point(aes(y = predicted), shape = 1)+
  geom_segment(aes(xend = hp, yend = predicted),alpha=.2)+
  geom_smooth(method = "lm", se = F, color = "lightgrey")+
  geom_point(aes(color = abs(residuals),size=abs(residuals)),show.legend = T,shape=3) +
  scale_color_continuous(low = "black", high = "red") +
  theme_bw()

## Multi varible 
install.packages("tidyr")
library("tidyr")
d %>% 
  gather(key = "iv", value = "x", -mpg, -predicted, -residuals) %>%
  ggplot(aes(x = x, y = mpg)) +
  geom_point()+
  facet_grid(~ iv, scales = "free") +
  geom_point(aes(y = predicted), shape = 2) +
  geom_segment(aes(xend = x, yend = predicted), alpha = .2) +
  geom_smooth(method = "lm", se = F, color = "lightgrey")+
  geom_point(aes(color = residuals,size=residuals),shape=3) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red")

## Multiple Correlation:
library(GGally)
ggpairs

##
library(ggplot2)
data("mpg")
View(mpg)
# One Discrete Continuous or Continuous variable
ggplot(mpg,aes(cty))+geom_histogram(binwidth = 3)# -- discrete continuous
ggplot(mpg,aes(1,cty))+geom_boxplot() #discrete continuous

#One Discrete Variable
ggplot(mpg,aes(class))+geom_bar() #discrete

#One continuos and factor
ggplot(mpg,aes(class,cty))+geom_boxplot()
ggplot(mpg,aes(drv,cty))+geom_boxplot()

# Two continuous variable
ggplot(mpg,aes(cty,hwy))+geom_point()

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


# Sepal Length
data("iris")
str(iris)
ggplot(data=iris, aes(x=Sepal.Length))+
  geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) +
  xlab("Sepal Length (cm)") +
  ylab("Frequency") + 
  theme(legend.position="none")+
  geom_vline(data=iris, aes(xintercept = mean(Sepal.Length)),linetype="dashed",color="grey")

## Multiple charts at one time
par(mfrow=c(2,2))
plot(fit)
par(mfrow = c(1, 1))
