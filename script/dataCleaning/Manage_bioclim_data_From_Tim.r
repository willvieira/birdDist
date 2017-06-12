if(file.exists("climate.Rdata")) {
    load("climate.Rdata")
} else {
    xl <- range(coordinates$longitude) + c(-3, 3)
    yl <- range(coordinates$latitude) + c(-3, 3)
    if(file.exists("bioclim.grd")){
        cat("\n")
    } else {
        bioclim <- crop(
          getData("worldclim", var="bio", res=5),
          c(min(xl), max(xl), min(yl), max(yl))
        )
        writeRaster(bioclim, filename="bioclim.grd", overwrite=T)
    }
    bclim <- brick("bioclim.grd")
    climate <- extract(bclim, coordinates[,c('longitude', 'latitude')])
    row.names(climate) = coordinates$name
    maps_climate <- bclim
    save(climate, maps_climate, file="climate.Rdata")
}