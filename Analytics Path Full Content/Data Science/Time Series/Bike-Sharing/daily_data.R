#####Time series 
#https://www.datascience.com/blog/introduction-to-forecasting-with-arima-in-r-learn-data-science-tutorials

daily_data = read.csv("D:\\Data Science\\Time Series\\day.csv", header=TRUE, stringsAsFactors=FALSE)
#daily_data = read.csv("D:/Data Science/Time Series/day.csv", header=TRUE, stringsAsFactors=FALSE)

library(ggplot2)
library(forecast)
library(tseries)

str(daily_data)
daily_data$Date=as.Date(daily_data$dteday)
##plot for no.of bikes vs date
ggplot(daily_data,aes(Date,cnt))+
  geom_line()+
  ylab("Daily Bike Checkouts")+
  xlab("month")

count_ts=ts(daily_data[,c('cnt')])
daily_data$clean_cnt=tsclean(count_ts)
##Plot for cleaned bicycle data
ggplot(daily_data,aes(Date,clean_cnt))+geom_line()

daily_data$cnt_ma=ma(daily_data$clean_cnt,order = 7)##for weekly moving avg
daily_data$cnt_ma30=ma(daily_data$clean_cnt,order = 30)##for monthly moving avg
##
ggplot() +
  geom_line(data = daily_data, aes(x = Date, y = clean_cnt, colour = "Counts")) +
  geom_line(data = daily_data, aes(x = Date, y = cnt_ma,   colour = "Weekly Moving Average"))  +
  geom_line(data = daily_data, aes(x = Date, y = cnt_ma30, colour = "Monthly Moving Average"))  +
  ylab('Bicycle Count')

count_ma=ts(na.omit(daily_data$cnt_ma),frequency = 30)
decomp=stl(count_ma,s.window = "periodic")
deseasonal_cnt=seasadj(decomp)
plot(decomp)
#Fitting an ARIMA model requires the series to be stationary.
#The augmented Dickey-Fuller (ADF) test is a formal statistical test for stationarity.
#The null hypothesis assumes that the series is non-stationary

#ADF test
adf.test(count_ma,alternative = "stationary")

#acf plot-- determining the order of the M A (q) model. 
Acf(count_ma,main='')
#PACF plots are useful when determining the order of the AR(p) model.

Pacf(count_ma,main='')

##For getting stationary 
count_d1=diff(deseasonal_cnt,differences = 1)
plot(count_d1)

#Test again for Stationary
adf.test(count_d1,alternative = "stationary")
#p-value =0.01(which is less ghan 0.05--to reject null hypothesis(Non-stationary))

#To know p & q values
Acf(count_d1, main='ACF for Differenced Series')###q=1,2
Pacf(count_d1, main='PACF for Differenced Series')##p=lag 7
#A spike at lag 7 might suggest that there is a seasonal pattern present.

##############################
## Fitting an ARIMA model
##############################
#arima() function- automatically generate a set of optimal (p, d, q) using auto.arima().
#This function searches through combinations of order parameters and
#picks the set that optimizes model fit criteria.

fit<-auto.arima(deseasonal_cnt,seasonal = FALSE)
fit
tsdisplay(residuals(fit),lag.max = 45,main = '(1,1,1) Model residuals')

#ar(1),ma(1)
#There exist a number of such criteria for comparing quality of fit 
#across multiple models.
#Two of the most widely used are
#1)Akaike information criteria (AIC) and
#2)Baysian information criteria (BIC).

#second model using ma(7)
fit2<-arima(deseasonal_cnt,order = c(1,1,7))
fit2
tsdisplay(residuals(fit),lag.max = 15,main = '(1,1,7) Seasonal model residuals')

#forecasting 
fcast<-forecast(fit2,h=30)
plot(fcast)

## We can specify forecast horizon h periods ahead for predictions to be made, 
#and use the fitted model to generate those predictions.

hold <- window(ts(deseasonal_cnt), start=700)

fit_no_holdout = arima(ts(deseasonal_cnt[-c(700:725)]), order=c(1,1,7))

fcast_no_holdout <- forecast(fit_no_holdout,h=25)
plot(fcast_no_holdout, main=" ")
lines(ts(deseasonal_cnt))

###the blue line representing forecast seems very naive.
#How can we improve the forecast and iterate on this model? 
#One simple change is to add back the seasonal component we extracted earlier.
fit_w_seasonality = auto.arima(deseasonal_cnt, seasonal=TRUE)
fit_w_seasonality

seas_fcast <- forecast(fit_w_seasonality, h=30)
plot(seas_fcast)
