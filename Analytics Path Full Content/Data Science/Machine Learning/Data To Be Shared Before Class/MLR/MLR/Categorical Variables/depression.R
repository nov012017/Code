dataset = read.csv('depression.csv')
library(GGally)
ggpairs(dataset)
library(ggplot2)
library(dplyr)
x1 = filter(dataset, TRT == 'A')
x2 = filter(dataset, TRT == 'B')
x3 = filter(dataset, TRT == 'C')
ggplot() + 
  geom_point(aes(x = age, y = y, color = TRT), data = dataset) +
  geom_smooth(aes(x = age, y = y), data = x1, color = 'red', method = 'lm', se = FALSE) +
  geom_smooth(aes(x = age, y = y), data = x2, color = 'green', method = 'lm', se = FALSE) +
  geom_smooth(aes(x = age, y = y), data = x3, color = 'blue', method = 'lm', se = FALSE)

