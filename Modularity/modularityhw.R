# Modularity Homework

# Data Chunk
provided <- TRUE
nrecods <- 40
vars <- c('temp', 'precip')

if (provided==TRUE){
  precip <- readRDS("USAAnnualPcpn1950_2008.rds")
  temp <- readRDS("USAAnnualTemp1950_2008.rds")
  minyear <- 1950
  maxyear <- 2008
}

test <- aggregate(temp$year, by <- list(temp$name), FUN=length)

ex <- aggregate(precip$name, by <- list(precip$year='1950'), FUN=max)

# Plotting

maxidx <- vector()
minidx <- vector()
for (i in length(vars)){
  maxidx[i] = vars[i]$year==minyear
  minidx[i] = vars[i]$year==maxyear
}

