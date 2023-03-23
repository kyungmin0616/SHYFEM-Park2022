clear
clc

% read 1/3 resolution data
[Z_1, R_1] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/USGS_NED_13_n33w082_GridFloat/usgs_ned_13_n33w082_gridfloat.flt');
[Z_2, R_2] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/n33w081_13/floatn33w081_13.flt');
[Z_3, R_3] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/n32w082_13/floatn32w082_13.flt');
[Z_4, R_4] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/n32w081_13/floatn32w081_13.flt');

% read 1 resolution data
[Z_1, R_1] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/USGS_NED_1_n33w082_GridFloat/usgs_ned_1_n33w082_gridfloat.flt');
[Z_2, R_2] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/n33w081_1/floatn33w081_1.flt');
[Z_3, R_3] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/n32w082_1/floatn32w082_1.flt');
[Z_4, R_4] = arcgridread('/Users/kpark350/Ga_tech/Projects/SHYFEM/Elevation/n32w081_1/floatn32w081_1.flt');

wl=0;

% devide water
T_1 = Z_1; T_1(T_1>wl) = NaN;
T_2 = Z_2; T_2(T_2>wl) =  NaN;
T_3 = Z_3; T_3(T_3>wl) =  NaN;
T_4 = Z_4; T_4(T_4>wl) =  NaN;



% 2D map of elevation
zlimits=[-1 6];

figure(1)
clf
% geoshow(Z_1, R_1, 'DisplayType','surface'); 
% hold on;
% geoshow(Z_2, R_2, 'DisplayType','surface')
% geoshow(Z_3, R_3, 'DisplayType','surface')
% geoshow(Z_4, R_4, 'DisplayType','surface')

geoshow(T_1, R_1, 'DisplayType','surface'); hold on;
geoshow(T_2, R_2, 'DisplayType','surface')
geoshow(T_3, R_3, 'DisplayType','surface')
geoshow(T_4, R_4, 'DisplayType','surface')

demcmap('inc',zlimits,1);
colorbar
axis([-81.2 -80.8 31.9 32.3])

xlabel('Longitude', 'Fontsize', 20, 'FontWeight', 'bold')
ylabel('Latitude', 'Fontsize', 20, 'FontWeight', 'bold')
title('Elevation around Savannah', 'Fontsize', 20)
set(gca, 'FontSize', 16)






% Structure grid
StrGrid

% interpolate elevation data to structure grid

v1 = geointerp(Z_1, R_1, lat, lon, 'cubic');
v2 = geointerp(Z_2, R_2, lat, lon, 'cubic');
v3 = geointerp(Z_3, R_3, lat, lon, 'cubic');
v4 = geointerp(Z_4, R_4, lat, lon, 'cubic');

i=0;
% devide water
t1 = v1; t1(t1<=i) = -1;
t2 = v2; t2(t2<=i) = -1;
t3 = v3; t3(t3<=i) = -1;
t4 = v4; t4(t4<=i) = -1;


% Map of interpolated data
figure(1)
clf
zlimits=[-1 6];
pcolorjw(lon, lat, t1); hold on;
demcmap('inc',zlimits,1);
pcolorjw(lon, lat, t2);
demcmap('inc',zlimits,1);
pcolorjw(lon, lat, t3);
demcmap('inc',zlimits,1);
pcolorjw(lon, lat, t4);
demcmap('inc',zlimits,1);
axis([-81.2 -80.8 31.9 32.3])
colorbar
xlabel('Longitude', 'Fontsize', 20, 'FontWeight', 'bold')
ylabel('Latitude', 'Fontsize', 20, 'FontWeight', 'bold')
title('Elevation around Savannah', 'Fontsize', 20)
set(gca, 'FontSize', 16)



% Boundary line on 4m of elevation
contour(lon, lat, v1,[4 4],'k'); hold on;
contour(lon, lat, v2,[4 4],'k');
contour(lon, lat, v3,[4 4],'k');
contour(lon, lat, v4,[4 4],'k');

figure
% Map of interpolated data
clf
% zlimits=[-1 9];
pcolorjw(lon, lat, v1); hold on;
% demcmap(zlimits);
pcolorjw(lon, lat, v2);
% demcmap(zlimits);
pcolorjw(lon, lat, v3);
% demcmap(zlimits);
pcolorjw(lon, lat, v4);
% demcmap(zlimits);
colorbar

caxis([-10 30]);
colormap(bluewhitered)

