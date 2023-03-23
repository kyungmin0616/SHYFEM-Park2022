% data check

clear
clc
files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Dorian');
files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Matthew');
files(1:3)=[];
files(end)=[];
files2(1:3)=[];
files2(end)=[];


refDate = datenum('1900-01-01 00:00:00');

LONO = ncread([files(1).folder '/' files(1).name], 'longitude');
LATO = ncread([files(1).folder '/' files(1).name], 'latitude');

[LON,LAT]=meshgrid(LONO,LATO);
ECMWF.drLON=LON'; ECMWF.drLAT=LAT';


LONO = ncread([files2(1).folder '/' files2(1).name], 'longitude');
LATO = ncread([files2(1).folder '/' files2(1).name], 'latitude');

[LON2,LAT2]=meshgrid(LONO,LATO);
ECMWF.mtLON=LON2'; ECMWF.mtLAT=LAT2';

clear LON LAT LON2 LAT2
% Data loading

k=1;
for i=1:length(files)
    
    temp = ncread([files(i).folder '/' files(i).name], 'msl');
    time = double(ncread([files(i).folder '/' files(i).name], 'time'));
    tempu = ncread([files(i).folder '/' files(i).name], 'u10');
    tempv = ncread([files(i).folder '/' files(i).name], 'v10');
    for j=1:4
    ECMWF.u_d(:,:,k)= tempu(:,:,j);
    ECMWF.v_d(:,:,k)= tempv(:,:,j);
    ECMWF.msl_d(:,:,k)= temp(:,:,j);
    ECMWF.time_d(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
end


k=1;
for i=1:length(files2)
    
    temp = ncread([files2(i).folder '/' files2(i).name], 'msl');
    time = double(ncread([files2(i).folder '/' files2(i).name], 'time'));
    tempu = ncread([files2(i).folder '/' files2(i).name], 'u10');
    tempv = ncread([files2(i).folder '/' files2(i).name], 'v10');
    for j=1:4
    ECMWF.u_m(:,:,k)= tempu(:,:,j);
    ECMWF.v_m(:,:,k)= tempv(:,:,j);
    ECMWF.msl_m(:,:,k)= temp(:,:,j);
    ECMWF.time_m(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
    
end

ECMWF.wsp_m=sqrt(ECMWF.u_m.^2+ECMWF.v_m.^2);
ECMWF.wsp_d=sqrt(ECMWF.u_d.^2+ECMWF.v_d.^2);


%%%%%%%%%% NOAA %%%%%%%%%%%

clear GA_I
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/METEO/GA_MATTHEW.csv');
date1=table2array(GA_I(:,1));
NOAA.mttime=datenum(date1);
NOAA.mtws=table2array(GA_I(:,2));
NOAA.mtwd=table2array(GA_I(:,3));
NOAA.mtap=table2array(GA_I(:,6));

%%%%%%%%%%%%%% Dorian
clear GA_I
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/METEO/GA_DORIAN.csv');
date1=table2array(GA_I(:,1));
NOAA.drtime=datenum(date1);
NOAA.drws=table2array(GA_I(:,2));
NOAA.drwd=table2array(GA_I(:,3));
NOAA.drap=table2array(GA_I(:,6));




%%

h=figure('units','normalized','position',[0 0 1 1]);

clf
lat_s = 32.03455; 
lon_s = -80.902494;

dist = (ECMWF.mtLAT' - lat_s).^2+(ECMWF.mtLON' - lon_s).^2;
[min_dist,index_lat] = min(dist);
[min_dist,index_lon] = min(min(dist));

startDate=datenum('2016-09-30');
endDate=datenum('2016-10-15');
subplot(2,2,1)
plot(NOAA.mttime,NOAA.mtap,'or','LineWidth',2,'MarkerFaceColor','r');hold on
plot(ECMWF.time_m,squeeze(ECMWF.msl_m(index_lon(1),index_lat(1),:))/100,'k','LineWidth',3); hold on
ylim([970 1040])
ylabel('Atmospheric pressure (mb)')
legend('Observation','ECMWF','Location','northwest')
datetick('x','mmmdd','keeplimits')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/5:endDate])
title('Hurricane Matthew')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', 20)
set(gca,'XTickLabel',[]);
grid on

subplot(2,2,3)
plot(NOAA.mttime,NOAA.mtws,'or','LineWidth',2,'MarkerFaceColor','r');hold on
plot(ECMWF.time_m,squeeze(ECMWF.wsp_m(index_lon(1),index_lat(1),:)),'k','LineWidth',3); hold on
ylim([0 30])
ylabel('Wind speed (m/s)')
legend('Observation','ECMWF','Location','northwest')
datetick('x','mmmdd','keeplimits')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/5:endDate])
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', 20)
% set(gca,'XTickLabel',[]);
grid on
datetick('x','mmm-dd','keepticks')


%%%%%%%%%%%%%%%%%%%%%%%%%%  Dorian

lat_s = 32.03455;
lon_s = -80.902494;

dist = (ECMWF.drLAT' - lat_s).^2+(ECMWF.drLON' - lon_s).^2;
[min_dist,index_lat] = min(dist);
[min_dist,index_lon] = min(min(dist));

startDate=datenum('2019-08-28');
endDate=datenum('2019-09-12');
subplot(2,2,2)
plot(NOAA.drtime,NOAA.drap,'or','LineWidth',2,'MarkerFaceColor','r');hold on
plot(ECMWF.time_d,squeeze(ECMWF.msl_d(index_lon(1),index_lat(1),:))/100,'k','LineWidth',3);
ylim([995 1030])
ylabel('Atmospheric pressure (mb)')
legend('Observation','ECMWF','Location','northwest')
datetick('x','mmmdd','keeplimits')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/5:endDate])
title('Hurricane Dorian')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', 20)
set(gca,'XTickLabel',[]);
grid on

subplot(2,2,4)
plot(NOAA.drtime,NOAA.drws,'or','LineWidth',2,'MarkerFaceColor','r'); hold on
plot(ECMWF.time_d,squeeze(ECMWF.wsp_d(index_lon(1),index_lat(1),:)),'k','LineWidth',3); 
ylim([0 25])
ylabel('Wind speed (m/s)')
legend('Observation','ECMWF','Location','northwest')
datetick('x','mmmdd','keeplimits')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/5:endDate])
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', 20)
% set(gca,'XTickLabel',[]);
grid on
datetick('x','mmm-dd','keepticks')
set(gcf,'color','w')


