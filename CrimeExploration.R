library("dplyr")
library("ggplot2")
library("reshape2")

#load the data and modify the time value
crime2012 <- read.csv("Data//crime_incident_data.csv", header=T, sep=",", quote="\"", as.is=T)
crime2012$reptime <- strptime(paste(crime2012$Report.Date, " ", crime2012$Report.Time, sep=""), "%m/%d/%Y %H:%M:%S")
crime2012$repdate <- format(crime2012$reptime, "%Y-%m-%d")

names(crime2012)

crimetime <- {crime2012 %.%
  select(Major.Offense.Type, repdate) %.%
  group_by(repdate) %.%
  summarise(Count = n())}

#generate a time series plot, showing all crime across the year.
Genernal.TimeSeries <- ggplot(data=crimetime) + geom_line(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=1)) + geom_smooth(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=1))

#plot shows that crime is a generally even across the year.
#generate plot that shows highest crime types across city through the year.

crimetype <- {crime2012 %.%
                select(Major.Offense.Type, repdate) %.%
                group_by(Major.Offense.Type, repdate) %.%
                summarise(Count = n())}

TimeSeries.ByType <- ggplot(data=crimetype) + geom_smooth(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=Major.Offense.Type, color=Major.Offense.Type))
TimeSeries.ByType
