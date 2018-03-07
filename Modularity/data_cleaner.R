data_cleaner <- function(dat, nrecords, startYear, endYear){
  cleandat <- na.omit(dat) # get rid of NaN data
  remove(dat) # remove large dataset with NaN data
  
  tempdat <- aggregate(cleandat$year, by <- list(cleandat$name), FUN=length) # Finds number of records per location
  
  removedat <- subset(tempdat, tempdat$x<=nrecords) # Subsets locations with less than nrecords
  
  # Loops through locations with not enough data and removes them from data frame
  for (i in sequence(length(removedat$Group.1))){
    cleandat = cleandat[cleandat$name!=removedat$Group.1[i],]
  }
  
  stationnames <- unique(cleandat$name)
  years <- startYear:endYear
  
  cleandat.matrix <- matrix(nrow=length(years),ncol=length(stationnames))
  
  for (j in sequence(length(stationnames))){
    intj <- subset(cleandat, cleandat$name==stationnames[j])
    for (k in sequence(length(years))){
      tryCatch(intk <- subset(intj, intj$year==years[k]))
      if (length(intk$data)>0){
        cleandat.matrix[k,j] <- intk$data
      } else {
        cleandat.matrix[k,j] <- NA
      }
    }
  }
  
  
  return(cleandat)
}