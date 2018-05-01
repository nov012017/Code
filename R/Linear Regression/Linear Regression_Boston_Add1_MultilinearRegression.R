install.packages("tidyr")
library("tidyr")

# Select out data of interest:
d <- mtcars %>% select(mpg, hp, wt, disp)

# Fit the model
fit <- lm(mpg ~ hp + wt+ disp, data = d)

plot(fit)
summary(fit)

# Obtain predicted and residual values
d$predicted <- predict(fit)
d$residuals <- residuals(fit)

ggplot(d, aes(x = hp, y = mpg)) +
  geom_segment(aes(xend = hp, yend = predicted), alpha = .2)+ # Lines to connect points
  geom_point(aes(y = predicted), shape = 1) + # Points of predicted values
  geom_point(aes(color = residuals)) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red") +
  theme_bw()


### Plotting multiple predictors at once

d %>% 
  gather(key = "iv", value = "x", -mpg, -predicted, -residuals) %>%
  ggplot(aes(x = x, y = mpg)) +
  geom_point()+# Note use of `x` here and next line
  facet_grid(~ iv, scales = "free") +
  geom_segment(aes(xend = x, yend = predicted), alpha = .2) +
  geom_point(aes(color = residuals),shape=1) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red") +
  geom_point(aes(y = predicted), shape = 2) +
  theme_bw()

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
  
