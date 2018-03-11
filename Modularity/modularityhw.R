# Modularity Homework

# Data Chunk
provided <- TRUE
nrecords <- 40

if (provided==TRUE){
  precip <- readRDS("USAAnnualPcpn1950_2008.rds")
  temp <- readRDS("USAAnnualTemp1950_2008.rds")
} else {
  # Insert code for getting data online
}

# Cleaning chunk
source('data_cleaner.R')

cleanprecip <- data_cleaner(precip,nrecords)
cleantemp <- data_cleaner(temp,nrecords,provided)

remove(temp)
remove(precip)

source('data_plotter.R')
data_plotter(dat=cleantemp, year=2008, colors=c('yellow','orange','red'), title='2008 Temperature')

# Plotting Chunk
library(ggplot2)
library(ggthemes)
library(ggmap)

conus <- get_stamenmap(c(left=-125, bottom=25.75, right=-67, top=49), zoom = 5, maptype = 'toner-lite')

gg <- ggmap(conus) + 
  geom_point(data=cleantemp, aes(x=lon,y=lat,color=`2008`),size=3,na.rm=TRUE)+
  labs(title = '1950 Precipitation Data', x = 'Longitude', y = 'Latitude') + 
  scale_color_gradientn(colors=rev(rainbow(7)), na.value='white') 
gg

# Compare average of first and second half

mididx = round((NCOL(cleantemp)-3)/2)
firsthalf = cleantemp[,3:(mididx+3)]
secondhalf = cleantemp[,(mididx+3):NCOL(cleantemp)]

avg1 = rowMeans(firsthalf, na.rm=TRUE)
avg2 = rowMeans(secondhalf, na.rm=TRUE)

avgdat <- cbind(cleantemp,avg1,avg2,(avg2-avg1))

gg <- ggmap(conus) + 
  geom_point(data=avgdat, aes(x=lon,y=lat,color=`avg1`),size=1,na.rm=TRUE)+
  labs(title = 'First half average', x = 'Longitude', y = 'Latitude') + 
  scale_color_gradientn(colors=rev(rainbow(7)), limits=c(20,60),na.value='white') 
gg

