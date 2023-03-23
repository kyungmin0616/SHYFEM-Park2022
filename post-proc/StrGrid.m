resol = 0.01; % km
del = resol / 100; % km to deg

lonmin = -81.55;
lonmax = -80.23;

latmin = 31.08;
latmax = 32.58;


lon1 = lonmin :del: lonmax;
lat1 = latmin :del: latmax;


[lon, lat] = meshgrid(lon1, lat1);