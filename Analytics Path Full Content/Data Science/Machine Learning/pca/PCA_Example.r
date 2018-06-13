
#x <- matrix(c(.5549,.6154,.6154,.7165),nrow = 2)
#eigen(x)
setwd("D:\\Data science  notes")

#View(baseball_runs)
car_price <- read.csv("carPrice.csv")

#Remove the ID column and dependent variable

str(car_price)
names(car_price)
View(car_price)
## PCA works on NUmeric varaibles ONLY, so need to change Factors into numeric using one hot encoding

#install.packages("dummies")
library(dummies)
car_price_new <- dummy.data.frame(car_price,names 
                                  = c("carCompany",
                                      "fueltype",
                                      "aspiration",
                                      "doornumber",
                                      "carbody",
                                      "drivewheel",
                                      "enginelocation",
                                      "enginetype",
                                      "cylindernumber",
                                      "fuelsystem"))
View(car_price_new)
#Split the data into train and test

set.seed(103)
indices= sample(1:nrow(car_price_new), 
                0.7*nrow(car_price_new))

pca_train=car_price_new[indices,]
pca_test = car_price_new[-indices,]
#str(pca_train)

train_label <- pca_train[,76]
test_label <-  pca_test[,76]
#names(pca_train)
#View(pca_train)

pca_train <- pca_train[,-c(1,76)]
pca_test <- pca_test[,-c(1,76)]
#names(pca_train)
cor(pca_train)
#View(cor(pca_train))

#The base R function prcomp() is used to perform PCA.
#temp <- scale(pca_train)
#View(temp)
P_Comp <- prcomp(pca_train,scale. = T)
summary(P_Comp)
plot(P_Comp)


#dim(P_Comp$x)
#biplot(P_Comp,scale=0)

#compute standard deviation of each principal component
std_dev <- P_Comp$sdev

#compute variance
pr_var <- std_dev^2

#check variance of first 10 components
pr_var[1:10]

#proportion of variance explained
prop_varex <- pr_var/sum(pr_var)
prop_varex[1:20]


#scree plot
#plot(prop_varex, xlab = "Principal Component",
#       ylab = "Proportion of Variance Explained",
#       type = "b")


#cumulative scree plot
plot(cumsum(prop_varex), 
     xlab = "Principal Component",
       ylab = "Cumulative Proportion of Variance Explained",
       type = "b")

train_data_withPCA <- data.frame(P_Comp$x)
train_data_withPCA <- train_data_withPCA[,1:40]

train_data_withPCA <- cbind(train_data_withPCA,price = train_label)


##Make the model
model_1 <-lm(price ~.,data=train_data_withPCA)
summary(model_1)

##Apply same transformation to the test set as we did in training set.
test_data_withPCA <- data.frame(predict(P_Comp, pca_test))
test_data_withPCA <- test_data_withPCA[,1:40]

sample_predict <- predict(model_1,test_data_withPCA)


## Important to Remember for Interview


#PCA is used to overcome features redundancy in a data set.
#These features are low dimensional in nature.
#These features components are a resultant of normalized linear combination of original predictor variables.
#These components aim to capture as much information as possible with high explained variance.
#The first component has the highest variance followed by second, third and so on.
#The components must be uncorrelated
#Normalizing data becomes extremely important when the predictors are measured in different units.
#PCA is applied on a data set with numeric variables.
#PCA is a tool which helps to produce better visualizations of high dimensional data.


##Python:
#http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
