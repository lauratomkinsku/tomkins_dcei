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

source('data_download.R')
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

library(httr)
acis.url <- 'http://data.rcc-acis.org/MultiStnData?params=%7B%22state%22%3A%22ks%22%2C%22sdate%22%3A%2219990101%22%2C%22edate%22%3A%2220000201%22%2C%22elems%22%3A%22pcpn%22%2C%22meta%22%3A%22ll%22%7D'
# opportunities for modularity?
test <- httr::GET(url=acis.url) # make request
dat <- httr::content(test, "text","application/json", encoding="UTF-8") # make human readable
json_data <- jsonlite::fromJSON(dat) # convert JSON to R list
ifelse(dir.exists("rds"), "dir all ready exists", dir.create("rds")) # setup directory to write data
newFN <- paste0("rds/",state.abb[i],"_",sdate,".rds")
saveRDS(json_data, file=newFN) # save to prevent having to request again
ff <- sapply(json_data$data$data, cbind) # way to convert list into data matrix
ff[ff=="M"] <- NA # clean up
trace <- runif(1000,0.0001,.0099) 
ff[ff=="T"] <- sample(trace,replace = T,size = 1) # sub real possible numbers
class(ff) <- "numeric" # convert matrix class to numeric
dates <- seq.Date(from=lubridate::ymd(sdate), to=lubridate::ymd(edate), by = "1 days") # dates in software are hard, learn some of the tools  
year <- as.factor(lubridate::year(dates))

ff <- data.frame(date=dates,ff)
names(ff) <- c("date",paste(json_data$data$meta$state[],json_data$data$meta$name[], json_data$data$meta$ll[][], sep="_"))
ff$year <- as.factor(lubridate::year(ff$date))
# summarize by year
fc <- aggregate(by=list(ff$year), x=ff[,2:(ncol(ff)-1)], mean)
names(fc)[1] <- "year"
fc$year <- as.numeric(as.character(fc$year))
annualmean <- cbind(annualmean, fc)
print(state.abb[i])
print(Sys.time())
Sys.sleep(2)

<!-- Delete
```{r 1950precip, fig.cap = 'Figure 6. 1950 Precipitation Data'}
gg <- ggmap(conus) + 
  geom_point(data=cleanprecip, aes(x=lon,y=lat,color=`1950`),size=1,na.rm=TRUE)+
  labs(title = '1950 Precipitation Data', x = 'Longitude', y = 'Latitude') + 
  scale_color_gradientn(colors=rev(rainbow(7)), limits=c(20,65), na.value='white') 
gg
```

```{r 2008precip, fig.cap = 'Figure 7. 2008 Precipitation Data'}
gg <- ggmap(conus) + 
  geom_point(data=cleanprecip, aes(x=lon,y=lat,color=`2008`),size=1,na.rm=TRUE)+
  labs(title = '2008 Precipitation Data', x = 'Longitude', y = 'Latitude') + 
  scale_color_gradientn(colors=rev(rainbow(7)), limits=c(20,65), na.value='white') 
gg
```


```{r avgp_calc}
# Compare average of first and second half

mididxp = round((NCOL(cleanprecip)-3)/2)
firsthalfp = cleanprecip[,3:(mididxp+3)]
secondhalfp = cleanprecip[,(mididxp+3):NCOL(cleanprecip)]
#first3p = cleanprecip[,4:6]
#last3p = cleanprecip[,(NCOL(cleanprecip)-2):NCOL(cleanprecip)]

avg1p = rowMeans(firsthalfp, na.rm=TRUE)
avg2p = rowMeans(secondhalfp, na.rm=TRUE)
#af = rowMeans(first3p, na.rm=TRUE)
#al = rowMeans(last3p, na.rm=TRUE)

avgdatp <- cbind(cleanprecip,avg1p,avg2p,(avg2p-avg1p))#,af,al,(al-af))
```

