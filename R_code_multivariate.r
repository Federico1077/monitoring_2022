# R code for measuring community interactions

# install.package("vegan")
library(vegan)

setwd("C:/lab/")

load("biomes_multivar.RData")

biomes
biomes_types

multivar <- decorana(biomes)
multivar

plot(multivar)

# let's take a look at the grouping of the species. are them in the same biome

plot(multivar)
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3)

plot(multivar)
attach(biomes_types)
ordispider(multivar, type, col=c("black","red","green","blue"), label=T)
