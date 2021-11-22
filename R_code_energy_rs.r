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

# day2

l2006 <- brick("defor2_.jpg")

l2006

plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

#defor_.1=NIR
#defor_.2=red
#defor_.3=green


par(mfrow=c(2,1))
pldvidif <- dvi1992 - dvi2006
# plot the results
cld <- colorRampPalette(c('blue','white','red'))(100)
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# let's calcultae energy in 1992
dev.off()
dvi1992 <- l1992$defor_.1-l1992$defor_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plor(dvi1992, col=cl)

# calculte energy in 2006

dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

plot(dvi2006, col=cl)

# differencing two images of energy in two different times

dvidif <- dvi1992 - dvi2006
#plot the results
cld <- colorRampPalette(c("blue","white","red"))(100)
plot(dvidif, col=cld)

#final plot : original images, dvis, final dvi difference

pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()

pdf("dvi.pdf")
par(mfrow=c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() 

pdf()



