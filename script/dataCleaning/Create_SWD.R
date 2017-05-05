

# Creating SDW files where we get environmetal data at the observation points

rm(list=ls()) #housekeeping, removing old variables

library(raster)
library(maptools)
library(sp)
library(rgdal)


setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data")

####  Read the climate data ####
temp <- raster::raster("mean_t.asc" )
pres <- raster::raster("mean_pres.asc")
clim <- raster:: stack(temp, pres)
## Read land-use dat
landuse <- raster::raster("LCType.asc")


# read sp observation data
dat <- read.csv("allbird_unique.csv", sep=",", header=T)
dat <- na.omit(dat)
str(dat)
LonLatData <- dat[,c(3,2)]
str(LonLatData)


# get climate data at obs. points

ClimateAtObsPoints <- raster::extract(clim,LonLatData)   
head(ClimateAtObsPoints)

# get landuse at observations points

LanduseAtObsPoints <- raster::extract(landuse,LonLatData) 
LanduseAtObsPoints <- as.data.frame(LanduseAtObsPoints)
head(LanduseAtObsPoints)
       
# Combine
combined <-as.data.frame(cbind(dat$species, LonLatData,LanduseAtObsPoints, ClimateAtObsPoints))
colnames(combined) <-c("species","longitude","latitude","landuse", "mean_temp", "mean_pres")
combined <- na.omit(combined)

# Wite the file
write.csv(combined,file ="Data_SWD.csv" ,row.names=FALSE)





