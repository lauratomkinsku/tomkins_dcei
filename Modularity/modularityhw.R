# Modularity Homework

# Data Chunk
provided <- TRUE
nrecords <- 40

if (provided==TRUE){
  precip <- readRDS("USAAnnualPcpn1950_2008.rds")
  temp <- readRDS("USAAnnualTemp1950_2016.rds")
} else {
  # Insert code for getting data online
}

# Cleaning chunk
source('data_cleaner.R')

cleanprecip <- data_cleaner(precip,nrecords)
cleantemp <- data_cleaner(temp,nrecords)

remove(temp)
remove(precip)

# Plotting Chunk
library(ggplot2)
library(ggthemes)
library(ggmap)

conus <- get_stamenmap(c(left=-125, bottom=25.75, right=-67, top=49), zoom = 5, maptype = 'toner-lite')

gg <- ggmap(conus) + 
  geom_point(data=cleanprecip, aes(x=lon,y=lat,color=`2008`),size=1,na.rm=TRUE)+
  labs(title = '1950 Precipitation Data', x = 'Longitude', y = 'Latitude') + 
  scale_color_gradient2(low='white', high='blue', na.value = 'white')
gg


