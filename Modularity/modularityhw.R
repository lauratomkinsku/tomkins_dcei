# Modularity Homework
source('data_cleaner.R')

# Data Chunk
provided <- TRUE
nrecords <- 40

if (provided==TRUE){
  precip <- readRDS("USAAnnualPcpn1950_2008.rds")
  temp <- readRDS("USAAnnualTemp1950_2008.rds")
}

cleanprecip <- data_cleaner(precip,nrecords)
cleantemp <- data_cleaner(temp,nrecords)

remove(temp)
remove(precip)

# Plotting Chunk