clear
clc

% ARGO
mtfiles = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ARGO/Matthew');
mtfiles(1:3)=[];

drfiles = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ARGO/Dorian');
drfiles(1:3)=[];

%CMEMS
refdate = datenum('1950-01-01 00:00:00');

file='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/Matthew_depth_0928to1018.nc';
file2='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/Dorian_depth_0824to0915.nc';

CMEMS.lon=ncread(file,'longitude');
CMEMS.lat=ncread(file,'latitude');
CMEMS.depth=ncread(file,'depth');
CMEMS.mttime=double(ncread(file,'time'))/24+refdate;
CMEMS.drtime=double(ncread(file2,'time'))/24+refdate;
CMEMS.mtpsal=ncread(file,'so');
CMEMS.drpsal=ncread(file2,'so');
CMEMS.mttemp=ncread(file,'thetao');
CMEMS.drtemp=ncread(file2,'thetao');

clear file file2

%%

axis([-84 -64.5 20 40]);
clear lonVec latVec imag
[lonVec latVec imag]=plot_google_map('MapType','satellite','Resize',2,'AutoAxis',0,'Refresh',0,'ShowLabels',0);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)

save SAB_GGMAP.mat lonVec latVec imag

%% LOCATION OF ARGO

h=figure('units','normalized','position',[0 0 1 1]);

clf
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
view(0,90);
dx=0.2;
dy=0;

