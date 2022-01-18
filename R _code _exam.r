# R code for uploading and visualizing Copernicus data in R
# Datas are relatively to Criosphere and to be more precise they concern about the snow (snow and snow water equivalent) in the nothern emisphere. I use two satellite images from Copernicus to see the difference between the snow cover extent in march 2020 amd september 2020
# I use only the name snow for the files to semplify, but for snow I mean "snow and snow water equivalent". I make this distinction because in the season of the two images there are snow and also the water equivalent to the melt of snow 
# All the library with the packages that we need

library(raster) # for upload the file from the labo folder to R
library(ncdf4) # for open and read satellite images in R
library(ggplot2) # for plotting file and data
library(viridis) # for using viridis palette for the plot
library(RStoolbox) # for the analisy,elaboration of the data and graphical visualization 
library(patchwork) # for rappresenting two o more plot together

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

# use the patchwork package to plot the two images together
p1 <- ggplot() + geom_raster(sendwinter, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.1)) + scale_fill_viridis(option="viridis") + ggtitle("snow on 21 march 2020")
p2 <- ggplot() + geom_raster(sendsummer, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.2)) + scale_fill_viridis(option="viridis") + ggtitle("snow on 21 september 2020")

# plot p1 over p2
p1 / p2

# Represent the difference of snow between the condition on 21 march 2020 and 21 september 2020
snowdif <- sendwinter - sendsummer
cl <- colorRampPalette(c("blue","white","red"))(100)
plot(snowdif, col=cl)

# plot the two images in one with plotRGB to see the wich area are is associated to 21 march 2020 and wich on 21 september 2020
snowstack # to see the name of the two files
plotRGB(snowstack, r=1,g=1,b=2, stretch="lin") # 1= associated to the image of 21 march and 2 associated to the image of 21 september

# Calculate the relationship between the ares covered by snow ( snow and snow water equivalent) and and those that are not covered
# Unsupervised classification with the use of unsuperClass function to explain to the software wich are the pixels covered by snow abd wich not in the 2 images
# do this for the image of 21 march 2020 (sendwinter)

sendwinterc <- unsuperClass(sendwinter, nClasses=2)# we have two classes one is that relative to the snow cover and the other relative to that is not
sendwinterc # to see the information 
plot(sendwinterc$map)
freq(sendwinterc$map)# to see the frequency of the two classes
# snowcover : 5835798, nosnowcover : 1364202
s1 <- 5835798 + 1364202
s1 # find the total value of pixels (7200000)

# find the proportion of the two classes
prop1 <- freq(sendwinterc$map) / s1
total <- 7200000 # s1
propsnow <- 5835798 / total
propnosnow <- 1364202 / total
propsnow = 0.8105275 # about 0.81 (81%)
propnosnow = 0.1894725 # about 0.19 (19%)

# Build a dataframe
cover <- c("snow","nosnow")
propsendwinter <- c(0.8105275,0.1894725)
proportionsendwinter <- data.frame(cover,propsendwinter)
ggplot(proportionsendwinter, aes ( x = cover, y= propsendwinter, color= cover)) + geom_bar( stat ="identity",fill ="white")

# do the same for the image of 21 september 2020 (sendsummer)

sendsummerc <- unsuperClass(sendsummer, nClasses=2)# we have two classes one is that relative to the snow cover and the other relative to that is not
sendsummerc # to see the information 
plot(sendsummerc$map)
freq(sendsummerc$map)# to see the frequency of the two classes
# snow cover : 82720 , nosnowcover : 7117280

s2 <- 82720 + 7117280
s2 # 7200000

prop2 <- freq(sendsummerc$map) / s2
total <- 7200000 # s2
propsnow2 <- 82720 / total
propnosnow2 <- 7117280 / total
propsnow2 = 0.01148889 # about 0.01 (1%)
propnosnow2 = 0.9885111 # about 0.19 (99%)

# Build a dataframe
cover <- c("snow2","nosnow2")
propsendsummer <- c(0.01148889,0.9885111)
proportionsendsummer <- data.frame(cover,propsendsummer)
ggplot(proportionsendsummer, aes ( x = cover, y= propsendsummer, color= cover)) + geom_bar( stat ="identity",fill ="white")

# build a dataframe fot having a proportion between the data of the two images
cover <- c("snow","nosnow")
propsendwinter <- c(propsnow,propnosnow)
propsendsummer <- c(propsnow2,propnosnow2)

proportion <- data.frame(cover,propsendwinter,propsendsummer)
proportion # to see the proportion of two images together

# plot the proportion
ggplot(proportion, aes(x=cover, y=propsendwinter, color=cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1)

ggplot(proportion, aes(x=cover, y=propsendsummer, color=cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1)

# plotting all the two histograms together with patchwork package

p1 <- ggplot(proportion, aes(x=cover, y=propsendwinter, color=cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1)
p2 <- ggplot(proportion, aes(x=cover, y=propsendsummer, color=cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1)

# plotting p1 over p2
p1 / p2

# calculate the difference of snow between the two images : 0.8105275 - 0.01148889
dif <- 0.8105275 - 0.01148889
dif # 0.7990386 = about 80% of snow loss
# Do the dispersion graph with the correlation between the data of 21 march 2020 and those of 21 september 2020
# use abline function for this

plot(sendwinter,sendsummer)
abline(0,1, col= "red") # we see no correlation beetween the data because the rappresent quite opposite situation

# use the pairs function to have dispersion graph and histograms all together

pairs(snowstack)

# I can crop an image of a certain area. I choose the north Europe area (Norway,Sweden) that is an area in wich there is a big change in snow from 21 march 2020 to 21 september

# longitude is from 0 to 50
# latitude is from 55 to 75

ext <- c(0,50,55,75)

# use crop function 
sendwinter_cropped <- crop(sendwinter, ext)
sendsummer_cropped <- crop(sendsummer, ext)

# plot the area in the two different periods together 

p1 <- ggplot() + geom_raster(sendwinter_cropped, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.1)) + scale_fill_viridis(option="viridis") + ggtitle("snow cover on 21 march 2020")
p2 <- ggplot() + geom_raster(sendsummer_cropped, mapping= aes(x=x, y=y, fill=Snow.Water.Equivalent.2)) + scale_fill_viridis(option="viridis") + ggtitle("snow cover on 21 september 2020")

p1 / p2






































