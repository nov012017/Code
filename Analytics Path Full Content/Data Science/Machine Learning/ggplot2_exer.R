###ggplot2 
attach(mtcars)
str(mtcars)
View(mtcars)
rownames(mtcars)
colnames(mtcars)

library(ggplot2)
ggplot(data=mtcars,aes(x=cyl,y=mpg))+geom_point()

ggplot(data=mtcars,aes(cyl,mpg))+geom_point()
str(mtcars$cyl)
ggplot(data=mtcars,aes(factor(cyl),mpg))+geom_point()

#ggplot(data=mtcars,aes(x=factor(cyl),y=mpg))+geom_point()
##scatter plot

ggplot(data=mtcars,aes(cyl,mpg))+geom_point(shape=2,size=4)

ggplot(data=mtcars,aes(cyl,mpg,size=hp))+geom_point()

ggplot(data=mtcars,aes(factor(cyl),mpg,color=hp))+geom_point(size=4)

ggplot(data=mtcars,aes(wt,mpg,color=hp,size=disp))+geom_point()

###another way of coding
##if we give sie in geom_point,it change the size of all var of aes.

p<-ggplot(data=mtcars,aes(x=factor(cyl),y=mpg))
p+geom_point(aes(size=hp))
p+geom_point(aes(color=hp,size=disp))

##absolute bar chart
ggplot(data=mtcars,aes(cyl,fill=am))+geom_bar(position = "stack")

###use geom_text in plot
ggplot(data=mtcars,aes(wt,mpg))+geom_text(aes(label=cyl))

##
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "red", fill = "white", size = 2, stroke = 5)

##histogram
ggplot(mtcars,aes(mpg))+
  geom_histogram(bandwidth=3,color="blue",fill="red")
#############################################################################
p1 <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  labs(title = "Fuel economy declines as weight increases")
p1

#plot
p1 + theme(plot.title = element_text(size = rel(2)))

p1 + theme(plot.background = element_rect(fill = "green"))

# Panels --------------------------------------------------------------------

p1 + theme(panel.background = element_rect(fill = "white", colour = "grey50"))
p1 + theme(panel.border = element_rect(linetype = "dashed", fill = NA))
p1 + theme(panel.grid.major = element_line(colour = "black"))
p1 + theme(
  panel.grid.major.y = element_blank(),
  panel.grid.minor.y = element_blank()
)

# Put gridlines on top of data
p1 + theme(
  panel.background = element_rect(fill = NA),
  panel.grid.major = element_line(colour = "grey50"),
  panel.ontop = TRUE
)
##__________________________________________________________________________________
# Legend --------------------------------------------------------------------
p2 <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point(aes(colour = factor(cyl), shape = factor(vs))) +
  labs(
    x = "Weight (1000 lbs)",
    y = "Fuel economy (mpg)",
    colour = "Cylinders",
    shape = "Transmission"
  )
p2

# Position
p2 + theme(legend.position = "none")
p2 + theme(legend.justification = "top")
p2 + theme(legend.position = "bottom")

# Or place inside the plot using relative coordinates between 0 and 1
# legend.justification sets the corner that the position refers to
p2 + theme(
  legend.position = c(.95, .95),
  legend.justification = c("right", "top"),
  legend.box.just = "right",
  legend.margin = margin(6, 6, 6, 6)
)

# The legend.box properties work similarly for the space around
# all the legends
p2 + theme(
  legend.box.background = element_rect(),
  legend.box.margin = margin(6, 6, 6, 6)
)

# You can also control the display of the keys
# and the justifaction related to the plot area can be set
p2 + theme(legend.key = element_rect(fill = "white", colour = "black"))
p2 + theme(legend.text = element_text(size = 8, colour = "red"))
p2 + theme(legend.title = element_text(face = "bold"))

# Strips --------------------------------------------------------------------

p3 <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  facet_wrap(~ cyl)
p3

p3 + theme(strip.background = element_rect(colour = "black", fill = "white"))
p3 + theme(strip.text.x = element_text(colour = "white", face = "bold"))
p3 + theme(panel.spacing = unit(1, "lines"))


#####
tips
str(tips)

#install.packages("reshape2")

library(ggplot2)

str(diamonds)
ggplot(data=diamonds,aes(carat,price,col=clarity))+geom_point()

ggplot(data=diamonds,aes(carat,price,col=clarity))+geom_smooth()

ggplot(data=diamonds,aes(carat,price,col=clarity))+geom_point(alpha=0.4)

q<-ggplot(data=diamonds,aes(carat,price))
          
q+geom_abline()
q+geom_area()
q+geom_col()
q+geom_smooth()
q+geom_boxplot()

View(diamonds)
####
str(economics)
head(economics)

ggplot(economics,aes(date,unemploy))+geom_line()

ggplot(economics,aes(date,unemploy/pop))+geom_line()

ggplot(economics,aes(date,unemploy/pop,col=psavert))+geom_line()

