setwd("D:/Data science  notes/House Prices")
getwd()
train<-read.csv("train.csv")
str(train)
class(train)
summary(train)
head(train)

library(dplyr)
library(ggplot2)
library(pastecs)
library(ggthemes)

sum(is.na(train))
rowSums(is.na(train))
colSums(is.na(train))
sapply(train,class)
#getOption("max.print")
#(nrow(house_price) - nrow(unique(house_price)))
#sort(colSums(is.na(house_price)), decreasing = T) 
glimpse(train)


# print histogram of sales prices in data
hist(train$SalePrice)

# new variable, which is housing prices divided by 100000.
train$price_new<-train$SalePrice/100000

# print some basic descriptive aspects of the price_new variable.
stat.desc(train$price_new) 

# print some basic descriptive aspects of the price_new variable.
stat.desc(train$price_new) 

# Plotting the new variable in a histogram using 

ggplot(train, aes(x=price_new)) + # Use 'train' dataset, and pick price_new as x variable
  geom_histogram(color="black", fill="white", binwidth = 0.3) + # Histogram specifications
  geom_vline(aes(xintercept=mean(price_new)), color="blue", linetype="dashed", size=1) + # Dashed mean line
  theme() + # Add theme function defined in preamble
  xlab("Price / 100000") + # Set x axis title
  ylab("Number of houses") + # Set y axis title
  ggtitle("Distribution of housing prices") # Set title of plot


# Generate new variable, HouseArea, the sum of the other variables
train$HouseArea<- train$X1stFlrSF+train$X2ndFlrSF+train$TotalBsmtSF+train$GarageArea
 

# Have a quick look at the values of the variables to determine that the HouseArea variable 
# has been correctly generated
str(train$X1stFlrSF)
str(train$X2ndFlrSF)
str(train$TotalBsmtSF)
str(train$GarageArea)
str(train$HouseArea)

ggplot(train, aes(x=HouseArea, y=price_new)) +
  geom_point(size=0.5, shape = 1) +    # Use hollow circles
  geom_smooth(size = 0.5, method=lm, se=TRUE) + # add linear regression and se line.
  theme() +
  xlab("Size of house in square feet") + # Set x axis title
  ylab("Price / 100000") + # Set y axis title
  ggtitle("Scatterplot of house area and price") # Set title of plot

ggplot(train, aes(x=LotArea, y=price_new)) +
  geom_point(size=0.5, shape = 1) +    # Use hollow circles
  geom_smooth(size = 0.5, method=lm, se=TRUE) + # add linear regression and se line.
  theme() +
  xlab("Size of lot in square feet") + # Set x axis title
  ylab("Price / 100000") + # Set y axis title
  ggtitle("Scatterplot of lot area and price") # Set title of plot


# Multiple linear regression mdoel
lin_model <- lm(price_new ~ HouseArea + LotArea, data=train)
summary(lin_model)
