# Title:    get_data.R
# Author:   Laura tomkins
# Date:     March 2018
# Course:   EVRN 720 Final Project
# Purpose: This function will be used to download reanalysis data from online
# ***more description to be added after function is written***
# 
# Syntax: datafile <- get_data(starttime, endtime, datasource)
# 
# Inputs:
#   starttime - start time of desired data [string]
#   endtime - end time of desired data [string]
#   datasource - identifier of desried source of data [string]
#   
# Outputs:
#   datafile - the downloaded data
#   
#***DAN: would be good to say what format the data comes out in! Users of this function will need that info. Just need to say, e.g.,
#it's a data frame (assuming it is) with columns named A, B, C and a row for each X (fill in A, B, C, X with accurate information).
#Or perhaps it is a file saved to the disk. Then were is it saved? Is it a csv? What are the columns and rows?
#
# Example:
#   datafile <- get_data('201803300000', '201804010000', 'GFS')
#   
# Other R-files required: none
# Subfunction: none
# 
# Author: Laura Tomkins, M.S. Student, University of Kansas
# email address: lauratomkins@ku.edu
# March 2018; Last revision: March 2018
#
#***DAN: This is really great function spec. If you do this for all your
#functions, you will rarely be confused or forget what your functions
#were intended for! Very well done! Just a few small quibbles, see comments
#above.
#
get_data <- function(starttime, endtime, datasource){
  
}