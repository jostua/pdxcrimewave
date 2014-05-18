########
#
# Global file -- Load all general data and functions.
# Shiny app for exploration of data.
#
########

#Load required libraries
library("shiny")
library("dplyr")
library("ggplot2")

#Load in the crime data and munge time values for time-series fields.
crime2012 <- read.csv("../Data/crime_incident_data.csv", header=T, sep=",", quote="\"", as.is=T)
crime2012$reptime <- strptime(paste(crime2012$Report.Date, " ", crime2012$Report.Time, sep=""), "%m/%d/%Y %H:%M:%S")
crime2012$repdate <- format(crime2012$reptime, "%Y-%m-%d")

#Extract neighborhoods and crime types for listing.
nb.list <- unique(crime2012$Neighborhood)
mot.list <- unique(crime2012$Major.Offense.Type)

#General graph formatting rules:
p.theme <- theme(plot.background = element_rect(fill = "#CC9966"))

#Functions to parse groups in crime data:
speccrime <- function(type,neigh){
      ret <- {
        crime2012 %.%
                select(Neighborhood, Major.Offense.Type, repdate) %.%
                filter(Major.Offense.Type == type, Neighborhood == neigh) %.%
                group_by(Neighborhood, repdate) %.%
                summarise(Count = n())
      }
      return(ret)
}

