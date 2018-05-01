## Problem Statement: Predict the price of the car, based on different features

# View(baseball_runs)
car_price=read.csv("carPrice.csv")

str(car_price)
#car_price$car_ID=NULL

library(dummies)
car_price_new<-dummy.data.frame(car_price,names=c("carCompany","fueltype","aspiration","doornumber","carbody",
                                                  "drivewheel","enginelocation","enginetype","cylindernumber","fuelsystem"))

cor(car_price_new[,1:75])

set.seed(103)
indices=sample(1:nrow(car_price_new),0.7*nrow(car_price_new))

pca_train=car_price_new[indices,]
pca_test=car_price_new[-indices,]

train_label <- pca_train[,76]
test_label <- pca_test[,76]

pca_train <- pca_train[,-c(1,76)]
pca_test<- pca_test[,-c(1,76)]

cor=cor(pca_train)

#matrix=matrix(cor(pca_train))


## The bas R function prcomp() is used to perform PCA
# temp <- scale(pca_train)
p_comp <- prcomp(pca_train,scale.=T)
#pl_comp <- princomp(pca_train,scores = T, cor = T)
names(p_comp)
rotation=p_comp$rotation
x=p_comp$x
summary(pl_comp)
loadings(pl_comp)
plot(p_comp)
pl_comp$loadings
sum(is.na(pca_train))
fa=factanal(pca_train,factors = 3)

## Factor Analysis

std_dev <- p_comp$sdev

## Compute variance
## How much information each principle component is consisting of
## The more the variance the more the information

pr_var<-std_dev^2

## Check the variance of first 10 components
pr_var[1:20]

## Proporting of variance explained

prop_varex <- pr_var/sum(pr_var)
prop_varex[1:40]

plot(cumsum(prop_varex),xlab = "PrincipleComponent",ylab = "cumulating proportions of variance explained", type="p")

## Selected 40 PCA's looking at the above graph
train_data_withPCA <- data.frame(p_comp$x)
train_data_withPCA <- train_data_withPCA[,1:40]

train_data_withPCA <- cbind(train_data_withPCA,price=train_label)

## make the model

model_1 <- lm(price ~.,data=train_data_withPCA)
summary(model_1)

## Apply same transformation to the test set as we did the 
test_data_withPCA <- data.frame(predict(p_comp,pca_test))
test_data_withPCA <- test_data_withPCA[,1:40]

sample_predict <-predict(model_1,test_data_withPCA)
