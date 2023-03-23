lon(1,1) = -83.75;
lat(1,1) = 28.25;

for i=2:49
    lon(i,1) = lon(i-1,1)+0.125;
end

for i=2:45
    lat(i,1) = lat(i-1,1)+0.125;
end

[LON, LAT] = meshgrid(lon,lat);

figure(1)
pcolorjw(LON,LAT,u);
hold on; world_coast
colormap(getpmap(7));
colorbar

figure(1)
pcolorjw(LON,LAT,v);
hold on; world_coast
colormap(getpmap(7));
colorbar

figure(1)
pcolorjw(LON,LAT,uv);
hold on; world_coast
colormap(getpmap(7));
colorbar

figure(1)
pcolorjw(LON,LAT,p);
hold on; world_coast
colormap(getpmap(7));
colorbar

uv = sqrt((u.^2) + (v.^2));