stt=datenum('2016-10-05 00:00:00');
ent=datenum('2016-10-14 00:00:00');
for i = 1:length(mtfiles)
    TIME=ncread([mtfiles(i).folder '/' mtfiles(i).name],'JULD')+datenum('1950-01-01 00:00:00');
    LON=ncread([mtfiles(i).folder '/' mtfiles(i).name],'LONGITUDE');
    LAT=ncread([mtfiles(i).folder '/' mtfiles(i).name],'LATITUDE');
    
    ARGO_NAME=mtfiles(i).name;
    ARGO_NAME(regexp(ARGO_NAME,'[_prof.nc]'))=[];
    AGI=find(TIME>=stt & TIME<=ent);

    
    scatter3(LON(AGI(1,1),1), LAT(AGI(1,1),1),100,120,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %Turner Creek Boat Ramp Sea Level Sensor
    hold on;
    text(LON(AGI(1,1),1)+dx, LAT(AGI(1,1),1)+dy, ARGO_NAME, 'Color', 'w', 'FontWeight', 'Bold','Fontsize', 12.5);

    set(gca,'fontsize',20)

end

stt=datenum('2019-09-02 00:00:00');
ent=datenum('2019-09-12 00:00:00');
for i = 1:length(drfiles)
    TIME=ncread([drfiles(i).folder '/' drfiles(i).name],'JULD')+datenum('1950-01-01 00:00:00');
    LON=ncread([drfiles(i).folder '/' drfiles(i).name],'LONGITUDE');
    LAT=ncread([drfiles(i).folder '/' drfiles(i).name],'LATITUDE');
    
    ARGO_NAME=drfiles(i).name;
    ARGO_NAME(regexp(ARGO_NAME,'[_prof.nc]'))=[];
    AGI=find(TIME>=stt & TIME<=ent);

    
    scatter3(LON(AGI(1,1),1), LAT(AGI(1,1),1),100,120,'filled','o','MarkerFaceColor','r',...
    'MarkerEdgeColor','r'); %Turner Creek Boat Ramp Sea Level Sensor
    hold on;
    text(LON(AGI(1,1),1)+dx, LAT(AGI(1,1),1)+dy, ARGO_NAME, 'Color', 'w', 'FontWeight', 'Bold','Fontsize', 12.5);

    view(0,90);
    set(gca,'fontsize',20)

end
axis([-84 -64.5 20 40]);
box on;
graph_handle= gca;
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
xlabel('Longitude')
ylabel('Latitude')
set(gcf,'color','w')
set(gca,'fontsize',25)

%% Matthew
stt=datenum('2016-10-05 00:00:00');
ent=datenum('2016-10-14 00:00:00');

% Temperature
h=figure('units','normalized','position',[0 0 1 1]);
for i = 1:length(mtfiles)
     
    PRES=ncread([mtfiles(i).folder '/' mtfiles(i).name],'PRES_ADJUSTED');
    TEMP=ncread([mtfiles(i).folder '/' mtfiles(i).name],'TEMP_ADJUSTED');
    TIME=ncread([mtfiles(i).folder '/' mtfiles(i).name],'JULD')+datenum('1950-01-01 00:00:00');
    LON=ncread([mtfiles(i).folder '/' mtfiles(i).name],'LONGITUDE');
    LAT=ncread([mtfiles(i).folder '/' mtfiles(i).name],'LATITUDE');
    
    ARGO_NAME=mtfiles(i).name;
    ARGO_NAME(regexp(ARGO_NAME,'[_prof.nc]'))=[];
    
    AGI=find(TIME>=stt & TIME<=ent);
    dist = (CMEMS.mttime(:,1) - TIME(AGI(1,1),1)).^2;
    [min_dist,cm_ITIME] = min(dist);

    dist = (CMEMS.lon(:,1) - LON(AGI(1,1),1)).^2;
    [min_dist,cm_ILON] = min(dist);
    dist = (CMEMS.lat(:,1) - LAT(AGI(1,1),1)).^2;
    [min_dist,cm_ILAT] = min(dist);
    
    subplot(ceil(length(mtfiles)/3),3,i)
    plot(squeeze(CMEMS.mttemp(cm_ILON,cm_ILAT,:,cm_ITIME)),CMEMS.depth(:,1),'k','LineWidth',2);hold on
    plot(TEMP(:,AGI(1,1)),PRES(:,AGI(1,1)),'r','LineWidth',2); 
    ylim([0 max(PRES(:,AGI(1,1)))])
    title("Profile ID: "+ARGO_NAME,datestr(TIME(AGI(1,1),1),'yyyy-mm-dd HH:MM:SS'))
%     xlabel('Temperature (^{\circ}C)')
%     ylabel('Pressure (dbar)')
    set(gca, 'YDir','reverse')
    legend('CMEMS','ARGO','Location','northwest')
    set(gca,'fontsize',20)

end
  set(gcf,'color','w')

% Salinity
h=figure('units','normalized','position',[0 0 1 1]);
for i = 1:length(mtfiles)
     
    PSAL=ncread([mtfiles(i).folder '/' mtfiles(i).name],'PSAL_ADJUSTED');
    PRES=ncread([mtfiles(i).folder '/' mtfiles(i).name],'PRES_ADJUSTED');
    TIME=ncread([mtfiles(i).folder '/' mtfiles(i).name],'JULD')+datenum('1950-01-01 00:00:00');
    LON=ncread([mtfiles(i).folder '/' mtfiles(i).name],'LONGITUDE');
    LAT=ncread([mtfiles(i).folder '/' mtfiles(i).name],'LATITUDE');
    
    ARGO_NAME=mtfiles(i).name;
    ARGO_NAME(regexp(ARGO_NAME,'[_prof.nc]'))=[];
    
    AGI=find(TIME>=stt & TIME<=ent);
    dist = (CMEMS.mttime(:,1) - TIME(AGI(1,1),1)).^2;
    [min_dist,cm_ITIME] = min(dist);

    dist = (CMEMS.lon(:,1) - LON(AGI(1,1),1)).^2;
    [min_dist,cm_ILON] = min(dist);
    dist = (CMEMS.lat(:,1) - LAT(AGI(1,1),1)).^2;
    [min_dist,cm_ILAT] = min(dist);
    
    subplot(ceil(length(mtfiles)/3),3,i)
    plot(squeeze(CMEMS.mtpsal(cm_ILON,cm_ILAT,:,cm_ITIME)),CMEMS.depth(:,1),'k','LineWidth',2);hold on
    plot(PSAL(:,AGI(1,1)),PRES(:,AGI(1,1)),'r','LineWidth',2); 
    ylim([0 max(PRES(:,AGI(1,1)))])
    title("Profile ID: "+ARGO_NAME,datestr(TIME(AGI(1,1),1),'yyyy-mm-dd HH:MM:SS'))
%     xlabel('Temperature (^{\circ}C)')
%     ylabel('Pressure (dbar)')
    set(gca, 'YDir','reverse')
    legend('CMEMS','ARGO','Location','northwest')
    set(gca,'fontsize',20)

end
  set(gcf,'color','w')

%% Dorian
stt=datenum('2019-09-02 00:00:00');
ent=datenum('2019-09-12 00:00:00');

% Temperature
h=figure('units','normalized','position',[0 0 1 1]);
for i = 1:length(drfiles)
     
    PRES=ncread([drfiles(i).folder '/' drfiles(i).name],'PRES_ADJUSTED');
    TEMP=ncread([drfiles(i).folder '/' drfiles(i).name],'TEMP_ADJUSTED');
    TIME=ncread([drfiles(i).folder '/' drfiles(i).name],'JULD')+datenum('1950-01-01 00:00:00');
    LON=ncread([drfiles(i).folder '/' drfiles(i).name],'LONGITUDE');
    LAT=ncread([drfiles(i).folder '/' drfiles(i).name],'LATITUDE');
    
    ARGO_NAME=drfiles(i).name;
    ARGO_NAME(regexp(ARGO_NAME,'[_prof.nc]'))=[];
    
    AGI=find(TIME>=stt & TIME<=ent);
    dist = (CMEMS.drtime(:,1) - TIME(AGI(1,1),1)).^2;
    [min_dist,cm_ITIME] = min(dist);

    dist = (CMEMS.lon(:,1) - LON(AGI(1,1),1)).^2;
    [min_dist,cm_ILON] = min(dist);
    dist = (CMEMS.lat(:,1) - LAT(AGI(1,1),1)).^2;
    [min_dist,cm_ILAT] = min(dist);
    
    subplot(ceil(length(drfiles)/3),3,i)
    plot(squeeze(CMEMS.drtemp(cm_ILON,cm_ILAT,:,cm_ITIME)),CMEMS.depth(:,1),'k','LineWidth',2);hold on
    plot(TEMP(:,AGI(1,1)),PRES(:,AGI(1,1)),'r','LineWidth',2); 
    ylim([0 max(PRES(:,AGI(1,1)))])
    title("Profile ID: "+ARGO_NAME,datestr(TIME(AGI(1,1),1),'yyyy-mm-dd HH:MM:SS'))
%     xlabel('Temperature (^{\circ}C)')
%     ylabel('Pressure (dbar)')
    set(gca, 'YDir','reverse')
    legend('CMEMS','ARGO','Location','northwest')
    set(gca,'fontsize',20)

end
  set(gcf,'color','w')

% Salinity
h=figure('units','normalized','position',[0 0 1 1]);
for i = 1:length(drfiles)
     
    PRES=ncread([drfiles(i).folder '/' drfiles(i).name],'PRES_ADJUSTED');
    PSAL=ncread([drfiles(i).folder '/' drfiles(i).name],'PSAL_ADJUSTED');
    TIME=ncread([drfiles(i).folder '/' drfiles(i).name],'JULD')+datenum('1950-01-01 00:00:00');
    LON=ncread([drfiles(i).folder '/' drfiles(i).name],'LONGITUDE');
    LAT=ncread([drfiles(i).folder '/' drfiles(i).name],'LATITUDE');
    
    ARGO_NAME=drfiles(i).name;
    ARGO_NAME(regexp(ARGO_NAME,'[_prof.nc]'))=[];
    
    AGI=find(TIME>=stt & TIME<=ent);
    dist = (CMEMS.drtime(:,1) - TIME(AGI(1,1),1)).^2;
    [min_dist,cm_ITIME] = min(dist);

    dist = (CMEMS.lon(:,1) - LON(AGI(1,1),1)).^2;
    [min_dist,cm_ILON] = min(dist);
    dist = (CMEMS.lat(:,1) - LAT(AGI(1,1),1)).^2;
    [min_dist,cm_ILAT] = min(dist);
    
    subplot(ceil(length(drfiles)/3),3,i)
    plot(squeeze(CMEMS.drpsal(cm_ILON,cm_ILAT,:,cm_ITIME)),CMEMS.depth(:,1),'k','LineWidth',2);hold on
    plot(PSAL(:,AGI(1,1)),PRES(:,AGI(1,1)),'r','LineWidth',2); 
    ylim([0 max(PRES(:,AGI(1,1)))])
    title("Profile ID: "+ARGO_NAME,datestr(TIME(AGI(1,1),1),'yyyy-mm-dd HH:MM:SS'))
%     xlabel('Temperature (^{\circ}C)')
%     ylabel('Pressure (dbar)')
    set(gca, 'YDir','reverse')
    legend('CMEMS','ARGO','Location','northwest')
    set(gca,'fontsize',20)

end

set(gcf,'color','w')
