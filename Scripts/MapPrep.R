library("rgdal")
library("sp")
ogrListLayers("Data/ShapeFiles/Neighborhoods_pdx.shp")
shape <- readOGR("Data/ShapeFiles/Neighborhoods_pdx.shp", layer="Neighborhoods_pdx")
plot(shape)

#Set Colors for neighborhood based on reports of crime - B/W for testing
shape$crimes = 1 #adds the attribute members
shape$crimes[match(neighborhood.num$mapneighbor, shape$NAME)]=neighborhood.num$Count[match(neighborhood.num$mapneighbor, shape$NAME)] #will make new values at given countries
shape$crimes[is.na(shape$crimes)] <- 0

plot(shape, col=gray(1-(shape$crimes/max(shape$crimes)))) #adjust the colorramp
plot(shape, col=rgb(red = 0, green = 0, blue = 1-(shape$crimes/max(shape$crimes)), alpha=shape$crimes/max(shape$crimes))) #adjust the colorramp

plot(shape)
names(shape)

shape$NAME
