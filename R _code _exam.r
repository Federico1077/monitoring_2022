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

# Calculate the relationship between the ares covered by snow and and those that are not covered
# Use the unsuperClass function to explain to the software wich are the pixels covered by snow abd wich not in the 2 images
# do this for the image of 21 march 2020

snow20200321c <- unsuperClass(snow20200321, nClasses=2)# we have two classes one is that relative to the snow cover and the other relative to that is not
snow20200321c # to see the information 
plot(snow20200321$map)
freq(snow20200321c$map)# to see the frequency of the two classes
# snowcover : 5841542, nosnowcover : 1358458
S1 <- snowcover + nosnowcover

# find the proportion of the two classes
prop1 <- freq(snow20200321c$map) / s1
total <- 7200000 # s1
propsnow <- 5841542 / total
propnosnow <- 1358458 / total
propsnow = 0.8113253 # about 0.80 (80%)
propnosnow = 0.1886747 # about 0.20 (20%)

# Build a dataframe
cover <- c("snow","nosnow")
propsnow20200321 <- (0.8113253,0.1886747)
proportionsnow20200321 <- data.frame(cover,propsnow20200321)
ggplot(proportionsnow20200321, aes ( x = cover, y= propsnow20200321, color= cover)) + geom_bar( stat ="identity",fill ="white")

# do the same for the image of 21 september 2020





























