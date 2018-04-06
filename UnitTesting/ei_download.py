#!/usr/bin/env python
#
# (C) Copyright 2012-2013 ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0. 
# In applying this licence, ECMWF does not waive the privileges and immunities 
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.
#
'''
Title:    ei_download.py
Author:   Laura Tomkins
Date:     March 2018
Course:   EVRN 720 Final Project
Purpose: This function is used to download reanalysis data from ECMWF

Syntax: ei_download

Inputs: (not inputs but must be defined before execution)
  starttime - start time of desired data [string]
  endtime - end time of desired data [string]
  data_path - identifier of desried source of data [string]
  
Outputs:
  datafile - the downloaded data
  
Other python files required: none
Packages required: os, ECMWF API package
Subfunction: none

Author: Laura Tomkins, M.S. Student, University of Kansas
email address: lauratomkins@ku.edu
March 2018; Last revision: April 2018
    
'''


import os

os.chdir("C:\\Users\\Laura\\Documents\\EVRN720\\tomkins_dcei\\UnitTesting\\")

from ecmwfapi import ECMWFDataServer

# To run this example, you need an API key 
# available from https://api.ecmwf.int/v1/key/

os.environ["ECMWF_API_KEY"] = "0e5be776bd66785f7b5fce1e50a7cffe"
os.environ["ECMWF_API_URL"] = "https://api.ecmwf.int/v1"
os.environ["ECMWF_API_EMAIL"] = "lauratomkins@ku.edu"

server = ECMWFDataServer()
server.retrieve({
    'class'   : 'ei',
    'dataset' : 'interim',
    'step'    : '12',
    'number'  : 'all', # all ensemble members
    'levtype' : 'pl', # or 'sfc'
    'levelist': '300/500/700/600/800/850/900/950/1000',
    'date'    : date_str,
    'time'    : '00/12',
    'type'    : 'an',
    'param'   : '129/130/131/132/135/157/246/248',
    'area'    : '10/-35/-46/25', # area for region
    'grid'    : '0.75/0.75',
    'format'  : 'netcdf',
    'target'  : data_path
})

