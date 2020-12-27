library("astsa")
library("dplyr")
setwd("E:/")
data=read.csv("tn2000.csv")
windspeed=data$DNI.Perez.Units
windspeed=ts(as.numeric(windspeed[3:length(windspeed)]))
month=data$Location.ID
day=data$City
month=as.numeric(month[3:length(month)])
day=as.numeric(day[3:length(day)])
df=data.frame(month,day,windspeed)
#https://datacarpentry.org/R-genomics/04-dplyr.html

monthly_data=df %>% group_by(month) %>% summarize(windspeed=mean(windspeed,na.rm=T))
daily_data=df %>% group_by(month,day) %>% summarize(windspeed=mean(windspeed,na.rm=T))
daily_data$windspeed

library("astsa")
library("forecast")
library("dplyr")
library("xts")
library("lubridate")
setwd("E:/ASM Final Data")
data=read.csv("Tamil Nadu.csv")
windspeed=ts(data$Wind.Speed)
year=data$Year
month=data$Month
day=data$Day
monthly_data=data %>% group_by(Year,Month) %>% summarize(windspeed=mean(Wind.Speed,na.rm=T))
daily_data=data %>% group_by(Year,Month,Day) %>% summarize(windspeed=mean(Wind.Speed,na.rm=T))


head(monthly_data)
time=ymd(paste(monthly_data$Year,monthly_data$Month,"15",sep="-"))
data=cbind(as.Date(time),monthly_data$windspeed)
plot(time,monthly_data$windspeed,type="l",ylab="Monthly windspeed")

head(daily_data)
library("MASS")
daily_data=data.frame(daily_data)
mdata=melt(daily_data,id=c("Year","Month","Day"))
head(mdata,20)
cdata=cast(mdata,Year~Month,mean)

cdata=cast(mdata,Year+Month~Day,mean)
cdata