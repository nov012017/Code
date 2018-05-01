library(ggplot2)
data(mpg)
View(mpg)
mpg_rows= 1:nrow(mpg)
mpg_trainRows = sample(mpg_rows,round(0.7*nrow(mpg)))
mpg_testrows<-mpg_rows[-mpg_trainRows]

mpg_traindata<-mpg[mpg_trainRows,]
mpg_testdata<-mpg[mpg_testrows,]

mpg_mod1=lm(hwy ~ cty, data=mpg_traindata)
summary(mpg_mod1)

preds_train = predict(mpg_mod1,mpg_traindata)
mpg_traindata$pred=preds_train
rmse_mpg_train_model_2V=sqrt(sum((mpg_traindata$pred- mpg_traindata$hwy)**2)/nrow(mpg_traindata))
