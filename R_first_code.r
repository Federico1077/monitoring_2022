#  This is my first code in github!  quite exiciting, right ?

# Here are the input data
# Costanza data on streams
Water  <- c(100,200,300,400,500)
Water

# Marta data on fishes genomes
Fishes <- c(10,50,60,100,200)
Fishes

# plot the diversity of fishes (y) versus the amount of water (x)
#  a function is used with arguments inside!
plot(water, fishes)

# the data we developed can be stored in a table
# a table in R is called data frame

streams <- data.frame(water, fishes)

# From now on, we are going to import and/or exsport data!

# setwd for Windows
setwd("C:/lab/")

# Let's export our table!
write.table(streams, file="my_first_table.txt")

# Some colleagues did send us a table How to import it in R ?
read.table("my_first_table.txt")
#let's assingn it to an object uninside R
ducciotable <- read.table("my_first_table.txt")

# the first statistics for lazy beautiful people
summary(ducciotable)

# Marta does not like water
# Marta wants to get info only on fishes
summary(ducciotable$fishes)

# histogram
hist(ducciotable$fishes)
hist(ducciotable$water)
