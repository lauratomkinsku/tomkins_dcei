data_trend <- function(cleandat, years){
  
  trends <- c()
  
  for (istation in sequence(length(cleandat$name))){
    stationdat <- as.matrix(cleandat[istation,4:NCOL(cleandat)])
    station <- cbind(years,t(stationdat))
    fit <- lm(station[,1] ~ station[,2], na.action=na.omit)
    cf <- round(coef(fit), 2)
    trends <- c(trends,cf[2])
  }
  return(trends)
}