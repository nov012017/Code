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

#birthstimeseriescomponents = decompose(birthstimeseries)
birthdecom = decompose(birthstimeseries)
plot(birthdecom)
#plot(birthstimeseriescomponents)
birthdecom

### seasonality 
birthstimeseriescomponents$seasonal

## trend 

birthstimeseriescomponents$trend


## seasionality adjusting ( remove sesionality to check the trend and randomness)
birthstimeseriescomponents = decompose(birthstimeseries)
birthstimeseriesseasonallyadjusted = birthstimeseries - birthstimeseriescomponents$seasonal

plot(birthstimeseriesseasonallyadjusted) ## seasionality adjusted 


### 

#### holtwinters exponential smoothing on birthseries 
plot.ts(birthstimeseries)
birthhw = HoltWinters(birthstimeseries, gamma = F)

plot(birthhw)

## include seasonality 

birthhw_sea = HoltWinters(birthstimeseries)

plot(birthhw_sea)

### forecast using hw model 

birthsforecast = forecast.HoltWinters(birthhw_sea, h = 12)
birthsforecast
plot.forecast(birthsforecast)

### HW forecasts with multipilicative 
?HoltWinters
plot.ts(souvenirtimeseries)

sov_hw = HoltWinters(souvenirtimeseries, seasonal = "multiplicative")

plot(sov_hw)

sov_forec = forecast.HoltWinters(sov_hw, h = 12)

plot(sov_forec)

sov_add = HoltWinters(souvenirtimeseries) ## default is additive 

plot(sov_add)

sov_add_forec = forecast.HoltWinters(sov_add, h = 12)

plot(sov_add_forec)
##################################################
### Arima 
##################################################
skirtsseries = ts(skirts)
plot(skirtsseries)

### first order differences 

skirtsdiff1 = diff(skirtsseries, 1) ## 1 for first order differences 

plot(skirtsdiff1)

skirtsdiff2 = diff(skirtsseries, 2)

plot(skirtsdiff2)

##sovenier timeseries differences 

sov_diff1 = diff(souvenirtimeseries, 1)

plot(sov_diff1)

Sov_diff2 = diff(souvenirtimeseries, 2)

plot(Sov_diff2)

### p and q 

pacf(souvenirtimeseries)

acf(souvenirtimeseries)

## rainseries 

## auto.arima 

rainforec = HoltWinters(rainseries, beta=F, gamma = F)

plot(rainforec)

rainarima = auto.arima(rainseries)

rainarima

#### arima(p,d,q)

rainarima = arima(rainseries, c(1,0,1))

### Chennai rainfall ARIMA prediction 

setwd("D:/AP/Forecasting")

rainfall = read.csv("Chennai_rainfall.csv", sep=",")

head(rainfall)


rain = rainfall$Rain

chennirain = ts(rain, frequency = 12, start = c(2000,1))

plot.ts(chennirain)

### Decomposint the rain series 

raindecom = decompose(chennirain)

plot(raindecom)


### acf 

acf(chennirain)

### auto.arima on chennai rainfall data 

rain.arima = auto.arima(chennirain)

### forecasts for next six months 

rain_forec = forecast.Arima( rain.arima, h = 18)

plot(rain_forec)

chennirain

## holtwinters forecasts on rainfall data 

Chennai_hw = HoltWinters(chennirain, seasonal = "additive")

plot(Chennai_hw)

Chen_hw_forecasts = forecast.HoltWinters(Chennai_hw, h = 6)
Chen_hw_forecasts
plot(Chen_hw_forecasts)
#################################################
### Arimax model on Chennai Ranfall data
#################################################
require(gridExtra)
library(ggplot2)
p1 = ggplot(rainfall, aes(x = X2, y = Rain)) +
  ylab("Rainfall") +
  xlab("Years") +
  geom_line(color = "Red") +
  coord_cartesian( xlim = c(2000,2010))+
  expand_limits(x = 0, y = 0)+
  ggtitle("IOD Vs rainfall")
p1


p2 = ggplot(rainfall, aes(x = X2, y = IOD)) +
  ylab("IOD") +
  xlab("Year") +
  coord_cartesian( xlim = c(2000,2010))+
  geom_line(color = "blue" ) +
  expand_limits(x = 0, y = 0)

grid.arrange(p1, p2, ncol=1, nrow=2)

cor(rainfall$Rain, rainfall$IOD)

### subset rainfall data for first 142 records( IOD is present)

rainfall2 = rainfall[1:141, ]

cor(rainfall2$Rain, rainfall2$IOD)

cor(rainfall2$Rain, rainfall2$QBO)

####  Arimax model 

rainseries2 = ts(rainfall2$Rain, frequency = 12, start=c(2000,1))

plot.ts(rainseries2)

# Auto.arima to pick values of p,d,q + Seasonality 

ran.arima2 = auto.arima(rainseries2)

ran.arima2

rain.arima2.forec = forecast.Arima(ran.arima2, h = 6)

names(rain.arima2.forec)

forecasts = rain.arima2.forec$mean

### Forecast error for Oct2011 - Mar2012
Error = c((164-265) , (151-455), (188-136), (81.4 - 16), (111.34-0), (80.7-1.6))

sqrt(mean(Error**2))

## Arimax with input variables 

IOD = rainfall2$IOD

rainfall.arimax = auto.arima(rainseries2, xreg = IOD )
rainfall.arimax

iod_oct_mar = c( -1.26547,
                 -1.22639,
                 -1.18675,
                 -1.17104,
                 -1.0395,
                 -0.949399
)


IOD2 = c( 0.601301,
          0.627266,
          0.914361,
          1.24823,
          1.18201,
          0.948318
)
arimax.forecasts = forecast.Arima(rainfall.arimax, h = 6, xreg = c(iod_oct_mar))

arimax.forecasts2 = forecast.Arima(rainfall.arimax, h = 6, xreg = c(IOD2))


Error = c((200-265) , (175-455), (135-136), (6 - 16), (35-0), (18-1.6))

sqrt(mean(Error**2))

### WE take first 100 records for training 

rainfall3 = rainfall[1:100, ]
rainseries3 = ts(rainfall3$Rain, frequency = 12, start=c(2000,1))

IOD3 = rainfall3$IOD

rainfall.arimax3 = auto.arima(rainseries3, xreg = IOD3 )
rainfall.arimax3

iodnew = c( 0.240564,
            0.348197,
            0.659291,
            0.632725,
            0.399848,
            0.14576
)

rainfall.arimax3.fore = forecast.Arima(rainfall.arimax3, h = 6, xreg = iodnew )

rainfall.arimax3.fore



### include QBO values into the xreg  

QBO = rainfall2$QBO

IOD_QBO = rainfall2[, 6:7]

rainfall.arimax2 = auto.arima(rainseries2, xreg=IOD_QBO)

#### Subset IOD and QBO values 

IOD_QBO = rainfall2[, 6:7]

rainfall.arimax2 = auto.arima(rainseries2, xreg=IOD_QBO)
#### select IOD and QBO values for Dec2010 to May2011 
IOD_QBO_fut = rainfall[132:137, 6:7]
rain.forecats2 = forecast.Arima(rainfall.arimax2, h = 6,xreg = IOD_QBO_fut )

rain.forecats2

