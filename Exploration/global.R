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
library("rgdal")
library("sp")
library("maptools")

#Load in the crime data and munge time values for time-series fields.
#crime2012 <- read.csv("../Data/crime_incident_data.csv", header=T, sep=",", quote="\"", as.is=T)
#crime2012$reptime <- strptime(paste(crime2012$Report.Date, " ", crime2012$Report.Time, sep=""), "%m/%d/%Y %H:%M:%S")
#crime2012$repdate <- format(crime2012$reptime, "%Y-%m-%d")
crime.reps <- read.csv("../Data/CrimeSeries.csv", header=T, sep=",", quote="\"", as.is=T)
crime.reps$reptime <- strptime(paste(crime.reps$Report.Date, " ", crime.reps$Report.Time, sep=""), "%m/%d/%Y %H:%M:%S")
crime.reps$repdate <- format(crime.reps$reptime, "%Y-%m-%d")
crime.reps$repyear <- format(crime.reps$reptime, "%Y")


#Extract neighborhoods and crime types for listing.
nb.list <- unique(crime.reps$Neighborhood)
mot.list <- unique(crime.reps$Major.Offense.Type)
year.list <- unique(crime.reps$repyear)

#General graph formatting rules:
p.theme <- theme(plot.background = element_rect(fill = "#CC9966"))

#Functions to parse groups in crime data:
speccrime <- function(type,neigh){
      ret <- {
        crime.reps %.%
                select(Neighborhood, Major.Offense.Type, repdate, repyear) %.%
                filter(Major.Offense.Type %in% type, Neighborhood == neigh) %.%
                group_by(Neighborhood, Major.Offense.Type, repdate, repyear) %.%
                summarise(Count = n())
      }
      return(ret)
}

c.neigh <- function(type,year){
  ret <- {
    crime.reps %.%
    select(Neighborhood, Major.Offense.Type, repyear) %.%
    filter(Major.Offense.Type %in% type, repyear %in% year) %.%
    group_by(Neighborhood) %.%
    summarise(Count = n())
  }
  return(ret)
}

#Load the basic Polymap and neighborhood data
pdxmap.poly <- readShapePoly("../Data/ShapeFiles/Neighborhoods_pdx.shp")
neighborhood.list <- read.csv("../Data/alignedlist.csv", header=T, sep="\t", quote="\"", as.is=T)