```{r avgdiffprecip, fig.cap = 'Figure 8. Difference between first and second half average of precipitation data (second-first)'}
gg <- ggmap(conus) + 
  geom_point(data=avgdatp, aes(x=lon,y=lat,color=`(avg2p - avg1p)`),size=1,na.rm=TRUE)+
  labs(title = 'Second half average - First half average', x = 'Longitude', y = 'Latitude') + 
  scale_color_distiller(palette='BrBG', direction=1, limits=c(-10,10),na.value='white') 
gg
```
-->
  
  <!--I've also compared the average of the first 3 years of data and the last 3 years of data which are shown below in Figure 6. 

```{r avg3, fig.cap = 'Figure 6. Difference between first 3 years and last 3 years of temperature data (last-first)'}
gg <- ggmap(conus) + 
  geom_point(data=avgdat, aes(x=lon,y=lat,color=`(al - af)`),size=1,na.rm=TRUE)+
  labs(title = 'Last 3 years average - First 3 years average', x = 'Longitude', y = 'Latitude') + 
  scale_color_distiller(palette='RdBu', limits=c(-15,15),na.value='white') 
gg
``` 
-->


<!--Not including
```{r avgdiff, fig.cap = 'Figure 5. Difference between first and second half average of temperature data (second-first)'}
gg <- ggmap(conus) + 
geom_point(data=avgdat, aes(x=lon,y=lat,color=`(avg2 - avg1)`),size=1,na.rm=TRUE)+
labs(title = 'Second half average - First half average', x = 'Longitude', y = 'Latitude') + 
scale_color_distiller(palette='RdBu', limits=c(-15,15),na.value='white') 
gg
``` 
-->

<!-- Not including
```{r avg_calc}
# Compare average of first and second half

mididx = round((NCOL(cleantemp)-3)/2)
firsthalf = cleantemp[,3:(mididx+3)]
secondhalf = cleantemp[,(mididx+3):NCOL(cleantemp)]
first3 = cleantemp[,4:6]
last3 = cleantemp[,(NCOL(cleantemp)-2):NCOL(cleantemp)]

avg1 = rowMeans(firsthalf, na.rm=TRUE)
avg2 = rowMeans(secondhalf, na.rm=TRUE)
af = rowMeans(first3, na.rm=TRUE)
al = rowMeans(last3, na.rm=TRUE)

avgdat <- cbind(cleantemp,avg1,avg2,(avg2-avg1),af,al,(al-af))
```

```{r firstavg, fig.cap = 'Figure 3. Average of first half of Temperature Data'}
gg <- ggmap(conus) + 
geom_point(data=avgdat, aes(x=lon,y=lat,color=`avg1`),size=1,na.rm=TRUE)+
labs(title = 'First half average', x = 'Longitude', y = 'Latitude') + 
scale_color_gradientn(colors=rev(rainbow(7)), limits=c(10,80),na.value='white') 
gg
```

```{r secondavg, fig.cap = 'Figure 4. Average of second half of Temperature Data'}
gg <- ggmap(conus) + 
geom_point(data=avgdat, aes(x=lon,y=lat,color=`avg2`),size=1,na.rm=TRUE)+
labs(title = 'Second half average', x = 'Longitude', y = 'Latitude') + 
scale_color_gradientn(colors=rev(rainbow(7)), limits=c(10,80),na.value='white') 
gg
```
-->

<!-- Not including
```{r 1950temp, fig.cap = 'Figure 1. 1950 Temperature Data'}
# Dependencies: requires inital plotting chunk and clean data
# ! Modularity Lesson # 8: being aware of dependencies and order of chunks
gg <- ggmap(conus) + 
geom_point(data=cleantemp, aes(x=lon,y=lat,color=`1950`),size=1,na.rm=TRUE)+
labs(title = '1950 Temperature Data', x = 'Longitude', y = 'Latitude') + 
scale_color_gradientn(colors=rev(rainbow(7)), limits=c(10,80), na.value='white') 
gg
```

```{r 2008temp, fig.cap = 'figure 2. 2008 Temperature Data'}
gg <- ggmap(conus) + 
geom_point(data=cleantemp, aes(x=lon,y=lat,color=`2008`),size=1,na.rm=TRUE)+
labs(title = '2008 Temperature Data', x = 'Longitude', y = 'Latitude') + 
scale_color_gradientn(colors=rev(rainbow(7)), limits=c(10,80), na.value='white') 
gg
```
-->
