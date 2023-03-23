clear
clc

lon = ncread('savParkBathy.nc','lon');
lat = ncread('savParkBathy.nc','lat');
depth=ncread('savParkBathy.nc','depth');



[LON,LAT]=meshgrid(lon,lat);

% Select coordinates of Pacific sector
minlon=-81.3;
maxlon=-80.8;
minlat=31.9;
maxlat=32.4;
I=find( LON(:,1) > minlon & LON(:,1) < maxlon);
J=find( LAT(1,:) > minlat & LAT(1,:) < maxlat);

pcolorjw(LON,LAT,depth);


figure(1)
pcolor(LON,LAT,depth);

find(depth<0)