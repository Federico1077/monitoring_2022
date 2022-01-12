# R code for species distribution modelling, namely the distribution of individuals

# install.packages("sdm")
# install.packages(c("sdm","rgdal") for install more than one package

library(sdm)
library(raster) # predictors
library(rgdal) # species

#species data

system.file("external/species.shp")

file <- system.file("external/species.shp", package="sdm")
file

shapefile() # exatcly as the raster function for raster files
species <-  shapefile(file)

# how many occurrences are there ?
presences <- species[species$Occurrence == 1,]
absences <- species [species$Occurrence == 0,]

# plot!
plot(species, pch=19, col=red)
plot(species, pch=19,col="blue")
plot(presences, pch=19, col="blue")
plot(absences, pch=19, col="blue")

#plot presences and absences
plot(presences, pch=19, col="blue")
points(absences, pch=19, col="red")

# let's look at the predictors
path <- system.file("external", package="sdm")

lst<- list.files(path, pattern='asc')

lst <- list.files(path, pattern='asc', full.names=T)
lst

preds <- stack(lst)
preds

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl) 

plot(preds$elevation, col=cl)
points(presences, pch=19)

plot(preds$temperature, col=cl)
points(presences, pch=19)


plot(preds$vegetation, col=cl)
points(presences, pch=19)

plot(preds$precipitation, col=cl)
points(presences, pch=19)

# day 2

install.packages("sdm")

setwd("C:/lab/")

source("R_code_source_sdm.r")

preds
# these are the predictors: elevation,precipitation,temperature and vegetation

# let's explain to the model what are the training and the predictors
datasdm <- sdmData(train=species,predictors=preds)

#model
m1 <- sdm(Occurrence~temperature+elevation+precipitation+vegetation, data=datasdm, methods="glm")

#prediction
p1 <- predict(m1,newdata=preds)
p1

plot(p1,col=cl)

# stack everything together
s1 <- stack(preds, p1)
plot(s1, col=cl)

#change the name of the model
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
plot(s1, col=cl)

names(s1) <- c('Elevation', 'Precipitation', 'Temperature', 'Vegetation', 'Probability')
plot(s1, col=cl)







