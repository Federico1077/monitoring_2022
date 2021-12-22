# R code for species distribution modelling, namely the distribution of individuals

# install.packages("sdm")
library(sdm)
library(raster) # predictors
library(rgdal) # species

system.file("external/species.shp")

file <- system.file("external/species.shp", package="sdm")
file

shapefile() # exatcly as the raster function for raster files
species <-  shapefile(file)

plot(species, pch=19, col=red)





