############################################################################################
##
## coding the pseudoabsences
## from tutorial http://www.molecularecologist.com/2013/04/species-distribution-models-in-r/
############################################################################################
require(rgeos)
require(maptools)
require(maps)
require(mapdata)
require(dismo)

#import the bird and environmental data
data_swd <-read.table("C:\\Users\\anarahlin\\Desktop\\Data_SWD.csv", header = TRUE, sep = ",")

howr2<-subset(data_swd, species == "House_Wren")
head(howr2)
howr2$species <-NULL
head(howr2)

locs = howr2
data(stateMapEnv)

plot(c(-114, -124.8),c(32.47,42.0),mar = par("mar"), xlab = "longitude", ylab = "latitude", xaxt="n", yaxt = "n", type = "n", main = "House Wren presence data CA")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4], col="lightblue")
map("state", xlim=c(-119, -113), ylim=c(33.5, 38), fill=T, col="cornsilk", add=T)

points(locs$longitude, locs$latitude, col="brown", pch=20, cex=0.5)
axis(1,las=1)
axis(2,las=1)
box()


moch2<-subset(data_swd, species == "Mountain_Chickadee")
head(moch2)
moch2$species <-NULL
head(moch2)

locs_moch = moch2
data(stateMapEnv)

plot(c(-114, -124.8),c(32.47,42.0),mar = par("mar"), xlab = "longitude", ylab = "latitude", xaxt="n", yaxt = "n", type = "n", main = "Mountain Chickadee presence data CA")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4], col="lightblue")
map("state", xlim=c(-119, -113), ylim=c(33.5, 38), fill=T, col="cornsilk", add=T)

points(locs_moch$longitude, locs_moch$latitude, col="purple", pch=20, cex=0.5)
axis(1,las=1)
axis(2,las=1)
box()

mobl2<-subset(data_swd, species == "Mountain_Bluebird")
head(mobl2)
mobl2$species <-NULL
head(mobl2)

locs_mobl = mobl2
data(stateMapEnv)

plot(c(-114, -124.8),c(32.47,42.0),mar = par("mar"), xlab = "longitude", ylab = "latitude", xaxt="n", yaxt = "n", type = "n", main = "Mountain Bluebird presence data CA")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4], col="lightblue")
map("state", xlim=c(-119, -113), ylim=c(33.5, 38), fill=T, col="cornsilk", add=T)

points(locs_mobl$longitude, locs_mobl$latitude, col="blue", pch=20, cex=0.5)
axis(1,las=1)
axis(2,las=1)
box()

lewo2<-subset(data_swd, species == "Lewis_Woodpecker")
head(lewo2)
lewo2$species <-NULL
head(lewo2)

locs_lewo = lewo2
data(stateMapEnv)

plot(c(-114, -124.8),c(32.47,42.0),mar = par("mar"), xlab = "longitude", ylab = "latitude", xaxt="n", yaxt = "n", type = "n", main = "Lewis's Woodpecker presence data CA")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4], col="lightblue")
map("state", xlim=c(-119, -113), ylim=c(33.5, 38), fill=T, col="cornsilk", add=T)

points(locs_lewo$longitude, locs_lewo$latitude, col="green4", pch=20, cex=0.5)
axis(1,las=1)
axis(2,las=1)
box()

bbwo2<-subset(data_swd, species == "Black_backed_Woodpecker")
head(bbwo2)
bbwo2$species <-NULL
head(bbwo2)

locs_bbwo = bbwo2
data(stateMapEnv)

plot(c(-114, -124.8),c(32.47,42.0),mar = par("mar"), xlab = "longitude", ylab = "latitude", xaxt="n", yaxt = "n", type = "n", main = "Black-backed Woodpecker presence data CA")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4], col="lightblue")
map("state", xlim=c(-119, -113), ylim=c(33.5, 38), fill=T, col="cornsilk", add=T)

points(locs_bbwo$longitude, locs_bbwo$latitude, col="red", pch=20, cex=0.5)
axis(1,las=1)
axis(2,las=1)
box()


#################################################################################
# turn CA into a grid for pseudoabsences
#
#################################################################################

#creates pseudoabsences for the house wren, using "locs". Other species have locs_moch, locs_mobl etc
#create sequences of latitude and longitude values to define grid
longrid = seq(-124.8, 114, 0.05) #0.05 deg lon X 0.05 deg lat = less than 5km^2
latgrid = seq(32.47,42, 0.05)

#identify points within each grid cell, draw one at random
subs = c()
for(i in 1:(length(longrid)-1)){
  for(j in 1:(length(latgrid)-1)){
    gridsq = subset(locs, latitude > latgrid[j] & latitude < latgrid[j+1] & longitude > longrid[i] & longitude < longrid[i+1])
    if(dim(gridsq)[1]>0){
      subs = rbind(subs, gridsq[sample(1:dim(gridsq)[1],1 ), ])
    }
  }
}
dim(subs) # confirm that you have a smaller dataset than you started with

#yes, we have a smaller housewren file than before.
head(subs)

#use subs to regraph the housewren code. subs instead of locs.
data(stateMapEnv)

plot(c(-114, -124.8),c(32.47,42.0),mar = par("mar"), xlab = "longitude", ylab = "latitude", xaxt="n", yaxt = "n", type = "n", main = "House Wren presence absence data CA")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4], col="lightblue")
map("state", xlim=c(-119, -113), ylim=c(33.5, 38), fill=T, col="cornsilk", add=T)

points(subs$longitude, subs$latitude, col="brown", pch=20, cex=0.5)
points(x, pch = 16)
points(bg, col= "green", pch = 16, cex = 0.01)
axis(1,las=1)
axis(2,las=1)
box()

# define circles with a radius of 1000m around the subsampled points
x = circles(subs[,c("longitude","latitude")], d=1000, lonlat=T)
# draw random points that must fall within the circles in object x
bg = spsample(x@polygons, 1000, type='random', iter=1000)

head(bg)
head(x) #this is a polygon, extract points for each species if they're within the polygon.












