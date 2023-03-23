
%% CMEMS

file='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2016_1YR.nc';
file2='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2019_1YR.nc';
refdate = datenum('1949-12-31 23:30:00');

clear CMEMS

CMEMS.mtssh=squeeze(ncread(file,'zos'));
CMEMS.mttime=refdate+double(ncread(file,'time'))/24;

CMEMS.drssh=squeeze(ncread(file2,'zos'));
CMEMS.drtime=refdate+double(ncread(file2,'time'))/24;

lon=ncread(file,'longitude');
lat=ncread(file,'latitude');

[LON, LAT]=meshgrid(lon, lat);
CMEMS.LON=LON';
CMEMS.LAT=LAT';

clear lon lat LON LAT


%% NOAA

% % Meteo
% FLF_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/METEO/GA_MATTHEW.csv');
% date1=table2array(FLF_I(:,1));
% GA_ME(:,1)=datenum(date1);
% GA_ME(:,2) = table2array(FLF_I(:,2));
% GA_ME(:,3) = table2array(FLF_I(:,3));
% GA_ME(:,4) = table2array(FLF_I(:,6));

%%%%%%%%%%% MATTHEW
clear GA_I NOAA
%%%%%%%%%% Observation %%%%%%%%%%%

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_MT_1Y.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));

NOAA.mttime=datenum(strcat(date1,{' '},date2));
NOAA.mttotal = table2array(GA_I(:,5));
NOAA.mttide = table2array(GA_I(:,3));
NOAA.mtresi = NOAA.mttotal-NOAA.mttide;


%%%%%%%%%%% Dorian
clear GA_I date1 date2 
%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_DR_1Y.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));

NOAA.drtime=datenum(strcat(date1,{' '},date2));
NOAA.drtotal = table2array(GA_I(:,5));
NOAA.drtide = table2array(GA_I(:,3));
NOAA.drresi = NOAA.drtotal-NOAA.drtide;

clear GA_I date1 date2


% temp_mm=zeta_m;
% temp_mm(isnan(temp_mm))=0;

%% HYCOM

files3 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/HYCOM');
files3(1:18)=[];
refDate = datenum('2000-01-01 00:00:00');

LONO = ncread([files3(1).folder '/' files3(1).name], 'lon');
LATO = ncread([files3(1).folder '/' files3(1).name], 'lat');

[LON,LAT]=meshgrid(LONO,LATO);
HYCOM.LON=LON'; HYCOM.LAT=LAT';
clear LON LAT LONO LATO


k=1;
for i=1:length(files3)
    
    clear temp time
    temp = ncread([files3(i).folder '/' files3(i).name], 'surf_el');
    time= ncread([files3(i).folder '/' files3(i).name], 'time');

    for j=1:8
    HYCOM.ssh(:,:,k)= temp(:,:,j);
    HYCOM.time(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
end
lat_s = 32.04;  % Fort Pulaski
lon_s = -80.76;

figure(1)
clf
pcolorjw(HYCOM.LON, HYCOM.LAT, HYCOM.ssh(:,:,1)); hold on
% pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,1)); hold on

SAB_coast
colormap(gca,getpmap(7));
% colb1=colorbar('northoutside');
% title(colb1,'Low-pass filtered SSH (m)', 'FontWeight', 'bold')
scatter(-80.8692,32.0192,200,'filled','s','MarkerFaceColor','r',...
    'MarkerEdgeColor','r'); 

scatter(-80.76,32.04,200,'filled','s','MarkerFaceColor','b',...
    'MarkerEdgeColor','b'); 


caxis([-0.4 0.8])
axis([-81.2 -79.8 31 32.6]) % axis criterian
ylabel('Latitude', 'FontWeight', 'bold')
% title('SSH low-pass');
graph_handle= gca;
% xticks(lonmin:2:lonmax)
% yticks(latmin:2:latmax)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca, 'FontSize', 20)



%% Low pass

lat_s = 32.0192;  % Fort Pulaski for CMEMS
lon_s = -80.8692;

% 
% lat_s = 32.0696;  % point 1 boundary
% lon_s = -80.3699;
% 
% lat_s = 31.96;  % point 2 boundary
% lon_s = -80.44;
% 
% lat_s = 31.8;  % point 3 boundary
% lon_s = -80.6;
% 
% lat_s = 31.64;  % point 4 boundary
% lon_s = -80.68;
% 
% lat_s = 31.4;  % point 5 boundary
% lon_s = -80.84;
% 
% lat_s = 31.2397;  % point 5 boundary
% lon_s = -80.9717;

% dist = (lat_SHY' - lat_s).^2+(lon_SHY' - lon_s).^2;
% [min_dist,index_dist] = min(dist);
% 
% sshtime1=squeeze(ssh_SHY(index_dist,:));
% sshtime2=squeeze(ssh_SHY2(index_dist,:));

dist = (CMEMS.LAT - lat_s).^2+(CMEMS.LON - lon_s).^2;
[min_dist,lon_id_f] = min(dist);
[min_dist,lat_id_f] = min(min(dist));
% 
% lat_s = 32.04;  % Fort Pulaski for HYCOM
% lon_s = -80.76;
% 
% dist = (HYCOM.LAT - lat_s).^2+(HYCOM.LON - lon_s).^2;
% [min_dist,lon_id_h] = min(dist);
% [min_dist,lat_id_h] = min(min(dist));
% 
% 
% HYCOM.LON(lon_id_h(1),lat_id_h)
% HYCOM.LAT(lon_id_h(1),lat_id_h)


