getwd()
setwd("C:\\Users\\Admin\\Desktop\\Analytics Path\\R\\Data")
getwd()
hour=read.csv(file="hour.csv", header = T, sep = ",")
View(sa_hour)
library(ggplot2)
sa_hour$weathersit=as.factor(sa_hour$weathersit)
table(sa_hour$hr)
ggplot(hour,aes(1,hour$windspeed))+geom_boxplot()
ggplot(sa_hour,aes(sa_hour$windspeed,sa_hour$cnt,color=sa_hour$workingday))+geom_point()
ggplot(sa_hour,aes(fill=sa_hour$casual,sa_hour$workingday))+geom_bar()
ggplot(sa_hour,aes(fill=sa_hour$registered,sa_hour$workingday))+geom_bar()
ggplot(sa_hour,aes(sa_hour$windspeed,sa_hour$temp))+geom_point()
ggplot(sa_hour,aes(sa_hour$hr,fill=sa_hour$registered))+geom_bar()
ggplot(sa_hour,aes(sa_hour$casual,sa_hour$registered))+geom_point()
cor(sa_hour$windspeed,sa_hour$temp)
ggplot(sa_hour,aes(weathersit,cnt))+geom_boxplot()
ggplot(sa_hour,aes(temp,cnt,color=weathersit))+geom_point()
class(sa_hour$weathersit)
set.seed(1234)
ids=sample(nrow(hour),nrow(hour)*0.10)
sa_hour=hour[ids,]
###Final analysis started
sp<-ggplot(sa_hour,aes(temp,cnt,color=windspeed))+geom_point()+scale_color_gradient(low="blue", high="red")
sp+facet_grid(weathersit ~.) + coord_cartesian(xlim=c(0.25,0.75), ylim=c(0,500))
cor(sa_hour$temp,sa_hour$cnt)

##################################################
install.packages(heatmap)
library(heatmap)
class(sa_hour$cnt)


#############################################################################
#One continuous variable
  #cnt
  ggplot(sa_hour,aes(cnt))+geom_histogram()
  #temp
  ggplot(sa_hour,aes(temp))+geom_histogram()
  ggplot(sa_hour,aes(1,temp))+geom_boxplot()
#One discrete variableg
  ggplot(sa_hour,aes(weathersit))+geom_bar()
  ggplot(sa_hour,aes(workingday))+geom_bar()
  ggplot(sa_hour,aes(weekday))+geom_bar()
  ggplot(sa_hour,aes(holiday))+geom_bar()
  ggplot(sa_hour,aes(season))+geom_bar()
  ggplot(sa_hour,aes(yr))+geom_bar()
  sa_hour$mnth=as.factor(sa_hour$mnth)
  ggplot(sa_hour,aes(mnth))+geom_bar()
#Two continuous variable
  ggplot(sa_hour,aes(temp,cnt))+geom_point()
#Two discrete variable
  
#One continuous variable
  
# Two continuous and one discrete variable

# Three continuous variable
  sp<-ggplot(sa_hour,aes(temp,cnt,color=windspeed))+geom_point()+scale_color_gradient(low="blue", high="red")
  sp+facet_grid(weathersit ~.) + coord_cartesian(xlim=c(0.1,1), ylim=c(0,500))
