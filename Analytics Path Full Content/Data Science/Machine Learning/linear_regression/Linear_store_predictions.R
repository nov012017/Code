setwd("D:/AP/linear")
### read the train file 
t=read.csv("train.csv")

### exploratory data analysis 

str(t)
### target variable - norma distribution?

hist(t$Sales)

ggplot( t, aes(Sales)) + geom_histogram(bins = 20)

### Lot of values with 0 sales 
## filter the observations where the store is closed 
t$Open = as.factor(t$Open)
ggplot( t, aes(Open, Sales)) + geom_boxplot()

### avg of sales by store open or close

aggregate( t$Sales, by=list(t$Open), FUN=mean)

### as the sales is 0 when store is closed let's remove those observation 

t_Open = t[ t$Open==1,]
t_closed = t[t$Open==0, ]
### Lets use only the dataset with store open 

ggplot( t_Open, aes(Sales)) + geom_histogram(bins=40)

summary(t_Open$Sales)
sd(t_Open$Sales)

### Three standard deviations on the higher side 
6956+(4*3104)

### filter obs where sales is beyond 3 std 

t_outliers = t_Open[ t_Open$Sales > 19372, ]

## Apply sqrt on target variable 

t_Open$Sales_sq = sqrt( t_Open$Sales)

### look at the distribution of Sqrt of Sales
ggplot( t_Open, aes(Sales_sq)) + geom_histogram(bins=40)

summary(t_Open$Sales_sq)
sd(t_Open$Sales_sq)

82+(3*17)
### Check the input variables 

## findout missing values 
sum(is.na(t_Open$DayOfWeek)) ##No missing values 
sum(is.na(t_Open$Customers)) ##NO Missing values
sum(is.na(t_Open$Promo)) ##No Missing values 
sum(is.na(t_Open$StateHoliday))
sum(is.na(t_Open$SchoolHoliday))

### Divide the data into train and test 

set.seed(1234)

ids = sample( nrow(t_Open), nrow(t_Open)*0.8 )

train = t_Open[ids, ]
test = t_Open[-ids,]

##### Linear models 
names(t_Open)

storepred = lm( Sales_sq ~ Customers + DayOfWeek + Promo + StateHoliday, 
                data = train)

## Build model2 with Schoolholiday variable
storepred2 = lm( Sales_sq ~ Customers + DayOfWeek + Promo + StateHoliday + SchoolHoliday, 
                data = train)
### Model summary and Model validation 

summary(storepred)
summary(storepred2)

### errors normal distribution 

## use the diagnosis tests and plots from MASS 
library(MASS)

plot( storepred, which=1)

### Names of objects in the model 
names(storepred)

hist(storepred$residuals)

## Hetereoscedasticity 

st_err = stdres(storepred)

plot( storepred$fitted.values, st_err)


### MOdel assement 

test$pred_sq = predict(storepred, newdata=test)


## Compute RMSE 

rmse = sqrt(mean((test$Sales_sq - test$pred_sq)**2))

rmse 

mean(test$Sales_sq)

9.46/81.5

### create new variables month and starting week of the month 

## recreate the weekday variable as weekend or weekday 


### look at the distribution of weekday and sales 

aggregate( t_Open$Sales, by=list(t_Open$DayOfWeek), FUN=mean)

t_Open$weekend = ifelse( t_Open$DayOfWeek %in% c(1,7), "Yes", "No")

### lubridate to convert date(string) to datetime 

library(lubridate)

t_Open$Date = as.Date(t_Open$Date)

t_Open$dayofmonth = day(t_Open$Date)
t_Open$Month = month(t_Open$Date)

### Create new variable for month end and month beginning 

t_Open$monthend = ifelse(t_Open$dayofmonth >=26 , "Yes", "No" )
t_Open$monthbeg = ifelse(t_Open$dayofmonth <=6, "Yes", "No")

### divide train and test split again 

set.seed=1234

ids = sample(nrow(t_Open), nrow(t_Open)*0.8)

train = t_Open[ids,]
test = t_Open[-ids,]

### buld model with new variables 
names(t_Open)
newmod = lm( Sales_sq ~ weekend + Promo + Customers + monthend + monthbeg + StateHoliday, 
             data = train)

summary(newmod)

## customers vs sales 

ggplot( t_Open, aes( Customers, Sales)) + geom_point()

cor( t_Open$Sales, t_Open$Customers)
