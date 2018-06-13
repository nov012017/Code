
a = c(10,15,16,21,22,25,26,31,32,33,34,35,36,37,38, 44,46,48,49,50,55,60)

### descriptive statistics 
summary(a)
mean(a)
median(a)
## Measures of spread 
var(a) ### variance 
sd(a) ## satandard deviation 

### distribution 
hist(a, breaks = 5)
hist(a) 
sd(a)
mean(a)

## shape of the distibution using desity function 

k = dnorm(a, mean= 34.68, sd =13.43 ) ## density of a normal disrtibution 

k
## 
plot(a,k, type="l") # ,type="l")

?dnorm

  c = 1:30
  
  hist(c)
  
  mean(c)
  
  sd(c)
  
   g = dnorm( c, mean=15.5,sd= 8.8 )

   
   plot(c,g, type="l")
### propability of <=x  

pnorm( 40, mean = 34.6, sd = 13.4 )

plot()

### probability of having a salary of atleast 30L when mean is 25L and Sd = 5L 

pnorm(30000, mean=25000, sd=5000)

## probability of having salary greater than 30000
1 - pnorm(30000, mean=25000, sd=5000)
## probability of having salary upto 32000
pnorm(32000, mean=25000, sd=5000)

pnorm(0, mean = 25000, sd = 5000)
##### 
pnorm( 3000000, mean = 2500000, sd=500000)

### probability( Percentage of emp) having a salary b/w 32L and 30 L 

pnorm( 3200000, mean = 2500000, sd=500000) - pnorm( 3000000, mean = 2500000, sd=500000)

### probability( Percentage of emp) having a salary b/w 30L and 25 L 

pnorm( 3000000, mean = 2500000, sd=500000) - pnorm( 2500000, mean = 2500000, sd=500000)

### propability of having a salary of gt 40L 

1 - pnorm( 4000000, mean = 2500000, sd=500000)

#### qnorm is the opposite of pnorm 

qnorm( 0.3, mean=2500000, sd = 500000)

qnorm(0.841, mean = 2500000, sd = 500000)

qnorm(0.25, mean=2500000, sd = 500000)

qnorm(0.75, mean = 2500000, sd = 500000)

qnorm(0.5, mean = 2500000, sd = 500000)

qnorm( 0.95, mean=2500000, sd=500000)

qnorm( 0.997, mean=2500000, sd=500000)
### Hypothesis testing 


### zscores using scale function 

b = scale(a)



summary(b)
sd(b)

b 
boys = c( )


girls = c( 7, 8, 9, 9, 6, 7, 8, 4, 5, 4, 7, 5, 5, 5, 9, 4,9,5,7 ) #, 9,9,9,9,9,9,9)
length(girls)
boys = c( 5,6,7,5,6,7,8,4,9,6,5,7,8,6,7,5,8,4,4,8) #3,4,3,4,3,4)
length(boys)
### two sample one sided 
### Ha : mean(girls) >> mean(boys)
### h0 : mean(girls) <= mean(boys)

mean(girls)
mean(boys)

t.test( girls, boys, alternative ="greater")

### Two sample and two sided 
### Ha : mean(girls) != mean(bos)
### h0 : mean(girls) = mean(boys)

t.test( girls, boys, alternative ="two.sided")

##### Two sample one sided 
t.test(boys, girls, alternative = "less")


#### one sample t.test 

bridge = c( 101, 99, 96, 94, 102, 104, 105, 109, 108, 98, 99, 104,103, 104, 105)

length(bridge)
sd(bridge)
### theoritical mean is 100 

mean(bridge)

## H0 : Mean strenght(bridge) <= 100 
## Ha : Mean strength(bridge) > 100 

t.test(x = bridge, mu = 100, alternative = "greater")

### compute t-stat 

(102.066 -100)/(4.23/sqrt(15))
## tstat = 1.89 ##tcrit = 1.76

##tstat > tcrit -- Reject NUll

## one sample and two sided t-test 

fuel = c( 1000, 999, 998, 1004, 1003, 1002, 1000, 996, 994, 995, 1001, 1004, 998, 999, 997)

length(fuel)

####  t.test 

t.test( x = fuel, mu=1000, alternative = "two.sided")

####  t statistic 

mean(fuel) ## 999.33
sd(fuel) ## 3.10 

### tstat 

(999.33-1000)/(3.10/sqrt(15))
### two groups 


girls = c( 4,5,7,8,9,6,7,8,9,7,8,9,5,6)
length(girls)
boys = c( 6,7,4,7,8,9,4,5,6,7,4,5,4,8)
length(boys)

mean(boys); mean(girls)

### H0 : Mean difference in groups equal to 0 
### Ha : Mean difference is not eual to 0 

t.test( boys, girls , alternative =  "two.sided")

####b  one tail 

## H0 : mean score of girls <= mean score of boys
### Ha : mean score of girls > mean score of boys

t.test( x = girls, y = boys,alternative = "greater")


a = rnorm( 100, 1000, 1)

a 
t.test( a, mu=1000, alternative = "greater")

x = c( 1,2,3,4,5)
y = c( 11, 22, 34, 41, 50)

plot(x,y)

cov(x,y)

cor(x,y)

sum((x-3)*(y-32))
97/4

cov(x,y)
z = c( 55, 44, 39, 21, 15)
cor(x,z)

plot(x,y, type="l")

plot(x,z, type="l")

cor(x,z)

#### chisquare test 

setwd("D:/Data Science - Course/Decision_Tree")

credit = read.csv("credit.csv")
str(df1)

head(credit)

table(credit$default, credit$phone)

chisq.test(table(credit$default, credit$phone))

### Anova exampe 
 a= c( 24, 26, 31, 27, 8)
 b = c( 29, 31,30, 36,33)
 c = c( 29, 27, 34, 26, 23)

 df = data.frame(a,b,c)
 
fit =  aov( c ~ a+b, data = df)


summary(fit)

fit2 = lm( c ~ a+b , data = df)

summary(fit2)
 