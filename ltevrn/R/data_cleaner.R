# Title: data_cleaner
# Author: Laura Tomkins
# Date: March 2018
# Purpose: inputs data and outputs cleaner version of data (for EVRN 720)
# Inputs:   dat: raw data provided by user
#           nreocrds: threshold for removing locations with not enough data
#           provided: flag used to determine method for cleaning
# outputs:  cleandata: data which is now in a matrix format with dimensions nstations x nyears
# Example:  data_cleaner(precip, 40, TRUE)

data_cleaner <- function(dat, nrecords,provided){
  
  if (provided == TRUE){
    # Check if there's any janky data locations
    datbyyear <- aggregate(dat$year, by <- list(dat$name,dat$lon,dat$lat), FUN=length)
    years <- unique(dat$year)
    badstations <- datbyyear$Group.1[datbyyear$x!=length(years)]
    dat <- subset(dat, !(dat$name %in% badstations))
    
    # Get unique data
    uniquedat <- unique(dat[c('name','lat','lon')])
    stationnames <- uniquedat$name
    latlist <- uniquedat$lat
    lonlist <- uniquedat$lon
    
    # Put data into matrix
    cleandata <- matrix(data=dat$data,nrow=length(stationnames),ncol=length(years),byrow=TRUE)
  } else {
    # Check if there's any janky data locations
    datbyyear <- aggregate(dat$year, by <- list(dat$variable), FUN=length)
    years <- unique(dat$year)
    badstations <- datbyyear$Group.1[datbyyear$x!=length(years)]
    dat <- subset(dat, !(dat$variable %in% badstations))
    
    # Get unique data
    uniquedat <- unique(dat[c('name','lat','lon')])
    stationnames <- uniquedat$name
    latlist <- uniquedat$lat
    lonlist <- uniquedat$lon
    
    # Put data into matrix
    cleandata <- matrix(data=dat$value,nrow=length(stationnames),ncol=length(years),byrow=TRUE)
  }
  
  rownames(cleandata) <- stationnames
  colnames(cleandata) <- years
  
  # Combine lat and lon in matrix
  binddata <- cbind(uniquedat,cleandata)
  
  # Delete locations with lots of missing data
  delete.na <- function(DF, a=0) {
    DF[rowSums(is.na(DF)) <= a,]
  }
  newdata <- delete.na(binddata, nrecords)
  
  # Return data
  return(newdata)
}