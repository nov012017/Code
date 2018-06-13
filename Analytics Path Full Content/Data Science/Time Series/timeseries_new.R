### read the data from sources 

kings = scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
births = scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
souvenir = scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
rain = scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)
skirts = scan("http://robjhyndman.com/tsdldata/roberts/skirts.dat",skip=5)

### Forecasting 
kings
### install forecast and TTR packages 
head(kings)
kingstimeseries = ts(kings)
kingstimeseries
## Timeseries plot of kings timeseries 
plot.ts(kingstimeseries)


## Births timeseries 
births

## convert birth data to time series, starting from Jan, 1946
head(births)
birthstimeseries = ts(births, frequency=12, start=c(1946,1))
birthstimeseries

## Timeseries plot of birth series, indicates seasionality 
plot.ts(birthstimeseries)

### decompose birth timeseries 
birthdecomp = decompose(birthstimeseries)

### plot decomposition of birth timeseries 

plot(birthdecomp)

### souvenier time series( Non stationary)
souvenir

souvenirtimeseries = ts(souvenir, frequency=12, start=c(1987,1))
souvenirtimeseries
## Non stationary series with spikes increasing 
plot.ts(souvenirtimeseries)

logsovseries = log(souvenirtimeseries)
plot.ts(logsovseries)
## Log conversion to bring the spikes magnitude down 
logsouvenirtimeseries = log(souvenirtimeseries)
plot.ts(logsouvenirtimeseries)

### Simple moving averages 

plot.ts(kingstimeseries)
library("TTR")
#install.packages("forecast")
library("forecast")

## simple moving averages of order 3 
kingstimeseriesSMA3 = SMA(kingstimeseries,n=3)
kingstimeseriesSMA3
plot.ts(kingstimeseriesSMA3)
plot.ts(kingstimeseries)

kingstimeseries
kingstimeseriesSMA5 = SMA(kingstimeseries,n=5)
plot.ts(kingstimeseriesSMA5)

kingstimeseriesSMA10 = SMA(kingstimeseries,n=10)
plot.ts(kingstimeseriesSMA10)


## compare the origina kings timeseries with Moving averages 

kingstimeseries

kingstimeseriesSMA3

kingstimeseriesSMA3  = SMA(kingstimeseries,n=3)
plot.ts(kingstimeseriesSMA3)

#### holtwinters on kings series 


kingsholtwinters = HoltWinters(kingstimeseries, gamma=F)

plot.ts(kingsholtwinters)

kingsholtwinters
## Decomposing time series 
plot.ts(birthstimeseries)

birthstimeseriescomponents = decompose(birthstimeseries)
birthdecom = decompose(birthstimeseries)
plot(birthdecom)
plot(birthstimeseriescomponents)
birthstimeseriescomponents

### seasonality 
birthstimeseriescomponents$seasonal

## trend 

birthstimeseriescomponents$trend


## seasionality adjusting ( remove sesionality to check the trend and randomness)
birthstimeseriescomponents = decompose(birthstimeseries)
birthstimeseriesseasonallyadjusted = birthstimeseries - birthstimeseriescomponents$seasonal

plot(birthstimeseriesseasonallyadjusted) ## seasionality adjusted 

#### holtwinters exponential smoothing on birthseries 

birthhw = HoltWinters(birthstimeseries, gamma = F)

plot(birthhw)

## include seasonality 

birthhw_sea = HoltWinters(birthstimeseries)

plot(birthhw_sea)

### forecast using hw model 
#birthsforecast = forecast.HoltWinters(birthhw_sea, h = 12)##not working
#method1
birthsforecast1 = forecast(birthhw_sea, h = 12)
plot(birthsforecast1)

#birthsforecast2=ets(birthhw_sea, h = 12)
#birthsforecast2 = forecast(birthsforecast2, h = 12)
#plot(birthsforecast2)
#model3
birthsforecast3 = forecast::holt(birthstimeseries, h = 12)
birthsforecast3
plot(birthsforecast3)
#model4
birthsforecast4=HoltWinters(birthstimeseries)
birthsforecast4 = forecast(birthsforecast4, h = 12)
birthsforecast4
plot(birthsforecast4)

### HW forecasts with multipilicative 

plot.ts(souvenirtimeseries)

sov_hw = HoltWinters(souvenirtimeseries, seasonal = "multiplicative")

plot(sov_hw)

#sov_forec = forecast.HoltWinters(sov_hw, h = 12)
sov_forec = forecast(sov_hw, h = 12)

plot(sov_forec)

sov_add = HoltWinters(souvenirtimeseries) ## default is additive 

plot(sov_add)

#sov_add_forec = forecast.HoltWinters(sov_add, h = 12)
sov_add_forec = forecast(sov_add, h = 12)

plot(sov_add_forec)
