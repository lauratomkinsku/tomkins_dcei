#' @title tempConvert
#' @description Convert temperature between Celcius and Fahrenheit
#'
#' @param tempIn A real number or vector of real numbers
#' @param inputflag A string identifying units of input value(s)
#'
#' @return the conversion of \code{tempIn} as a real number or vector of real numbers
#' @examples
#' tempConvert(65,"fahrenheit")
#' tempConvert(c(10,20,40), "celcius")
#'
tempConvert <- function(tempIn,inputflag){
  if (inputflag=="fahrenheit"){
    tempOut = (tempIn-32)*(5/9)
  }
  else if (inputflag=="celcius"){
    tempOut = (tempIn*(9/5))+32
  }
  else {
    warning("Invalid inputflag")
    tempOut = NA
  }

  return(tempOut)
}