CMEMS.mtssh_p=squeeze(CMEMS.mtssh(lon_id_f(1),lat_id_f,:));
CMEMS.drssh_p=squeeze(CMEMS.drssh(lon_id_f(1),lat_id_f,:));
% HYCOM.ssh_p=squeeze(HYCOM.ssh(lon_id_h(1),lat_id_h,:));


CIM = find(CMEMS.mttime(:,1)>=datenum('2016-09-25 00:00:00') & CMEMS.mttime<=datenum('2016-10-25 00:00:00'));
NIM = find(NOAA.mttime(:,1)>=datenum('2016-09-25 00:00:00') & NOAA.mttime<=datenum('2016-10-25 00:00:00'));

CID = find(CMEMS.drtime(:,1)>=datenum('2019-08-20 00:00:00') & CMEMS.drtime<=datenum('2019-09-20 00:00:00'));
NID = find(NOAA.drtime(:,1)>=datenum('2019-08-20 00:00:00') & NOAA.drtime<=datenum('2019-09-20 00:00:00'));



clear a_x2 a_x 

a_x=1:1:length(CIM);
a_x2=1:(length(CIM)-1)/(length(NOAA.mttime(NIM))-1):length(CIM);

CMEMS.mtssh_p_int=interp1(a_x,CMEMS.mtssh_p(CIM),a_x2)';

clear a_x2 a_x 
a_x=1:1:length(CID);
a_x2=1:(length(CID)-1)/(length(NOAA.mttime(NID))-1):length(CID);

CMEMS.drssh_p_int=interp1(a_x,CMEMS.drssh_p(CID),a_x2)';



lp_mt_day=18;
lp_dr_day=18;

NOAA.mttotal_lp=lowpass(NOAA.mtresi,1/(lp_mt_day*10));
NOAA.drtotal_lp=lowpass(NOAA.drresi,1/(lp_dr_day*10));

nanmean(NOAA.mttotal_lp(NIM)-CMEMS.mtssh_p_int)
nanmean(NOAA.drtotal_lp(NID)-CMEMS.drssh_p_int)

%%
% clf


% startDate = datenum('09-01-2019');
% endDate = datenum('09-14-2019');
% refDate = datenum('2016-10-04 00:00:00');
% % gi=find(GA_M(:,1)==startDate);
% % ge=find(GA_M(:,1)==endDate);
% 
% 
% +0.0710 NAVD -> MSL

% h1=subplot(2,2,1);
% NOAA.mttotal_lp-CMEMS.mtssh_p_int

%% Dorian

figure(1)
clf

startDate = datenum('01-01-2019');
endDate = datenum('12-31-2019');

plot(NOAA.drtime,NOAA.drtotal_lp,'-b','linewidth',4); hold on
% plot(NOAA.drtime,NOAA.drresi,'-k','linewidth',4); hold on
% plot(NOAA.drtime,NOAA.drtide,'-r','linewidth',2); hold on

% % plot(S_MT.time,S_MT.total,'-r','linewidth', 2);hold on
% % plot(S_MT.time,S_MT.tide,'-.r','linewidth', 2);hold on
% % plot(S_MT.time,S_MT.surge,'-.m','linewidth', 2);hold on
% 
% plot(NOAA.drtime(NID),NOAA.drtotal_lp(NID)-CMEMS.drssh_p_int,'-m','linewidth', 2);

% plot(CMEMS.drtime,CMEMS.drssh_p,'-b','linewidth',2);
plot(NOAA.drtime(NID),CMEMS.drssh_p_int,'-r','linewidth',4);
ylabel('m')
set(gca,'YLim',[-1.5 2]);

yyaxis right
plot(NOAA.drtime(NID),NOAA.drtotal_lp(NID)-CMEMS.drssh_p_int,'-g','linewidth', 2);
ylabel('Error (NOAA-CMEMS)')
set(gca,'YColor','g');
set(gca,'YLim',[0 7]);

xlabel('Date (2019)')

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
% set(gca,'YLim',[-3 2.5],'YTick',[-3 -1 0 1 2]);
datetick('x','mmm-dd','keepticks')
% legend('TWL_{NOAA}','TWL_{mdl}','Tide_{NOAA}','Tide_{mdl}')
legend('Low-pass NOAA','CMEMS','Error')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 24)

%% mATTHEW

figure(2)
clf
startDate = datenum('01-01-2016');
endDate = datenum('12-31-2016');
% plot(NOAA.mttime,NOAA.mtresi,'-b','linewidth',2); hold on
plot(NOAA.mttime,NOAA.mttotal_lp,'-b','linewidth',4); hold on
% 
% % plot(S_MT.time,S_MT.total,'-r','linewidth', 2);hold on
% % plot(S_MT.time,S_MT.tide,'-.r','linewidth', 2);hold on
% % plot(S_MT.time,S_MT.surge,'-.m','linewidth', 2);hold on

% plot(CMEMS.mttime,CMEMS.mtssh_p,'-r','linewidth',2);
plot(NOAA.mttime(NIM),CMEMS.mtssh_p_int,'-r','linewidth',4);
ylabel('m')

yyaxis right
plot(NOAA.mttime(NIM),NOAA.mttotal_lp(NIM)-CMEMS.mtssh_p_int,'-g','linewidth', 2);
ylabel('Error (NOAA-CMEMS)')
set(gca,'YColor','g');

xlabel('Date (2016)')

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[0 7]);
datetick('x','mmm-dd','keepticks')
legend('Low-pass NOAA','CMEMS','Error')
% legend('NOAA_{total}-NOAA_{Tide}','Low-pass filter for NOAA','CMEMS_{SSH}')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 24)


