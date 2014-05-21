library("rgdal")
library("sp")
library("maptools")

#Prep the base layers of the map
pdxmap.poly <- readShapePoly("Data/ShapeFiles/Neighborhoods_pdx.shp")

#Merge in the data
pdxmap.poly@data=merge(pdxmap.poly@data,neighborhood.num,by.x='NAME',by.y='mapneighbor', all.x=T, sort=F)
nnames <- pdxmap.poly$NAME
nnamesLabel <- 1:length(pdxmap.poly$NAME)
pdxmap.poly$Count[is.na(pdxmap.poly$Count)] <- 0
plot(pdxmap.poly,col=rgb(red = 0, green = 0, blue = 1-(pdxmap.poly@data$Count/max(pdxmap.poly@data$Count)), alpha=pdxmap.poly@data$Count/max(pdxmap.poly@data$Count)))
text(getSpPPolygonsLabptSlots(pdxmap.poly), labels=nnames, cex=0.4)