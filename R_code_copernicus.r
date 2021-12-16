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




