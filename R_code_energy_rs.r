# R code for estimating energy in ecosystems

library(raster)
library(rgdal)

#importing data
brick("defor1_.jpg") # image of 1992

l1992 <- brick("defor1_.jpg")

install.packages("rgdal")

# Bands : defor_.1, defor_.2, defor_.3

#plotRGB
plotRGB(l1992, r=1, g=2, b=3, stretch ="Lin")

# defor_.1 = NIR

plotRGB(l1992, r=1, g=2, b=3, stretch ="Lin") = first band is red
plotRGB(l1992, r=2, g=1, b=3, stretch ="Lin") = first band is blue
plotRGB(l1992, r=1, g=3, b=2, stretch ="Lin") = first band is green


