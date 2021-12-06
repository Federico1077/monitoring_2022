# R_code_quantitative_estimates_land_cover.r

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/")

# brick
# 1 list the files available
rlist <- list.files(pattern="defor")

# 2 lapply : apply a function to a list 
list_rast <- lapply(rlist, brick)
list_rast

plot(list_rast[[1]])

# defor : NIR 1, red 2, green 3
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="Lin")

l1992 <- list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

l2006 <- list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# unsupervised classification

l1992c <- unsuperClass(l1992, nClasses=2)
l1992c

plot(l1992c$map)
# value 1 = agricultural areas and water
# value 2 = forest

freq(l1992c$map)
#    value  count
#[1,]    1  36664
#[2,]    2 304628

# agricultural areas and water (class 1) = 36664
# forest (class 2) = 304628

total <- 341292
propagri <- 36664/total
propforest <- 304628/total

# agricultural and water : 0.1074271 = 0.11
# forest : 0.8925729 = 0.89

# build a dataframe
cover <- c("Forest", "Agriculture")
prop1992 <- c(0.8925729, 0.1074271)

proportion1992 <- data.frame(cover, prop1992)

ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")

# classification of 2006
# Unsupervised classification
l2006c <- unsuperClass(l2006, nClasses=2) # unsuperClass(x, nClasses) 
l2006c

plot(l2006c$map)

# frequency ,the same of 1992

total <- 341292
propagri <- 34710/total
propforest <- 306582/total

proportion <- data.frame(cover, prop1992, prop2006)
prop2006 <- c(0.8982982,0.1017018)
proportion2006 <- data.frame(cover, prop2006)
proportion <- data.frame(cover, prop1992, prop2006)
ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

# plotting all togheter
p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")
 
grid.arrange(p1, p2, nrows=1)


