library("rgdal")
library("sp")
library("maptools")
ogrListLayers("Data/ShapeFiles/Neighborhoods_pdx.shp")
shape <- readOGR("Data/ShapeFiles/Neighborhoods_pdx.shp", layer="Neighborhoods_pdx")
plot(shape)

#Set Colors for neighborhood based on reports of crime - B/W for testing
shape$crimes = 1 #adds the attribute members
shape$crimes[match(neighborhood.num$crimeneighbor, shape$NAME)]=neighborhood.num$Count[match(neighborhood.num$crimeneighbor, shape$NAME)] #will make new values at given countries
shape$crimes[is.na(shape$crimes)] <- 0

plot(shape, col=gray(1-(shape$crimes/max(shape$crimes)))) #adjust the colorramp
plot(shape, col=rgb(red = 0, green = 0, blue = 1-(shape$crimes/max(shape$crimes)), alpha=shape$crimes/max(shape$crimes))) #adjust the colorramp

plot(shape)
names(shape)

shape$NAME

gor <- readShapeSpatial("Data/ShapeFiles/Neighborhoods_pdx.shp")
plot(gor)
summary(gor)
gor@data$NAME
gor@data=merge(gor@data,neighborhood.num,by.x='NAME',by.y='crimeneighbor')
nnames <- shape$NAME
plot(gor,col=rgb(red = 0, green = 0, blue = 1-(gor@data$Count/max(gor@data$Count)), alpha=gor@data$Count/max(gor@data$Count)))
text(getSpPPolygonsLabptSlots(gor), labels=nnames, cex=0.4)
gor@data$NAME

text(getSpPPolygonsLabptSlots(gor), labels=gor@data$OBJECTID, cex=0.4)
shape$crimes
gor@data$NAME[order(gor@data$NBO_)]
