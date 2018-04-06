# -*- coding: utf-8 -*-
"""
Created on Fri Apr  6 14:23:25 2018

@author: Laura

Title:    get_variable.py
Author:   Laura Tomkins
Date:     March 2018
Course:   EVRN 720 Final Project
Purpose: This function will be used to isolate variables from data file 
         obtained in ei_download script. The file path and name of variable 
         are input and the data array is output. This function utilizes the
         netCDF4 package.
 
Syntax: var_out = get_variable(file_path, varname)
 
Inputs:
  filepath - full fillpath for data file obtained form ei_download.py
  varname - desired variable to isolate [string]
            *NOTE* : this variable name must be defined in file
   
Outputs:
  varout - data array of variable 
   
Example:
  varout = get_variable('C:\\Users\\Laura\\Documents\\EVRN720\\tomkins_dcei\\
                          UnitTesting\\interim_2016-05-25to2016-05-27.nc', 'u')
   
Other python files required: none
Packages required: netCDF4
Subfunction: none
 
Author: Laura Tomkins, M.S. Student, University of Kansas
email address: lauratomkins@ku.edu
March 2018; Last revision: April 2018
       
"""

import netCDF4 as nc

def get_variable(filepath, varname):
    
    ncfile = nc.Dataset(filepath, 'r', format='NETCDF4')
    varout = ncfile.variables[varname][:]
    ncfile.close()
    
    return varout