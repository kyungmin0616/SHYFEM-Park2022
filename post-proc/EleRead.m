
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


% differentiate water
T_1 = Z_1; T_1(T_1<=0) = -1;
T_2 = Z_2; T_2(T_2<=0) = -1;
T_3 = Z_3; T_3(T_3<=0) = -1;
T_4 = Z_4; T_4(T_4<=0) = -1;



% 2D map of elevation

figure(1)

% geoshow(Z_1, R_1, 'DisplayType','surface'); 
% hold on;
% geoshow(Z_2, R_2, 'DisplayType','surface')
% geoshow(Z_3, R_3, 'DisplayType','surface')
% geoshow(Z_4, R_4, 'DisplayType','surface')

geoshow(T_1, R_1, 'DisplayType','surface'); hold on;
geoshow(T_2, R_2, 'DisplayType','surface')
geoshow(T_3, R_3, 'DisplayType','surface')
geoshow(T_4, R_4, 'DisplayType','surface')

colorbar
% demcmap('inc',[max(max(T_1)) min(min(T_4))],1);
demcmap('inc',[10 -1],1);
axis([-81.4 -80.4 31.5 32.7])

xlabel('Longitude', 'Fontsize', 20, 'FontWeight', 'bold')
ylabel('Latitude', 'Fontsize', 20, 'FontWeight', 'bold')
title('4m elevation contour', 'Fontsize', 20)
set(gca, 'FontSize', 16)






% Structure grid
StrGrid

% interpolate elevation data to grid

v1 = geointerp(Z_1, R_1, lat, lon, 'cubic');
v2 = geointerp(Z_2, R_2, lat, lon, 'cubic');
v3 = geointerp(Z_3, R_3, lat, lon, 'cubic');
v4 = geointerp(Z_4, R_4, lat, lon, 'cubic');

% Boundary line on 4m of elevation
contour(lon, lat, v1,[4 4],'k'); hold on;
contour(lon, lat, v2,[4 4],'k');
contour(lon, lat, v3,[4 4],'k');
contour(lon, lat, v4,[4 4],'k');

% Map of interpolated data
pcolorjw(lon, lat, v1); hold on;
pcolorjw(lon, lat, v2);
pcolorjw(lon, lat, v3);
pcolorjw(lon, lat, v4);

