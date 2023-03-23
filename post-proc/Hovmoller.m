clear
clc

%% CMEMS
clear CMEMS
% file='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2016_1YR.nc';
% file2='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2019_1YR.nc';

file='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/Matthew.nc';
file2='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/Dorian.nc';

% refdate = datenum('1950-01-01 00:00:00');
refdate = datenum('1949-12-31 23:30:00');


CMEMS.mtssh=squeeze(ncread(file,'zos'))+0.4337;
CMEMS.mttime=refdate+double(ncread(file,'time'))/24;
CMEMS.mtu=squeeze(ncread(file,'uo'));
CMEMS.mtv=squeeze(ncread(file,'vo'));

CMEMS.drssh=squeeze(ncread(file2,'zos'))+0.4599;
CMEMS.drtime=refdate+double(ncread(file2,'time'))/24;
CMEMS.dru=squeeze(ncread(file2,'uo'));
CMEMS.drv=squeeze(ncread(file2,'vo'));

lon=ncread(file,'longitude');
lat=ncread(file,'latitude');

[LON, LAT]=meshgrid(lon, lat);
CMEMS.LON=LON';
CMEMS.LAT=LAT';

% Low pass
lp_mt_day=13;
lp_dr_day=13;

clear temp temp CMEMS.drssh_lp CMEMS.mtssh_lp


for i=1:length(CMEMS.LON)
    for j=1:length(CMEMS.LAT)
        temp = squeeze(CMEMS.mtssh(i,j,:));
        temp(isnan(temp))=0;
        CMEMS.mtssh_lp(i,j,:)=lowpass(temp,1/(24*lp_mt_day));
        clear temp
  
        temp = squeeze(CMEMS.drssh(i,j,:));     
        temp(isnan(temp))=0;
        CMEMS.drssh_lp(i,j,:)=lowpass(temp,1/(24*lp_dr_day));
        clear temp
        
    end
end

CMEMS.mtssh_lp(CMEMS.mtssh_lp==0)=NaN;
CMEMS.drssh_lp(CMEMS.drssh_lp==0)=NaN;
CMEMS.mtssh_hp=CMEMS.mtssh-CMEMS.mtssh_lp;
CMEMS.drssh_hp=CMEMS.drssh-CMEMS.drssh_lp;
  
CMEMS.mtssh_hp=squeeze(CMEMS.mtssh)-CMEMS.mtssh_lp360;
CMEMS.drssh_hp=squeeze(CMEMS.drssh)-CMEMS.drssh_lp360;

clear lon lat LON LAT file file2

%% ECMWF
clear ECMWF

files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Dorian');
files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Matthew');
files(1:3)=[];
files(end)=[];
files2(1:3)=[];
files2(end)=[];

refDate = datenum('1900-01-01 00:00:00');

LONO = ncread([files2(1).folder '/' files2(1).name], 'longitude');
LATO = ncread([files2(1).folder '/' files2(1).name], 'latitude');

[LON,LAT]=meshgrid(LONO,LATO);
ECMWF.mtLON=LON'; ECMWF.mtLAT=LAT';

LONO = ncread([files(1).folder '/' files(1).name], 'longitude');
LATO = ncread([files(1).folder '/' files(1).name], 'latitude');

[LON2,LAT2]=meshgrid(LONO,LATO);
ECMWF.drLON=LON2'; ECMWF.drLAT=LAT2';

