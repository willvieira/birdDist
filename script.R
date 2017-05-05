
  #Climate data
# create the raster layers from all the files in the folder
#setwd("/Users/wvieira/Documents/GitHub/birdDist/data")
library(rgdal)
library(raster)
#data
lu <- raster("vegType/LCType.tif")

#axis limites
xlim <- c(-124.8 - 3, -114.0 + 3)
ylim <- c(32.47 - 3, 42 + 3)

#plot(lu, xlim = xlim, ylim = ylim)

cropl <- extent(xlim, ylim)
lu2 <- crop(lu, cropl)
writeRaster(lu2, filename = "LCType", format ='ascii', overwrite = T, na.value = -9999, datatype = "FLT4S")
