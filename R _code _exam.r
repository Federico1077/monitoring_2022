# R code for uploading and visualizing Copernicus data in R
# Datas are relatively to Criosphere and to be more precise they concern about the snow cover extent in the nothern emisphere. I use two satellite images from Copernicus to see the difference between the snow cover extent in march 2020 amd september 2020

# All the library with the packages that we need

library(raster)
library(ncdf4) 
library(ggplot2)
library(viridis)
library(RStoolbox)
library(patchwork)

# Set the working directory
setwd("C:/lab/exam/") # windows

# After the download of the data from Copernicus I put the two files in my lab folder. One is from 
# Upload of the data from the lab folder in R with raster function

snow20200321 <- raster("c_gls_SWE5K_202003210000_NHEMI_SSMIS_V1.0.2.nc")
snow20200321 # to see the information of the file

# use the function plot to see the file
plot(snow20200321)

# use different color for the plot with a different colorRampPalette
cl <- colorRampPalette(c("darkblue","blue","light blue"))(100)
plot(snow20200321, col=cl)

# use ggplot function with viridis package to have more appropriate colors to have a good distinction beetween the different areas with different snow cover
# use geom_raster function with ggplot to do the information of I want to do the plot spacifically,with aesthetics component ecc
# I find what to put in the "fill section" of geom_raster in the information of the file (name section)


ggplot() + geom_raster(snow20200321, mapping = aes(x=x, y=y, fill= Snow.Water.Equivalent)) + scale_fill_viridis(option="viridis") + ggtitle("snow on 21 March 2020")

# importing all the data together with lapply function
# go to the folder to see what is the common pattern between the two images

rlist <- list.files(pattern = "SWE5K")
rlist # to see the complete name of the two files

list_rast <- lapply(rlist,raster)
list_rast # to have the information of the the two files all together

# create a stack with the two files of the "list_rast" created before

snowstack <- stack(list_rast)
snowstack

# I associate a name for each one of the the two files of the stack

sendwinter <- snowstack$Snow.Water.Equivalent.1
sendsummer <- snowstack$Snow.Water.Equivalent.2

# make plots with ggplot and geom_raster of the two files

ggplot() + geom_raster(sendwinter, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.1)) + scale_fill_viridis(option="viridis") + ggtitle("snow cover on 21 march 2020")

ggplot() + geom_raster(sendsummer, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.2)) + scale_fill_viridis(option="viridis") + ggtitle("snow cover on 21 september 2020")

# use the patchwork function to plot the two images together
p1 <- ggplot() + geom_raster(sendwinter, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.1)) + scale_fill_viridis(option="viridis") + ggtitle("snow cover on 21 march 2020")
p2 <- ggplot() + geom_raster(sendsummer, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.2)) + scale_fill_viridis(option="viridis") + ggtitle("snow cover on 21 september 2020")

# plot p1 over p2
p1 / p2

# Calculate the difference of energy(snow) between the condition on 21 march 2020 and 21 september 2020
snowdif <- sendwinter - sendsummer
cl <- colorRampPalette(c("blue","white","red"))(100)
plot(snowdif, col=cl)

#


















