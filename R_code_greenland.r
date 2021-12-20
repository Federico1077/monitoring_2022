# Ice melt in Greenland
# Proxy : LST

library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

# Set the working directory
setwd("C:/lab/greenland/")

#list f files
rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist,raster)
import

TGr <- stack(import)
TGr

cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(TGr, col=cl)

plot(TGr, col=cl)

# ggplot of the first and final images 2000 vs. 2015

ggplot() +
geom_raster(TGr$lst_2000,mapping = aes(x=x,y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") + 
ggtitle("LST in 2000")

ggplot() +
geom_raster(TGr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")

p1 <- ggplot() +
geom_raster(TGr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2000")
 
p2 <- ggplot() +
geom_raster(TGr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")
 
p1 + p2

# plotting frequency distributions of data
par(mfrow=c(1,2))
hist(TGr$lst_2000)
hist(TGr$lst_2015)

par(mfrow=c(2,2))
hist(TGr$lst_2000)
hist(TGr$lst_2005)
hist(TGr$lst_2010)
hist(TGr$lst_2015)

# dev.off()
plot(TGr$lst_2010, TGr$lst_2015)
abline(0,1,col="red")

plot(TGr$lst_2010, TGr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")

# make a plot with all the histograms and all the regression for all the values
par(mfrow=c(4,4))
hist(TGr$lst_2000)
hist(TGr$lst_2005)
hist(TGr$lst_2010)
hist(TGr$lst_2015)
plot(TGr$lst_2010, TGr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
plot(TGr$lst_2010, TGr$lst_2000, xlim=c(12500,15000), ylim=c(12500,15000))

pairs(TGr)






