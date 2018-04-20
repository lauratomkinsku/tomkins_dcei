#' @title treeHeight
#' @description Calculate tree height given distance away from tree and angle of observer
#'
#' @param distance A real number or vector of real numbers
#' @param theta A real number or vector of real numbers
#' @param thetaflag A string identifying units of theta value(s)
#'
#' @return the height of the tree given \code{distance} and \code{theta}
#' @examples
#' treeHeight(100,45,"degrees")
#' treeHeight(c(10,20,40),c(0.785,0.524,0.785), "radians")
#'
treeHeight <- function(distance,theta,thetaflag){
  if (thetaflag=="degrees"){
    thetarad <- theta*(pi/180)
  }
  else if (thetaflag=="radians"){
    thetarad <- theta
  }
  else {
    warning("Invalid thetaflag")
    thetarad <-  NA
  }
  height = distance*tan(thetarad)
  return(height)
}



