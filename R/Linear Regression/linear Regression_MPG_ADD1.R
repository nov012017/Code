library(ggplot2)
data("mtcars")
library(dplyr)
fit<- lm(mpg ~ hp, data=mtcars)
summary(fit)

par(mfrow=c(2,2))
plot(fit)
par(mfrow = c(1, 1))

## simple linear regression
d <- mtcars
fit <- lm(mpg ~ hp, data = d)
d$predicted <- predict(fit)
d$residuals <- residuals(fit)

d %>% select(mpg,predicted,residuals)

ggplot(d,aes(x=hp, y=mpg))+
  geom_point()+
    geom_point(aes(y=predicted),shape=1)

View(d)

ggplot(d,aes(x=hp, y=mpg))+
  geom_point()+
  geom_point(aes(y = predicted), shape = 1)+
  geom_segment(aes(xend = hp, yend = predicted),alpha=.2)+
  geom_smooth(method = "lm", se = F, color = "lightgrey")+
  theme_bw()


ggplot(d,aes(x=hp, y=mpg))+
  geom_point()+
  geom_point(aes(y = predicted), shape = 1)+
  geom_segment(aes(xend = hp, yend = predicted),alpha=.2)+
  geom_smooth(method = "lm", se = F, color = "lightgrey")+
  geom_point(aes(alpha = abs(residuals)),show.legend = T,shape=3) +
  theme_bw()

ggplot(d,aes(x=hp, y=mpg))+
  geom_point()+
  geom_point(aes(y = predicted), shape = 1)+
  geom_segment(aes(xend = hp, yend = predicted),alpha=.2)+
  geom_smooth(method = "lm", se = F, color = "lightgrey")+
  geom_point(aes(color = abs(residuals),size=abs(residuals)),show.legend = T,shape=3) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red") +
  theme_bw()

d$alpha=abs(d$residuals)


  