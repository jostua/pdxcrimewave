library("dplyr")
library("ggplot2")
library("reshape2")

#load the data and modify the time value
crime2012 <- read.csv("Data/crime_incident_data.csv", header=T, sep=",", quote="\"", as.is=T)
crime2012$reptime <- strptime(paste(crime2012$Report.Date, " ", crime2012$Report.Time, sep=""), "%m/%d/%Y %H:%M:%S")
crime2012$repdate <- format(crime2012$reptime, "%Y-%m-%d")

#load the neighborhood alignment data
neighborhood.list <- read.csv("Data/alignedlist.csv", header=T, sep="\t", quote="\"", as.is=T)

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

crimeneighborhood <- {crime2012 %.%
                        select(Neighborhood, Major.Offense.Type) %.%
                        group_by(Neighborhood) %.%
                        summarise(Count = n())}

neighborhood.num <- merge(neighborhood.list, crimeneighborhood, by.x="crimeneighbor", by.y="Neighborhood", incomparables="0")
neighborhood.num$Count[neighborhood.num$Count == "NA"] <- 0

speccrime <- {crime2012 %.%
                        select(Neighborhood, Major.Offense.Type, repdate) %.%
                        filter(Major.Offense.Type == "Larceny", Neighborhood == "KERNS") %.%
                        group_by(Neighborhood, repdate) %.%
                        summarise(Count = n())}

TimeSeries.SpecCrime <- ggplot(data=speccrime) + geom_smooth(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=Neighborhood, color=Neighborhood))
TimeSeries.SpecCrime
crimeneighborhood[order(-crimeneighborhood$Count),][1:10,]

crimenb <- {crime2012 %.%
                        select(Neighborhood, Major.Offense.Type) %.%
                        filter(Neighborhood == c("DOWNTOWN","KERNS","SUMNER"))}

ctb <- table(crimenb)
mosaicplot(ctb)