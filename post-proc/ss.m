
clear
clc
% file='/Users/kpark350/Ga_tech/Projects/DataSet/Bathymetry/GEBCO/SAB.nc';
% file='/Users/kpark350/Downloads/savannah_river_s120_30m.nc';
file='savannah_13_mhw_2006.nc'
file2='/Users/kpark350/ESM_Project/GEBCO_2020_31_Oct_2020_7bc8d31840ec/gebco_2020_n32.43448014809339_s31.725011514225592_w-81.19941206232897_e-80.43641621762208.nc'

lon = ncread(file2,'lon');
lat = ncread(file2,'lat');
depth=ncread(file,'Band1');
ele=ncread(file2,'elevation');

% axis([-81.165 -81.14 32.22 32.255]);

[LON,LAT]=meshgrid(lon,lat);
LON=LON';
LAT=LAT';

[LON2,LAT2]=meshgrid(lon,lat);
LON2=LON2';
LAT2=LAT2';


% Select coordinates of Pacific sector
% minlon=-81.3;
% maxlon=-80.8;
% minlat=31.9;
% maxlat=32.4;

minlon=-81.165;
maxlon=-81.14;
minlat=32.22;
maxlat=32.255;


I=find( LON(:,1) > minlon & LON(:,1) < maxlon);
J=find( LAT(1,:) > minlat & LAT(1,:) <= maxlat);

LON = LON(I,J);
LAT = LAT(I,J);
depth = depth(I,J);
wl=-1;
depth(depth>wl)=NaN;


% differentiate water
T_1 = Z_1; T_1(T_1<=0) = -1;
T_2 = Z_2; T_2(T_2<=0) = -1;
T_3 = Z_3; T_3(T_3<=0) = -1;
T_4 = Z_4; T_4(T_4<=0) = -1;



clear lon lat

figure(1)
clf
pcolorjw(LON,LAT,depth); hold on

[a, Ih]=min((LON(:,1)-tarlon).^2);
[a, Jh]=min((LAT(1,:)-tarlat).^2);




figure(2)
clf
pcolorjw(LON2,LAT2,ele); hold on
SAB_coast

tarlon=-80.8458;
tarlat=32.075;

tarlon=-80.6708;
tarlat=32.25;

[a, I]=min((LON2(:,1)-tarlon).^2);
[a, J]=min((LAT2(1,:)-tarlat).^2);
[a, Ih]=min((LON(:,1)-tarlon).^2);
[a, Jh]=min((LAT(1,:)-tarlat).^2);

ele(I,J)
depth(Ih,Jh)


about 1.9