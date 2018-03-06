data_cleaner <- function(dat, nrecords){
  cleandat <- na.omit(dat) # get rid of NaN data
  remove(dat) # remove large dataset with NaN data
  
}