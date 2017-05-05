##


rm(list=ls()) #housekeeping, removing old variables

### libraries #####
library(raster)
library(sp)
library(rgdal)
setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data/world_clim")


###############################################################

#### Read the climate data  #####


# tile 11 precipitation#
setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data/world_clim/prec_11_tif")

# create the raster layers from all the files in the folder
rlist=list.files(getwd(), pattern="tif$", full.names=FALSE)

fnames <- NULL
# read all data into raster files, 12 files, one mean for each month
for(i in rlist) { assign(unlist(strsplit(i, "[.]"))[1], raster(i))
  tmp <- unlist(strsplit(i, "[.]"))[1]
  fnames <-c(fnames, tmp) }  # create list of the layers 
mget(fnames)

dat <- stack(mget(fnames))
mean.pres11 <- calc(dat, fun=sum)/12  # calculate monthly average by taking a sum/12
plot(mean.pres11)


# tile 12 precipitation#
setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data/world_clim/prec_12_tif")

# create the raster layers from all the files in the folder
rlist=list.files(getwd(), pattern="tif$", full.names=FALSE)

fnames <- NULL
# read all data into raster files, 12 files, one mean for each month
for(i in rlist) { assign(unlist(strsplit(i, "[.]"))[1], raster(i))
  tmp <- unlist(strsplit(i, "[.]"))[1]
  fnames <-c(fnames, tmp) }  # create list of the layers 
mget(fnames)

dat <- stack(mget(fnames))
mean.pres12 <- calc(dat, fun=sum)/12  # calculate monthly average by taking a sum/12
plot(mean.pres12)

# merge tiles 11 and 12
precipitation <- merge(mean.pres11, mean.pres12)

setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data")

writeRaster(precipitation, filename="mean_pres", format ='ascii', overwrite=T, na.value=-9999,datatype="FLT4S")



###############################################
########### Temperature      #############


# tile 11 temperature#
setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data/world_clim/tmean_11_tif")

# create the raster layers from all the files in the folder
rlist=list.files(getwd(), pattern="tif$", full.names=FALSE)

fnames <- NULL
# read all data into raster files, 12 files, one mean for each month
for(i in rlist) { assign(unlist(strsplit(i, "[.]"))[1], raster(i))
  tmp <- unlist(strsplit(i, "[.]"))[1]
  fnames <-c(fnames, tmp) }  # create list of the layers 
mget(fnames)

dat <- stack(mget(fnames))
mean.t11 <- calc(dat, fun=sum)/12  # calculate monthly average by taking a sum/12
plot(mean.t11)


# tile 12 temperature
setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data/world_clim/tmean_12_tif")

# create the raster layers from all the files in the folder
rlist=list.files(getwd(), pattern="tif$", full.names=FALSE)

fnames <- NULL
# read all data into raster files, 12 files, one mean for each month
for(i in rlist) { assign(unlist(strsplit(i, "[.]"))[1], raster(i))
  tmp <- unlist(strsplit(i, "[.]"))[1]
  fnames <-c(fnames, tmp) }  # create list of the layers 
mget(fnames)

dat <- stack(mget(fnames))
mean.t12 <- calc(dat, fun=sum)/12  # calculate monthly average by taking a sum/12
plot(mean.pres12)

# merge tiles 11 and 12
temp<- merge(mean.t11, mean.t12)

setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/data")

writeRaster(temp, filename="mean_t", format ='ascii', overwrite=T, na.value=-9999,datatype="FLT4S")


## read theh raster to check that it is read correctly

temp <- raster("mean_t.asc" )
plot(temp)