% Data loading
k=1;
for i=1:length(files2)
    
    temp = ncread([files2(i).folder '/' files2(i).name], 'msl');
    time = double(ncread([files2(i).folder '/' files2(i).name], 'time'));
    tempu = ncread([files2(i).folder '/' files2(i).name], 'u10');
    tempv = ncread([files2(i).folder '/' files2(i).name], 'v10');
    for j=1:4
    ECMWF.mtu(:,:,k)= tempu(:,:,j);
    ECMWF.mtv(:,:,k)= tempv(:,:,j);
    ECMWF.mtmsl(:,:,k)= temp(:,:,j);
    ECMWF.mttime(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
end


k=1;
for i=1:length(files)
    
    temp = ncread([files(i).folder '/' files(i).name], 'msl');
    time = double(ncread([files(i).folder '/' files(i).name], 'time'));
    tempu = ncread([files(i).folder '/' files(i).name], 'u10');
    tempv = ncread([files(i).folder '/' files(i).name], 'v10');
    for j=1:4
    ECMWF.dru(:,:,k)= tempu(:,:,j);
    ECMWF.drv(:,:,k)= tempv(:,:,j);
    ECMWF.drmsl(:,:,k)= temp(:,:,j);
    ECMWF.drtime(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
    
end


for i=1:length(ECMWF.mttime)
    ECMWF.mtwspd(:,:,i)=sqrt(ECMWF.mtu(:,:,i).^2 + ECMWF.mtv(:,:,i).^2);
end

for i=1:length(ECMWF.drtime)
    ECMWF.drwspd(:,:,i)=sqrt(ECMWF.dru(:,:,i).^2 + ECMWF.drv(:,:,i).^2);
end

% Direction of ws

test=atan2d(ECMWF.mtu(:,:,i),ECMWF.mtv(:,:,i));

NC=norm(C);
D=dot(u,v);
ThetaInDegrees = atan2d(NC,D);

for i=1:length(ECMWF.mttime)
    
    test(:,:,i)=atan2d(ECMWF.mtu(:,:,i),ECMWF.mtv(:,:,i));

end
    
clear LON LAT LON2 LAT2 LONO LATO temp tempu tempv time refdate refDate files files2

  

% Low pass
lp_mt_day=13;
lp_dr_day=13;

clear temp temp CMEMS.drssh_lp CMEMS.mtssh_lp


for i=1:length(CMEMS.LON)
    for j=1:length(CMEMS.LAT)
        temp = squeeze(CMEMS.mtssh(i,j,:));
        temp(isnan(temp))=0;
        CMEMS.mtssh_lp(i,j,:)=lowpass(temp,1/(24*lp_mt_day));
        clear temp
  
        temp = squeeze(CMEMS.drssh(i,j,:));     
        temp(isnan(temp))=0;
        CMEMS.drssh_lp(i,j,:)=lowpass(temp,1/(24*lp_dr_day));
        clear temp
        
    end
end

CMEMS.mtssh_lp(CMEMS.mtssh_lp==0)=NaN;
CMEMS.drssh_lp(CMEMS.drssh_lp==0)=NaN;
CMEMS.mtssh_hp=CMEMS.mtssh-CMEMS.mtssh_lp;
CMEMS.drssh_hp=CMEMS.drssh-CMEMS.drssh_lp;
  
CMEMS.mtssh_hp=squeeze(CMEMS.mtssh)-CMEMS.mtssh_lp360;
CMEMS.drssh_hp=squeeze(CMEMS.drssh)-CMEMS.drssh_lp360;

%% 2D Map

%Matthew

clw=-0.5;
chi=1.5;

clw_p=980;
chi_p=1020;

clw_w=0;
chi_w=30;

skp=5;
ftz=26;

%%%%%%%%%%%%%%%%

fw=1;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

%CMEMS
I=find(CMEMS.mttime==datenum('2016-10-07 18:00:00'));
clf
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,1,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca,'XTickLabel',[]);
title('SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

% Find targeted points
clear lon_hm lat_hm
[lon_hm(:,1), lat_hm(:,1)]=ginput; %First section

[Uni, index_uni] = unique(lat_hm);
lat_hm=lat_hm(index_uni,1);
lon_hm=lon_hm(index_uni,1);

% check the points
scatter(lon_hm(:,1), lat_hm(:,1),100,'filled','o','MarkerFaceColor','y',...
    'MarkerEdgeColor','y'); %Turner Creek Boat Ramp Sea Level Sensor
% save lonlat_hm.mat lon_hm lat_hm


%% Hovmoller diagram 

%%%%%%%%%%%%%%%%%%%% ECMWF 

% find the coordinate of dataset correspoinding to the targeted points
clear ILON ILAT

for i=1:length(lon_hm(:,1))
    
dist = (ECMWF.mtLON(:,1) - lon_hm(i,1)).^2;
[min_dist,ILON(i,1)] = min(dist);

dist = (ECMWF.mtLAT(ILON(i,1),:) - lat_hm(i,1)).^2;
[min_dist,ILAT(i,1)] = min(dist);

end


% find the coordinate of dataset correspoinding to the targeted points
clear ILON ILAT

for i=1:length(lon_hm(:,1))
    
dist = (ECMWF.drLON(:,1) - lon_hm(i,1)).^2;
[min_dist,ILON(i,1)] = min(dist);

dist = (ECMWF.drLAT(ILON(i,1),:) - lat_hm(i,1)).^2;
[min_dist,ILAT(i,1)] = min(dist);

end


% check the coordinate of dataset
figure
clf
scatter(ECMWF.drLON(ILON,1), ECMWF.drLAT(1,ILAT),100,'filled','r','MarkerFaceColor','r',...
    'MarkerEdgeColor','r'); %Turner Creek Boat Ramp Sea Level Sensor
hold on;
SAB_coast
axis([-82 -73 24 36]) % axis criterian
set(gca, 'FontSize', 26)
xlabel('Longitude')
ylabel('Latitude')
set(gcf,'color','w');
box


% Targeted time window
mtI=find(ECMWF.mttime>=datenum('2016-10-05 00:00:00') & ECMWF.mttime<=datenum('2016-10-11 00:00:00'));
drI=find(ECMWF.drtime>=datenum('2019-09-02 00:00:00') & ECMWF.drtime<=datenum('2019-09-08 00:00:00'));

clear ECMWF.mtmsl_hm
for j=1:length(ECMWF.mttime(mtI))
    for i=1:length(ILON(:,1))
    
        ECMWF.mtmsl_hm(i,j)= ECMWF.mtmsl(ILON(i,1),ILAT(i,1),mtI(j));
    end
end

clear ECMWF.drmsl_hm
for j=1:length(CMEMS.drtime(drI))
    for i=1:length(ILON(:,1))
    
        ECMWF.drmsl_hm(i,j)= ECMWF.drmsl(ILON(i,1),ILAT(i,1),drI(j));
    end
end

clear ECMWF.mtwspd_hm
for j=1:length(CMEMS.mttime(mtI))
    for i=1:length(ILON(:,1))
    
        ECMWF.mtwspd_hm(i,j)= ECMWF.mtwspd(ILON(i,1),ILAT(i,1),mtI(j));
    end
end

clear ECMWF.drwspd_hm
for j=1:length(CMEMS.drtime(mtI))
    for i=1:length(ILON(:,1))
    
        ECMWF.drwspd_hm(i,j)= ECMWF.drwspd(ILON(i,1),ILAT(i,1),drI(j));
    end
end



%grid for Hovmoller diagram
[ECMWF.mtLAT_hm, ECMWF.mttime_hm]=meshgrid(ECMWF.mtLAT(1,ILAT), ECMWF.mttime(mtI));
ECMWF.mtLAT_hm=ECMWF.mtLAT_hm';
ECMWF.mttime_hm=ECMWF.mttime_hm';

[ECMWF.drLAT_hm, ECMWF.drtime_hm]=meshgrid(ECMWF.drLAT(1,ILAT), ECMWF.drtime(drI));
ECMWF.drLAT_hm=ECMWF.drLAT_hm';
ECMWF.drtime_hm=ECMWF.drtime_hm';


%%%%%%%%%%%%%%%%%%%% CMEMS
% find the coordinate of dataset correspoinding to the targeted points
clear ILON ILAT

for i=1:length(lon_hm(:,1))
    
dist = (CMEMS.LON(:,1) - lon_hm(i,1)).^2;
[min_dist,ILON(i,1)] = min(dist);

dist = (CMEMS.LAT(ILON(i,1),:) - lat_hm(i,1)).^2;
[min_dist,ILAT(i,1)] = min(dist);

end

% check the coordinate of dataset
figure
clf
scatter(CMEMS.LON(ILON,1), CMEMS.LAT(1,ILAT),100,'filled','r','MarkerFaceColor','r',...
    'MarkerEdgeColor','r'); %Turner Creek Boat Ramp Sea Level Sensor
hold on;
SAB_coast
axis([-82 -73 24 36]) % axis criterian
set(gca, 'FontSize', 26)
xlabel('Longitude')
ylabel('Latitude')
set(gcf,'color','w');
box

% Targeted time window
mtI=find(CMEMS.mttime>=datenum('2016-10-05 00:00:00') & CMEMS.mttime<=datenum('2016-10-11 00:00:00'));
drI=find(CMEMS.drtime>=datenum('2019-09-02 00:00:00') & CMEMS.drtime<=datenum('2019-09-08 00:00:00'));

clear CMEMS.mtssh_hp_hm
for j=1:length(CMEMS.mttime(mtI))
    for i=1:length(ILON(:,1))
    
        CMEMS.mtssh_hp_hm(i,j)= CMEMS.mtssh_hp(ILON(i,1),ILAT(i,1),mtI(j));
    end
end

clear CMEMS.drssh_hp_hm
for j=1:length(CMEMS.drtime(drI))
    for i=1:length(ILON(:,1))
    
        CMEMS.drssh_hp_hm(i,j)= CMEMS.drssh_hp(ILON(i,1),ILAT(i,1),drI(j));
    end
end

clear CMEMS.mtu_hm
for j=1:length(CMEMS.mttime(mtI))
    for i=1:length(ILON(:,1))
    
        CMEMS.mtu_hm(i,j)= CMEMS.mtu(ILON(i,1),ILAT(i,1),mtI(j));
    end
end

clear CMEMS.dru_hm
for j=1:length(CMEMS.drtime(drI))
    for i=1:length(ILON(:,1))
    
        CMEMS.dru_hm(i,j)= CMEMS.dru(ILON(i,1),ILAT(i,1),drI(j));
    end
end


%grid for Hovmoller diagram
clear CMEMS.mtLAT_hm CMEMS.mttime_hm CMEMS.drLAT_hm CMEMS.drtime_hm
[CMEMS.mtLAT_hm, CMEMS.mttime_hm]=meshgrid(CMEMS.LAT(1,ILAT), CMEMS.mttime(mtI));
CMEMS.mtLAT_hm=CMEMS.mtLAT_hm';
CMEMS.mttime_hm=CMEMS.mttime_hm';

[CMEMS.drLAT_hm, CMEMS.drtime_hm]=meshgrid(CMEMS.LAT(1,ILAT), CMEMS.drtime(drI));
CMEMS.drLAT_hm=CMEMS.drLAT_hm';
CMEMS.drtime_hm=CMEMS.drtime_hm';

save LS_DATA.mat CMEMS ECMWF
%% Plotting

% Both hurricanes

fw=0.5;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

% Matthew
startDate=datenum('10-05-2016');
endDate=datenum('10-11-2016 00:00:00');

clf
h1=subplot(1,2,1);
pcolorjw(CMEMS.mtLAT_hm, CMEMS.mttime_hm, CMEMS.mtssh_hp_hm); hold on
set(gca,'xLim',[26 34.5]);
set(gca,'YLim',[startDate endDate]);
shading interp
colormap(jet)
hcb=colorbar;
title(hcb,'m','fontsize', 24)
caxis([-0.6 0.85]);
datetick('y', 'mmm-dd', 'keeplimits')
xlabel('Latitude')
ylabel('Time (2016)')
title('HPF-SSH')
graph_handle= gca;
xticks(26:2:34)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
box
set(gca, 'FontSize', 26)

h2=subplot(1,2,2);
pcolorjw(ECMWF.mtLAT_hm, ECMWF.mttime_hm, ECMWF.mtmsl_hm/100); hold on
set(gca,'xLim',[26 34.5]);
set(gca,'YLim',[startDate endDate]);
shading interp
colormap(jet)
hcb=colorbar;
title(hcb,'mb','fontsize', 24)
caxis([960 1020]);
datetick('y', 'mmm-dd', 'keeplimits')
xlabel('Latitude')
title('AP')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
graph_handle= gca;
xticks(26:2:34)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
box
set(gca, 'FontSize', 26)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Hov_MT.png',1));

% Dorian
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');
startDate=datenum('09-02-2019');
endDate=datenum('09-08-2019 00:00:00');

h3=subplot(1,2,1);
pcolorjw(CMEMS.drLAT_hm, CMEMS.drtime_hm, CMEMS.drssh_hp_hm); hold on
set(gca,'xLim',[26 34.5]);
set(gca,'YLim',[startDate endDate]);
shading interp
colormap(jet)
hcb=colorbar;
title(hcb,'m','fontsize', 24)
caxis([-0.6 0.65]);
datetick('y', 'mmm-dd', 'keeplimits')
xlabel('Latitude')
ylabel('Time (2019)')
title('HPF-SSH')
graph_handle= gca;
xticks(26:2:34)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
box
set(gca, 'FontSize', 26)

h4=subplot(1,2,2);
pcolorjw(ECMWF.drLAT_hm, ECMWF.drtime_hm, ECMWF.drmsl_hm/100); hold on
set(gca,'xLim',[26 34.5]);
set(gca,'YLim',[startDate endDate]);
shading interp
colormap(jet)
hcb=colorbar;
title(hcb,'mb','fontsize', 24)
caxis([980 1020]);
datetick('y', 'mmm-dd', 'keeplimits')
xlabel('Latitude')
title('AP')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
graph_handle= gca;
xticks(26:2:34)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
box
set(gca, 'FontSize', 26)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Hov_DR.png',1));


sp_width= 0.145;
sp_height= 0.87;
x_gap=0.07;
y_gap=0.08;

x1 = 0.08;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.07;
x4 = x3+sp_width+x_gap;



y1 = 0.08;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;


set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x4 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


%%

% Plotting
figure(1)
clf
subplot(1,4,1)
pcolorjw(CMEMS.mtLAT_hm, CMEMS.mttime_hm, CMEMS.mtssh_hp_hm); hold on
shading interp
colormap(jet)
% caxis([-0.4 1.5])
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('HPF-SSH')
box
set(gca, 'FontSize', 26)

subplot(1,4,2)
pcolorjw(ECMWF.mtLAT_hm, ECMWF.mttime_hm, ECMWF.mtmsl_hm); hold on
% pcolorjw(ECMWF.mtLAT_hm, ECMWF.mttime_hm, ECMWF.mtwspd_hm); hold on

shading interp
colormap(jet)
% caxis([-0.4 1.5])
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('Atmospheric pressure')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
box
set(gca, 'FontSize', 26)

subplot(1,4,3)
% pcolorjw(ECMWF.mtLAT_hm, ECMWF.mttime_hm, ECMWF.mtmsl_hm); hold on
pcolorjw(ECMWF.mtLAT_hm, ECMWF.mttime_hm, ECMWF.mtwspd_hm); hold on

shading interp
colormap(jet)
% caxis([-0.4 1.5])
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('Wind speed')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
box
set(gca, 'FontSize', 26)

subplot(1,4,4)
pcolorjw(CMEMS.mtLAT_hm, CMEMS.mttime_hm, CMEMS.mtu_hm); hold on
shading interp
colormap(gca,BWR2)
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('Zonal current')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
box
set(gca, 'FontSize', 26)

%%%%%%%% Dorian
figure(2)
subplot(1,4,1)
pcolorjw(CMEMS.drLAT_hm, CMEMS.drtime_hm, CMEMS.drssh_hp_hm); hold on
shading interp
colormap(jet)
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('HPF-SSH')
set(gcf,'color','w');
box
set(gca, 'FontSize', 26)

subplot(1,4,2)
pcolorjw(ECMWF.drLAT_hm, ECMWF.drtime_hm, ECMWF.drmsl_hm); hold on
% pcolorjw(ECMWF.drLAT_hm, ECMWF.drtime_hm, ECMWF.drwspd_hm); hold on
shading interp
colormap(jet)
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('AP')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
box
set(gca, 'FontSize', 26)


subplot(1,4,3)
% pcolorjw(ECMWF.mtLAT_hm, ECMWF.mttime_hm, ECMWF.mtmsl_hm); hold on
pcolorjw(ECMWF.drLAT_hm, ECMWF.drtime_hm, ECMWF.drwspd_hm); hold on
shading interp
colormap(jet)
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('Wind speed')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
box
set(gca, 'FontSize', 26)

subplot(1,4,4)
pcolorjw(CMEMS.drLAT_hm, CMEMS.drtime_hm, CMEMS.dru_hm); hold on
shading interp
colormap(gca,BWR2)
colorbar
datetick('y', 'mmm-dd', 'keepticks')
xlabel('Latitude')
ylabel('Time')
title('Zonal current')
set(gca,'YTickLabel',[]);
set(gcf,'color','w');
box
set(gca, 'FontSize', 26)



%%
save LSDATA.mat CMEMS ECMWF
save('LSDATA.mat', 'CMEMS', 'ECMWF', '-v7.3')

%% Time series


t_lon= -80.902494;
t_lat= 32.034550;

lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;

dist = (CMEMS.LON(:,1) - t_lon).^2;
[min_dist,cm_ILON] = min(dist);
dist = (CMEMS.LAT(cm_ILON,:) - t_lat).^2;
[min_dist,cm_ILAT] = min(dist);

t_lon= CMEMS.LON(cm_ILON+1,1);
t_lat= CMEMS.LAT(1,cm_ILAT);

t_lon= -80.902494;
t_lat= 32.034550;
dist = (ECMWF.drLON(:,1) - t_lon).^2;
[min_dist,ecdr_ILON] = min(dist);
dist = (ECMWF.drLAT(ecdr_ILON,:) - t_lat).^2;
[min_dist,ecdr_ILAT] = min(dist);

dist = (ECMWF.mtLON(:,1) - t_lon).^2;
[min_dist,ecmt_ILON] = min(dist);
dist = (ECMWF.mtLAT(ecmt_ILON,:) - t_lat).^2;
[min_dist,ecmt_ILAT] = min(dist);

    
CMEMS.LON(cm_ILON+1,1)
CMEMS.LAT(1,cm_ILAT)
ECMWF.drLON(ecdr_ILON,1)
ECMWF.drLAT(1,ecdr_ILAT)
ECMWF.mtLON(ecmt_ILON,1)
ECMWF.mtLAT(1,ecmt_ILAT)


%%

figure(1)
clf
TP=240;
os=0;
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
refDate = datenum('2016-10-04 00:00:00');

subplot(2,1,1)
plot(CMEMS.mttime,squeeze(CMEMS.mtssh(cm_ILON+1,cm_ILAT,:)),'-k','LineWidth',3)
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
datetick('x', 'mmm-dd', 'keepticks')
% legend('CMEMS-SSH')
% title('Matthew')
set(gca, 'FontSize', 26)
grid
set(gcf,'color','w');

subplot(2,1,2)
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
refDate = datenum('2019-09-01 00:00:00');
plot(CMEMS.drtime,squeeze(CMEMS.drssh(cm_ILON+1,cm_ILAT,:)),'-k','LineWidth',3)
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
datetick('x', 'mmm-dd', 'keepticks')
% legend('CMEMS-SSH')
% title('Dorian')
set(gca, 'FontSize', 26)
set(gcf,'color','w');
grid
%%
figure(1)
clf
TP=240;
os=0;
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
refDate = datenum('2016-10-04 00:00:00');

subplot(2,1,1)
% plot(ECMWF.mttime,squeeze(ECMWF.mtmsl(ecmt_ILON,ecmt_ILAT,:)),'LineWidth',3);hold on
% plot(ECMWF.mttime,squeeze(ECMWF.mtwspd(ecmt_ILON,ecmt_ILAT,:)),'r','LineWidth',3);hold on
yyaxis right
plot(CMEMS.mttime,squeeze(CMEMS.mtssh_hp(cm_ILON+1,cm_ILAT,:)),'-k','LineWidth',3)
% plot(refDate+time2(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 
% plot(refDate+time2(1:TP,1)/(60*60*24),sshtime2(1,1:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
% plot(refDate+time3(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+os,'-m','linewidth', 2,'MarkerSize',15);
plot(NOAA.mttime,NOAA.mttotal-NOAA.mttide,'-y','linewidth',5);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
datetick('x', 'mmm-dd', 'keepticks')
legend('WS','HPF-SSH','BS','LF','RF')
title('Matthew')
set(gca, 'FontSize', 26)
grid

subplot(2,1,2)
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
refDate = datenum('2019-09-01 00:00:00');
% plot(ECMWF.drtime,squeeze(ECMWF.drmsl(ecdr_ILON,ecdr_ILAT,:)),'LineWidth',3);hold on
plot(ECMWF.drtime,squeeze(ECMWF.drwspd(ecdr_ILON,ecdr_ILAT,:)),'r','LineWidth',3);hold on
yyaxis right 
plot(CMEMS.drtime,squeeze(CMEMS.drssh_hp(cm_ILON+1,cm_ILAT,:)),'-k','LineWidth',3)
plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(1:TP,1)/(60*60*24),sshtime3_d(1,1:TP)+os,'-m','linewidth', 2,'MarkerSize',15); 
plot(NOAA.drtime,NOAA.drtotal-NOAA.drtide,'-y','linewidth',5);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
datetick('x', 'mmm-dd', 'keepticks')
legend('WS','HPF-SSH','BS','LF','RF')
title('Dorian')
set(gca, 'FontSize', 26)
set(gcf,'color','w');
grid

%%


figure(1)
clf
TP=240;
os=0;
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
refDate = datenum('2016-10-04 00:00:00');

subplot(2,1,1)
% plot(ECMWF.mttime,squeeze(ECMWF.mtmsl(ecmt_ILON,ecmt_ILAT,:)),'LineWidth',3);hold on
plot(ECMWF.mttime,squeeze(test(ecmt_ILON,ecmt_ILAT,:)),'r','LineWidth',3);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
datetick('x', 'mmm-dd', 'keepticks')
legend('WS','HPF-SSH','BS','LF','RF')
title('Matthew')
set(gca, 'FontSize', 26)
grid


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_filter2_1.png',1));

