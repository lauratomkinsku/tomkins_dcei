data_cleaner <- function(dat, nrecords){
  
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