# -*- coding: utf-8 -*-
"""
Created on Sun Apr 08 14:38:42 2018

@author: Laura
"""

import numpy as np
from netCDF4 import Dataset, num2date
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

ncfilename = "interim_2016-05-25to2016-05-27.nc"
ncfile = Dataset(ncfilename, 'r', format='NETCDF4') 
#float32 longitude(longitude), float32 latitude(latitude), int32 level(level), 
#int32 time(time), int16 z(time,level,latitude,longitude), int16 
#t(time,level,latitude,longitude), int16 w(time,level,latitude,longitude), int16 
#r(time,level,latitude,longitude), int16 clwc(time,level,latitude,longitude), 
#int16 cc(time,level,latitude,longitude), int16 u(time,level,latitude,longitude), 
#int16 v(time,level,latitude,longitude)

lat = ncfile.variables['latitude'][:]
lon = ncfile.variables['longitude'][:]
levels = ncfile.variables['level'][:]
time = ncfile.variables['time']
dates = num2date(time[:],time.units,time.calendar)

z = ncfile.variables['z'][:] # geopotential
t = ncfile.variables['t'][:] # temperature
w = ncfile.variables['w'][:] # omega
r = ncfile.variables['r'][:] # relative humidity
clwc = ncfile.variables['clwc'][:] # cloud lwc
cc = ncfile.variables['cc'][:] # cloud cover
u = ncfile.variables['u'][:] # u wind
v = ncfile.variables['v'][:] # v wind

ncfile.close()

plt_lons, plt_lats = np.meshgrid(lon, lat)

data = z[0,8,:,:]

m = Basemap(llcrnrlon=np.min(lon),llcrnrlat=np.min(lat),urcrnrlon=np.max(lon),urcrnrlat=np.max(lat),projection='lcc', resolution='l', lat_1=-5, lat_0=-18, lon_0=-4.875)
m.drawcoastlines()
m.drawparallels(np.arange(-60,20,20))
m.drawmeridians(np.arange(-40,40,20))
ny = data.shape[0]; nx = data.shape[1]
lons, lats = m.makegrid(nx,ny)
x,y = m(lons,lats)
clevs = np.arange(600,1400,100)
cs = m.contour(x,y,data,clevs)
#ax1.pcolormesh(plt_lons, plt_lats, z[1,1,:,:])
