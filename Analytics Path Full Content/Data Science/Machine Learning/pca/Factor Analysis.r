##Factor Analysis is a method for analyzing the covariation among the observed 
#variables to address the questions:

#1. How many latent factors are needed to account for most of the variation 
#among the observed variables?
#2. Which variables appear to define each factor?


#Some important Terme:

#Factor: An underlying or latent construct that 'causes' the observed variables, 
#to a greater or lesser extent. Algebraically, a factor is estimated by a 
#linear combination of observed variables. When the 'best fitting' factors are found, 
#it should be remembered that these factors are not unique; 
#it can be shown that any rotation of the best-fitting factors is also best-fitting. 

#Factor loadings: The degree to which the variable is driven or 'caused' by the factor; 
#Factor -> Variable. The loadings are ui and vi in Xi = uiF1 + viF2 + ei

#Communality of a variable: The extent to which the variability across subjects 
#in a variable is 'explained' by the set of factors extracted in the factor analysis. 
#Uniqueness is just 1-Communality

#Variance accounted for by a factor: The amount of common variance for a set of 
#observed variables that is explained by the factor. 
#The 1st factor extracted in most methods explains more variance than 
#the remaining factors.

#Factor score coefficients/Factor weights: Since a factor is defined as a 
#linear combination of observed variables, F=??wiXi. 
#The set of weights, wi, for each factor gives the factor score coefficients 
#for that factor

#Eigenvalue: The kth eigenvalue is equal to the variance accounted for by the kth 
#most important factor. They are used to compute the % variance accounted for by a 
#factor, and the cumulative % variance accounted for by the the first n factors.

price <- c(6,7,6,5,7,6,5,6,3,1,2,5,2,3,1,2)
software <- c(5,3,4,7,7,4,7,5,5,3,6,7,4,5,6,3)
brand <- c(4,2,5,3,5,3,1,4,7,5,7,6,6,5,5,7)
Friend <- c(7,2,5,6,2,4,1,7,3,2,6,7,6,2,4,5)
Family <- c(6,3,4,7,1,5,4,5,4,4,5,7,2,3,5,6)
data <- data.frame(price,software,brand,Friend,Family)

##Run the PCA to determine the number of factors
pca_fact <- princomp(data)
summary(pca_fact)
plot(pca_fact)
#Factor Analysis
fa <- factanal(data,factors = 2)

fa


#Difference Between PCA and Factor Analysis:
#  PCA	Factor Analysis
#   PCA: Both work on basic of finding factors or eigen values	
#   FA : Same
#   PCA: Here the principal components does not have t make sense always, 
#         it is just an artificial variable	
#   FA : Here you find the name the latent variable based on its attribute.
#   PCA: Mostly you end up deciding number of components	
#   FA :Here after the factors has come, you try to gauge the latent variables.

##Explanation for "Lapack routine dgesv: system is exactly singular: U[58,58] = 0" Error



##install.packages("corpcor")
library(corpcor)

covmat = matrix(c(cov(pca_train)),nrow = ncol(pca_train),
                ncol=ncol(pca_train))

eigen(covmat)

##There are multiple 0 eigen values, and it correspond to column linear combination.
##We need to remove these eigen values and corresponding eigen vectors to make it work
