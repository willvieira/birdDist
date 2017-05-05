#Birds joints species distribution

#source
  #Add transparent color
source("/Users/wvieira/Documents/GitHub/NativeFunctions/addTransColor.R")

#data
  #Bird distribuition
bd <- read.csv("allbird_unique.csv")
names(bd) <- c("names", "lat", "lon")

  #plot
plot(bd$lon,
     bd$lat,
     cex = .5,
     pch = 16,
     col = addTrans(ifelse(bd$name == "Mountain_Bluebird", "blue",
        ifelse(bd$name == "House_Wren","Brown",
        ifelse(bd$name == "Lewis_Woodpecker","#0f9200",
        ifelse(bd$name == "Black_backed_Woodpecker","yellow", "gray"
)))), 80),
   xlab = "",
   ylab = "",
)

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

#Abs data
blue.bird <- read.table("abs.txt", head = T)
plot(blue.bird$log, blue.bird$lat)

##EXTRA
#Another data
bb <- read.table("birdDist/bb.txt", head = T)
hw <- read.table("birdDist/hw.txt", head = T, dec = ",")
lw <- read.table("birdDist/lw.txt", head = T)
lw$lat <- as.numeric(lw$lat)
lw$lon <- as.numeric(lw$lon)
mc <- read.table("birdDist/mc.txt", head = T)
mc <- na.omit(mc)
wp <- read.table("birdDist/wp.txt", head = T)

bd$col[which(bd$name == "Black_backed_Woodpecker")] = "blue"
bd$col[which(bd$name == "House_Wren")] = "red"
bd$col[which(bd$name == "Lewis_Woodpecker")] = "black"
bd$col[which(bd$name == "Mountain_Bluebird")] = "green"
bd$col[which(bd$name == "Mountain_Chickadee")] = "yellow"
