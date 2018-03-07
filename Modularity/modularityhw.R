# Modularity Homework
source('data_cleaner.R')

# Data Chunk
provided <- TRUE
nrecods <- 40

if (provided==TRUE){
  precip <- readRDS("USAAnnualPcpn1950_2008.rds")
  temp <- readRDS("USAAnnualTemp1950_2008.rds")
  startYear <- 1950
  endYear <- 2008
}

cleandat <- data_cleaner(precip,nrecords,startYear,endYear)


