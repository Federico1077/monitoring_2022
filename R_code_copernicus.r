# R code for uploading and visualizing Copernicus data

# install.packages("ncdf4")
# setwd("C:/lab/copernicus")
# library(raster)
# library(RStoolbox)
# library(ggplot2)
# library(viridis)


snow20211214 <- raster("ls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214

# to see all the layers use brick function


cl <- colorRampPalette(c('yellow','orange','red'))(100)
plot(snow20211214, col=cl)

cl <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(snow20211214, col=cl)

#########

# ggplot function
ggplot() +
geom.raster(snow20211214, mapping = aes(x=X, y=y. fill=Snow.Cover.Extent))


# ggplot function with viridis
ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis()


ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis")
+
ggtitle("cividis palette")

##############################################

rlist <- list.files(pattern="SCE")
rlist

list_rast <- lapply(rlist, raster)
list_rast

snowstack <- stack(list_rast)
snowstack

ssummer <- snowstack$Snow.Cover.Extent.1
swinter <- snowstack$Snow.Cover.Extent.2

p1 <- ggplot() +
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="magma") +
ggtitle ("snow cover in summer")

p2 <- ggplot() +
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle ("snow cover during freezing winter")

# let's patchwork them togheter

p1/p2

# you can crop your image on a certain area

# longitude from 0 to 20
# latitude from 30 to 50

# crop the stack to the extent of Sicily
ext <- c(0, 20, 30, 50)
ssummer_cropped <- crop(ssummer, ext)
swinter_cropped <- crop(swinter, ext)

p1 <- ggplot() +
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="magma") +
ggtitle ("snow cover in summer")

p2 <- ggplot() +
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle ("snow cover during freezing winter")

p1/p2
