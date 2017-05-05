#Land use shapefile

# create the raster layers from the land use tif image from US gov
# and crop for the California region we are interested in

#Packages
library(rgdal)
library(raster)

#data (it was delited because was too big to be armazened online)
lu <- raster("vegType/LCType.tif")

#axis limits
xlim <- c(-124.8 - 3, -114.0 + 3)
ylim <- c(32.47 - 3, 42 + 3)

#cropping layer
cropl <- extent(xlim, ylim)
luCrop <- crop(lu, cropl)
writeRaster(luCrop, filename = "LCType", format ='ascii', overwrite = T, na.value = -9999, datatype = "FLT4S")

plot(luCrop)
