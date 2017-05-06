############################################################################################
##
## coding presence absence at housewren sites
## from tutorial http://www.molecularecologist.com/2013/04/species-distribution-models-in-r/
############################################################################################

rm(list=ls())

library(rgeos)
library(maptools)
library(maps)
library(mapdata)
library(dismo)

#import the bird and environmental data

data_swd <-read.table("C:/Users/kvieka/Documents/GitHub/birdDist/data/birdDist/allbird_withbackground.csv", header = TRUE, sep = ",")
str(data_swd)
bg<-subset(data_swd, species == "background_HOWR")
str(bg)
locs <- bg[,c("longitude", "latitude")]
head(locs)  # get site mid point coordinates

# Mountain_chickadee
mochs<-subset(data_swd, species == "Mountain_Chickadee")
head(mochs)
locs_moch <-mochs[,c("longitude", "latitude")]
str(locs_moch)

# Mountain bluebird
mobl2<-subset(data_swd, species == "Mountain_Bluebird")
head(mobl2)
locs_mobl <- mobl2[,c("longitude", "latitude")]
str(locs_mobl)


# Lewis woodpecker
lewo2<-subset(data_swd, species == "Lewis_Woodpecker")
str(lewo2)
head(lewo2)
locs_lewo <- lewo2[,c("longitude", "latitude")]
str(locs_lewo)


# Black backed woodpecker
bbwo2<-subset(data_swd, species == "Black_backed_Woodpecker")
head(bbwo2)
locs_bbwo <- bbwo2[,c("longitude", "latitude")]
str(locs_bbwo)


#################################################################################
# turn background points into polygons
#

# creating buffer that returns polygons for each site
sites <- SpatialPoints(locs)
poly <- rgeos::gBuffer(sites, width =0.002, byid = T )   # this is about 200m radius
      # based on the length of a degree at 40 degree latitude 
      # https://msi.nga.mil/MSISiteContent/StaticFiles/Calculators/degree.html
plot(poly)

#within is a polygon, extract points for each species if they're within the polygon.

#locs_moch
locs_moch <-SpatialPoints(locs_moch)
moch <- as.data.frame(sp::over(poly, locs_moch))
colnames(moch)<- "MOCH"
moch$MOCH <- as.numeric(moch$MOCH)
moch$MOCH <- ifelse(is.na(moch$MOCH), 0, 1) # NA's as 0 all other as presence=1
moch$MOCH[1:20]
sum(moch$MOCH)

#locs_mobl 
locs_mobl <-SpatialPoints(locs_mobl)
mobl <- as.data.frame(sp::over(poly, locs_mobl))
colnames(mobl)<- "MOBL"
mobl$MOBL <- as.numeric(mobl$MOBL)
mobl$MOBL <- ifelse(is.na(mobl$MOBL), 0, 1) # NA's as 0 all other as presence=1
mobl$MOBL[1:20]
sum(mobl$MOBL)


#locs_lewo  
locs_lewo <-SpatialPoints(locs_lewo)
lewo <- as.data.frame(sp::over(poly, locs_lewo))
colnames(lewo)<- "LEWO"
lewo$LEWO <- as.numeric(lewo$LEWO)
lewo$LEWO <- ifelse(is.na(lewo$LEWO), 0, 1) # NA's as 0 all other as presence=1
lewo$LEWO[1:20]
sum(lewo$LEWO)


#locs_bbwo  
locs_bbwo <-SpatialPoints(locs_bbwo)
bbwo  <- as.data.frame(sp::over(poly, locs_bbwo))
colnames(bbwo)<- "BBMW"
bbwo$BBMW <- as.numeric(bbwo$BBMW)
bbwo$BBMW<- ifelse(is.na(bbwo$BBMW), 0, 1) # NA's as 0 all other as presence=1
bbwo$BBMW[1:20]
sum(bbwo$BBMW)



############################################
## COmbine the presence/absence and save data
bg$site_id <- c(1:length(bg$species))
bg <- bg[,-1]  # remove sp name column

data_all <- cbind(bg,moch, mobl, lewo, bbwo)


setwd("C:/Users/kvieka/Documents/GitHub/birdDist/data/birdDist")
write.csv(data_all, file="Bird_presence_absence.csv", row.names = F)
