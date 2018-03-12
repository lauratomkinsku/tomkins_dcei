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

cleanprecip <- data_cleaner(precip,nrecords,provided)
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
  geom_point(data=avgdat, aes(x=lon,y=lat,color=`(avg2 - avg1)`),size=1,na.rm=TRUE)+
  labs(title = 'First half average', x = 'Longitude', y = 'Latitude') + 
  scale_color_distiller(palette='RdBu', limits=c(-10,10),na.value='white') 
gg

first3 = cleantemp[,4:6]
last3 = cleantemp[,(NCOL(cleantemp)-2):NCOL(cleantemp)]

avg1 = rowMeans(firsthalf, na.rm=TRUE)
avg2 = rowMeans(secondhalf, na.rm=TRUE)
af = rowMeans(first3, na.rm=TRUE)
al = rowMeans(last3, na.rm=TRUE)

years = as.numeric(colnames(cleantemp)[4:NCOL(cleantemp)])
avgbyyear = colMeans(cleantemp[4:NCOL(cleantemp)], na.rm=TRUE)
plot(years, avgbyyear, main='Average Temperature for U.S.', pch=16, xlab='Years', ylab='Temperature', col='dark blue')
lines(lowess(years,avgbyyear), col="dark red") # lowess line (x,y)
fit <- lm(avgbyyear ~ years)
abline(coef(fit)[1:2], col='blue')
cf <- round(coef(fit), 2) 
eq <- paste0("Temperature = ", cf[1],
             ifelse(sign(cf[2])==1, " + ", " - "), abs(cf[2]), " * Year ")
r2 <- paste0('R-squared = ',round(summary(fit)$r.squared,4))
mtext(eq, 3, line=-2)
mtext(r2, 3, line=-3)
