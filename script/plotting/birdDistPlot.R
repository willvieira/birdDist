#Birds distribuition plot

#source
  #Add transparent color
source("script/plot/addTransColor.R")
source("script/plot/myScatterPlot.R")

#data
  #Bird distribuition
bd <- read.csv("data/birdDist/allbird_unique.csv")
names(bd) <- c("names", "lat", "lon")

  #plot in a "pretty" way
myplot(bd$lon,
     bd$lat,
     pointCex = .5,
     pch = 16,
     col = addTrans(ifelse(bd$name == "Mountain_Bluebird", "blue",
        ifelse(bd$name == "House_Wren","Brown",
        ifelse(bd$name == "Lewis_Woodpecker","#0f9200",
        ifelse(bd$name == "Black_backed_Woodpecker","yellow", "gray"
)))), 80),
   xlab = "",
   ylab = "",
)

#plot in a basic way
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
